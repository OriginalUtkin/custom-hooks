#!/usr/bin/env bash

function is_output_valid() {
    line_numbers=$(eval "echo $1 | wc -l")
    is_version_correct=$(eval "echo $1 | grep -E '[0-9.]?'")

    if [[ ($line_numbers -eq 1)  && (! -z $is_version_correct)]]; then
        return 0
    else
        return 1
    fi

}

if [[ ("$1" == "poetry") ]]; then
  version_file="pyproject.toml"
  command="sed 's/[\ \"]*//g' | grep -E '(^\[tool\.poetry\])|(^version)' | sed -E 's/\[tool.poetry\]//g' | sed -E 's/version[[:blank:]]?=[[:blank:]]?//g'"

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

if (! is_output_valid $version_in_branch) || (! is_output_valid $version_in_master); then
    echo "Version update is not correct"
    exit 1
fi

echo "Version in branch:" $version_in_branch
echo "Version in master:" $version_in_master

changed_files=$(git diff origin/master --summary --name-only |  grep -E $2)

if [[ ("$version_in_branch" == "$version_in_master") && (! -z $changed_files)]]
then
  echo "Version in $version_file file is not updated"
  exit 1
fi
