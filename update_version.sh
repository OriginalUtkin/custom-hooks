#!/usr/bin/env bash
red='\033[0;31m'

version_in_branch=$(cat VERSION)
echo $(git branch -a)

git worktree add master_state master
version_in_master=$(cat master_state/VERSION)

if [[ "$version_in_branch" == "$version_in_master" ]]
then
  echo "${red} VERSION file is not updated ${reset_color}"
  exit 1
else
  echo $(git branch -a)
  echo $(cat VERSION)
  echo  $(cat master_state/VERSION)

  exit 1

fi