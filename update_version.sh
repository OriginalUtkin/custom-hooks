#!/usr/bin/env bash
version_in_branch=$(cat VERSION)
echo "MR branch:" $version_in_branch

git fetch -q origin master

version_in_master=$(git show origin/master:VERSION)

echo "master:" $version_in_master

changed_files=$(git diff origin/master --summary --name-only |  grep "kw/proton3\|requirements.*")

if [[ ("$version_in_branch" == "$version_in_master") && (! -z $changed_files)]]
then
  echo "VERSION file is not updated"
  exit 1
fi