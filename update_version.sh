#!/usr/bin/env bash

if [[ ("$1" == "poetry") ]]; then
  version_file="pyproject.toml"
  command="grep -E '^version'|sed 's/\"//g'|sed -E 's/version[[:blank:]]?=[[:blank:]]?//g'"

elif [[ ("$1" == "version_file") ]]; then
  version_file="VERSION"
  command="grep -E '[0-9.]+'"

else
  echo "Version type '$1' not supported"
  exit 1
fi

version_in_branch=$(eval "cat $version_file | $command")

git fetch -q origin master

version_in_master=$(eval "git show origin/master:$version_file | $command")

echo "Version in branch:" $version_in_branch
echo "Version in master:" $version_in_master

changed_files=$(git diff origin/master --summary --name-only |  grep -E $2)

if [[ ("$version_in_branch" == "$version_in_master") && (! -z $changed_files)]]
then
  echo "Version in $version_file file is not updated"
  exit 1
fi