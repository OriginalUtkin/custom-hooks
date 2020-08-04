#!/usr/bin/env bash
yellow='\033[0;33m'
reset_color='\033[0m'

current_branch=$(git branch --show-current)
echo $current_branch
changed=$(git diff --name-only HEAD~ HEAD )
echo $changed

version_changed=$(grep "VERSION" <<< echo $changed)
files_changed=$(grep "$1" <<< $changed)

echo $version_changed
echo $files_changed


if [[ -z $(git diff VERSION) && -z $version_changed && (-n $(git status | grep "$1*") || -n $files_changed) ]]
#if [[ -z $version_changed &&  -n $files_changed ]]
then

    echo -e "${yellow} [WARNING] VERSION file wasn't updated.${reset_color}"

    exit 1
else

    exit 0
fi