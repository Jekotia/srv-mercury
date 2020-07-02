#! /bin/bash
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
declare -a ARGS
for arg in "$@" ; do
	case $arg in
		--debug) _DEBUG="true";;
		*) ARGS+=("$arg") ;;
	esac
done


#>> FUNCTIONS
	function debug() {
		local var_name
		local var_value
		if [[ "$_DEBUG" == "true" ]] ; then
			case $1 in
				-v)
					shift
					###var_declare="$(declare -p "$1" | sed 's|declare\s\-\-\s\(.*\)|\1|')"
					###var_name="$(echo $var_declare | sed 's|||')"
					###var_value="$(declare -p "$var_name" | sed 's|declare\s\-\-\s\(.*\)|\1|')"

					var_name="$1"
					var_value="$(declare -p "$var_name" | sed 's|declare\s\-\-\s\(.*\)|\1|')"
					printf "DEBUG: %20s: %s\n" "${var_name}" "${var_value}" >&2
				;;
				*)
					echo "DEBUG: $*" >&2
				;;
			esac
		fi
	}
	function newline_at_eof() {
		if [ -z "$(tail -c 1 "$1")" ] ; then
			debug "Newline at end of file!"
			return 0
		else
			debug "No newline at end of file!"
			return 1
		fi
	}
	function merge_fail() {
		file_in="$1" ; debug -v "file_in"
		file_out="$2" ; debug -v "file_out"
		echo "Failed to append '${file_in}' to ${file_out}"
	}
	function file_merge() {
		file_in="$1" ; debug -v "file_in"
		file_in_short="$(get_relative_path "${file_in}")" ; debug -v "file_in_short"
		file_out="$2" ; debug -v "file_out"
		file_out_short="$(get_relative_path "${file_out}")" ; debug -v "file_out_short"

		debug "Merging '${file_in_short}' into '${file_out_short}'"

		# Append empty line if the last line of the file isn't empty
		if ! newline_at_eof "${file_out}" ; then
			debug "Appending empty line"
			echo "" >> "${file_out}" \
			|| { merge_fail "${file_in_short}" "${file_out_short}" ; return 1; }
		fi

		#TODO: handle other instances of non-empty trailing lines

		echo "# BEGIN -> ${file_in_short}" >> "${file_out}" \
		|| { merge_fail "${file_in_short}" "${file_out_short}" ; return 1; }
		
		sed -e 's/^[# ]*\(.*=.*\)$/\1/g' "${file_in}" \
				>> "${file_out}" \
		|| { merge_fail "${file_in_short}" "${file_out_short}" ; return 1; }

		if ! newline_at_eof "${file_out}" ; then
			echo "Appending empty line"
			echo "" >> "${file_out}" \
			|| { merge_fail "${file_in_short}" "${file_out_short}" ; return 1; }
		fi

		echo "# END -> ${file_in_short}" >> "${file_out}" \
		|| { merge_fail "${file_in_short}" "${file_out_short}" ; return 1; }
		
		echo "" >> "${file_out}" \
		|| { merge_fail "${file_in_short}" "${file_out_short}" ; return 1; }

		debug "Appended '${file_in_short}' to ${file_out_short}"

		return 0
	}
	# Strip the INPUT_DIR from a file path
	function get_relative_path() {
		echo "${*//$INPUT_DIR\//}"
		#path="$*"
		#echo "${path//$INPUT_DIR\//}"
		#echo "$*" | sed 's,'"${INPUT_DIR}"'/\(.*\),\1,g'
	}
	function get_absolute_path() {
		if [[ -d "$1" ]] ; then
			pushd "$1" >/dev/null || exit 1
			pwd
			popd >/dev/null || exit 1
		elif [[ -e $1 ]] ; then
			pushd "$(dirname "$1")" >/dev/null || exit 1
			echo "$(pwd)/$(basename "$1")"
			popd >/dev/null || exit 1
		else
			echo "$1" does not exist! >&2
			return 127
		fi
	}
#<< FUNCTIONS

#>> SETUP
	debug "BEGIN SETUP"
	#>> ARGS
		debug "BEGIN ARGS"
		ARG_INDEX=0
		ARG_COUNT=${#ARGS[@]}

		debug -v "ARG_COUNT"
		#-> Decrease by one to match index beginning at 0
		ARG_COUNT=$((ARG_COUNT - 1))
		debug

		while [ ${ARG_INDEX} -le ${ARG_COUNT} ] ; do
			debug -v "ARG_INDEX"
			arg="${ARGS[$ARG_INDEX]}"
			debug -v "arg"
			case ${arg} in
				--input)
					if [ -z "${INPUT_DIR}" ] ; then
						ARG_INDEX=$((ARG_INDEX + 1))

						value="${ARGS[$ARG_INDEX]}"
						debug -v "value"

						INPUT_DIR="${value%/}"

					else
						echo "--input can only be provided once."
						exit 1
					fi
				;;
				--output)
					if [ -z "${OUTPUT_DIR}" ] ; then
						ARG_INDEX=$((ARG_INDEX + 1))

						value="${ARGS[$ARG_INDEX]}"
						debug -v "value"

						OUTPUT_DIR="${value%/}"

					else
						echo "--output can only be provided once."
						exit 1
					fi
				;;
				*)
					echo "Arg not supported: '${arg}'"
					exit 1
				;;
			esac
			ARG_INDEX=$((ARG_INDEX + 1))
			debug ""
		done
		debug "END ARGS"
	#<< ARGS
	#>> VARS
		debug "BEGIN VARS"
		if [ -z "${INPUT_DIR}" ] ; then
			INPUT_DIR="$(pwd)"
		fi
		INPUT_DIR="$(get_absolute_path "${INPUT_DIR}")" ; debug -v "INPUT_DIR"

		if [ -z "${OUTPUT_DIR}" ] ; then
			OUTPUT_DIR="${INPUT_DIR}"
		fi
		OUTPUT_DIR="$(get_absolute_path "${OUTPUT_DIR}")" ; debug -v "OUTPUT_DIR"

		declare -a ENV_PARTS=(
			"common.env"
			"secrets.env"
		)
		declare -a COMPOSE_PARTS
		declare -a COMPOSE_STRING

		COMPOSE_PARTS_DIR="${INPUT_DIR}/compose-parts" ; debug -v "COMPOSE_PARTS_DIR"
		ENV_PARTS_DIR="${INPUT_DIR}/env-parts" ; debug -v "ENV_PARTS_DIR"

		ENV_OUTPUT_TEMP="$(mktemp /tmp/compose-manager.env.tmp.XXXXXXXXXX)" ; debug -v "ENV_OUTPUT_TEMP"
		ENV_OUTPUT_FILE="${OUTPUT_DIR}/.env" ; debug -v "ENV_OUTPUT_FILE"
		COMPOSE_OUTPUT_TEMP="$(mktemp /tmp/compose-manager.compose.tmp.XXXXXXXXXX)" ; debug -v "COMPOSE_OUTPUT_TEMP"
		COMPOSE_OUTPUT_FILE="${OUTPUT_DIR}/docker-compose.yml" ; debug -v "COMPOSE_OUTPUT_FILE"
		debug "END VARS"
	#<< VARS
	if [ ! -d "${OUTPUT_DIR}" ] ; then
		mkdir -p "${OUTPUT_DIR}"
	fi

	cd "${INPUT_DIR}" || exit 1
	debug "END SETUP"
#<< SETUP

#>> LOOP_OVER_STATIC_ENV_FILES
	debug "BEGIN LOOP_OVER_STATIC_ENV_FILES"
	for env_file in "${ENV_PARTS[@]}" ; do
		#env_file=$(get_absolute_path "${env_file}")
		env_file="${ENV_PARTS_DIR}/${env_file}"
		debug -v env_file
		if [ -e "${env_file}" ] ; then
			debug "env_file exists"
			env_file_short="$(get_relative_path "${env_file}")"
			env_file_short="${env_file_short//env-parts\//}"
			echo "Using     ENV file ${env_file_short}"
			file_merge "$env_file" "${ENV_OUTPUT_TEMP}" || exit 1
		fi
	done
	debug "END LOOP_OVER_STATIC_ENV_FILES"
#<< LOOP_OVER_STATIC_ENV_FILES

#>> LOOP_OVER_COMPOSE_FILES
	while IFS= read -r -d '' compose_file ; do
		#>> COMPOSE
			debug -v "compose_file"
			COMPOSE_PARTS+=("$compose_file")
			COMPOSE_STRING+=("-f $compose_file")
			compose_file_short="$(get_relative_path "${compose_file}")"
			compose_file_short="${compose_file_short//compose-parts\//}"
			echo "Using COMPOSE file ${compose_file_short}"
		#<< COMPOSE
		#>> ENV
			#TODO: Merge sed commands into single instance
			env_file="$(echo "$compose_file" | sed "s|$COMPOSE_PARTS_DIR\(.*\)|$ENV_PARTS_DIR\1|" | sed "s|\(.*\)\.production\.yml|\1.env|")"
			debug -v "env_file"
			if [ -e "$env_file" ] ; then
				#TODO: Ditch separate env file, pass the component files as args to docker-compose
				#ENV_STRING+=("--env-file=${env_file}")
				env_file_short="$(get_relative_path "${env_file}")"
				env_file_short="${env_file_short//env-parts\//}"
				echo "          ENV file ${env_file_short}"
				file_merge "$env_file" "${ENV_OUTPUT_TEMP}" || exit 1
			fi
		#<< ENV
		debug ""
	done < <(find "$COMPOSE_PARTS_DIR" -name "*.production.yml" -type f -print0)
#<< LOOP_OVER_COMPOSE_FILES

if mv "${ENV_OUTPUT_TEMP}" "${ENV_OUTPUT_FILE}" ; then
	debug "Moved '${ENV_OUTPUT_TEMP}' to '${ENV_OUTPUT_FILE}'"
	echo ".env values have been compiled in '${ENV_OUTPUT_FILE}'"
else
	echo "ERROR: Unable to move '${ENV_OUTPUT_TEMP}' to '${ENV_OUTPUT_FILE}'"
	exit 1
fi

source /etc/environment

#shellcheck disable=SC2068
if docker-compose ${COMPOSE_STRING[@]} config > "${COMPOSE_OUTPUT_TEMP}" ; then 
	if mv "${COMPOSE_OUTPUT_TEMP}" "${COMPOSE_OUTPUT_FILE}" ; then
		debug "Moved '${COMPOSE_OUTPUT_TEMP}' to '${COMPOSE_OUTPUT_FILE}'"
		echo "docker-compose data has been compiled in '${COMPOSE_OUTPUT_FILE}'"
	else
		echo "ERROR: Unable to move '${COMPOSE_OUTPUT_TEMP}' to '${COMPOSE_OUTPUT_FILE}'"
		exit 1
	fi
fi