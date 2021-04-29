#!/usr/bin/env bash
version_in_branch=$(cat VERSION)

echo $version_in_branch

version_in_master=$(git worktree master_state | cd master_state | cat VERSION)

echo $version_in_master

if [[ "$version_in_branch" == "$version_in_master" ]]
then
  echo "${red} VERSION file is not updated ${reset_color}"
  exit 1
else
  exit 0
fi