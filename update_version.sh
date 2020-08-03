#!/usr/bin/env bash
yellow='\033[0;33m'
reset_color='\033[0m'

current_branch=$(git branch --show-current)
changed=$(git diff --name-only $current_branch $(git merge-base $current_branch "master"))
echo $changed


if [[ -z $(git diff VERSION) && -z $(grep "VERSION" <<< echo $changed) && (-n $(git status | grep "$1*") || -n $changed) ]]
then
    old_version=$(git diff VERSION | grep "^\-[1-9].[0-9].[0-9]" | cut -c2-6)
    new_version=$(git diff VERSION | grep "^\+[1-9].[0-9].[0-9]" | cut -c2-6)
    echo -e "${yellow} [WARNING] VERSION file wasn't changed. Version will be set automatically.${reset_color}"

    exit 1
else

    exit 0
fi