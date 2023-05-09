#!/bin/bash

ACTION_REPO='SiemaApplications/vossloh-gh-actions'
ACTION_RE="${ACTION_REPO}"'/[^@]*@.*$'

help() {
    options="[-h|--help]"
    options="${options} [-s|--sha1 <SHA1]"
    echo "Usage: $(basename $0) ${options}"
    echo ""
    echo "Update SHA1 references in yaml workflow files."
    echo ""
    echo "    -s <SHA1>"
    echo "    --sha1 <SHA1>"
    echo "        sha1 to update to."
    echo "    -h"
    echo "    --help"
    echo "        Display this help and exit."

}

# Parse command line arguments
SHA1=""
PARAMS=""
while [ $# -gt 0 ]; do
    key="$1"
    case ${key} in
        -h|--help)
            help
            exit 0
            ;;
        -s|--sha1)
            SHA1=$2
            shift
            ;;
        *)
            PARAMS="${PARAMS} ${1}"
            shift
            ;;
    esac
done
eval set -- "${PARAMS}"
if [ -z "${SHA1}" ]; then
    SHA1=$(gh api -X GET -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/${ACTION_REPO}/commits -fsha=main -fper_page=1 | jq -r '.[0] | .sha')
fi

action_files=$(git grep -l ${ACTION_RE})
sed -i "s#\(${ACTION_REPO}/[^@]*\)@\(.*$\)#\1@${SHA1}#g" ${action_files}
