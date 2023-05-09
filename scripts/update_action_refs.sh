#!/bin/bash

ACTION_REPO='SiemaApplications/vossloh-gh-actions'
ACTION_RE="${ACTION_REPO}"'/[^@]*@.*$'

help() {
    options="[-h|--help]"
    echo "Usage: $(basename $0) <action sha1>"
    echo ""
    echo "Update SHA1 references in yaml workflow files."
    echo ""
    echo "    action sha1"
    echo "        sha1 to update to."
    echo "    -h"
    echo "    --help"
    echo "        Display this help and exit."

}

# Parse command line arguments
PARAMS=""
while [ $# -gt 0 ]; do
    key="$1"
    case ${key} in
        -h|--help)
            help
            exit 0
            ;;
        *)
            PARAMS="${PARAMS} ${1}"
            shift
            ;;
    esac
done
eval set -- "${PARAMS}"
if [ -z "$1" ]; then
    echo "error: Missing sha1 of action to use"
    help
    exit 1
fi
SHA1="$1"

action_files=$(git grep -l ${ACTION_RE})
sed -i "s#\(${ACTION_REPO}/[^@]*\)@\(.*$\)#\1@${SHA1}#g" ${action_files}
