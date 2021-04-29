#!/usr/bin/env bash
version_in_branch=$(cat VERSION)

echo $version_in_branch

version_in_master=$(git checkout master | cat VERSION)

echo $version_in_master

if [[ "$version_in_branch" == "$version_in_master" ]]
then
  exit 0
else
  echo "${red} VERSION file is not updated ${reset_color}"
fi