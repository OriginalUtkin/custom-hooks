#!/usr/bin/env bash
version_in_branch=$(cat VERSION)

echo $version_in_branch

version_in_master=$(git add -f worktree master_state | cat master_state/VERSION)

echo $version_in_master

if [[ "$version_in_branch" == "$version_in_master" ]]
then
  echo "${red} VERSION file is not updated ${reset_color}"
  exit 1
else
  exit 0
fi