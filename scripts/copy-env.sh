#! /bin/bash

DIR="$*"
if [ -z "${DIR}" ] ; then
	DIR="$(pwd)"
fi

while IFS= read -r -d '' env_file ; do
	out_file=${env_file//.env/.example.env}
	echo
	echo "env_file: ${env_file}"
	echo "out_file: ${out_file}"
	sed \
		-e 's/^\(SECRETS_[A-Z_]*\)=.*$/\1=/g' \
		-e 's/^\([# ]*SECRETS_[A-Z_]*\)=.*$/\1=/g' \
		"${env_file}" \
			> "${out_file}"
		#| sed 's/^/  /'
	#sed \
	#	-e 's/^_HYPERION_SECRETS_\(.*\)=.*$/_HYPERION_SECRETS_\1=/g' \
	#	"${DIR}/../env-parts/secrets.env" > "${DIR}/../env-parts/secrets.env.example"
done < <(find "${DIR}" -name "*.env" -type f -not -name "*.example.env" -not -name ".env" -print0)
