#!/usr/bin/env bash
red='\033[0;31m'

if [[ -z $(git diff CHANGELOG.$1) && -n $(git status | grep "$2*") ]]
then
    echo -e "${red} [ERROR] Changelog file was not changed! Add changes that were done in the repository to the CHANGELOG.$1"
    exit 1
else
    exit 0
fi

