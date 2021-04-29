#!/usr/bin/env bash
red='\033[0;31m'
1>&2 echo $(git branch)
version_in_branch=$(cat VERSION)
git worktree add master_state master
version_in_master=$(cat master_state/VERSION)

if [[ "$version_in_branch" == "$version_in_master" ]]
then
  echo "${red} VERSION file is not updated ${reset_color}"
  exit 1
else
  exit 0
fi