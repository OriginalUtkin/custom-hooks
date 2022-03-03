#!/usr/bin/env bash

if [[ ("$2" == "poetry") || (("$2" == "") && ( -f pyproject.toml)) ]]; then
  version_file="pyproject.toml"
  command="poetry version -s"
elif [[ ("$2" == "version_file") || (("$2" == "") && ( -f VERSION)) ]]; then
  version_file="VERSION"
  command="cat VERSION"
else
  echo "Version type '$2' not supported"
  exit 1
fi

tfile=$(mktemp $version_file.XXXXXXXXX)
mv $version_file $tfile
git fetch -q origin master
git restore --source master -q -- $version_file
version_in_master=$($command)
mv $tfile $version_file
version_in_branch=$($command)

echo "Version in branch:" $version_in_branch
echo "Version in master:" $version_in_master

changed_files=$(git diff origin/master --summary --name-only |  grep -E $1)

if [[ ("$version_in_branch" == "$version_in_master") && (! -z $changed_files)]]
then
  echo "VERSION file is not updated"
  exit 1
fi