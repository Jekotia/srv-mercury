#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${DIR}" || exit 1

#declare -a COMPOSE_FILES=()
declare -a COMPOSE_FILES
declare -a ARGS=( "$@" )

for file in ./*.production.yml ; do
	COMPOSE_FILES+=(-f "${file}")
done

docker-compose \
	"${COMPOSE_FILES[@]}" \
	"${ARGS[@]}"
