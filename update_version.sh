#!/usr/bin/env bash
red='\033[0;31m'
reset_color='\033[0m'

old_version=$(git diff VERSION | grep "^\-[1-9].[0-9].[0-9]" | cut -c2-6)
new_version=$(git diff VERSION | grep "^\+[1-9].[0-9].[0-9]" | cut -c2-6)

if [[ -z $(git diff VERSION) && -n $(git status | grep "$1*") ]]
then
    echo -e "${red} [ERROR] VERSION file wasn't changed. Current version.${reset_color}"
    exit 1
else
    exit 0
fi