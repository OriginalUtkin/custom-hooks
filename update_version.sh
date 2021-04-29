#!/usr/bin/env bash

version_in_branch=$(cat VERSION)
git worktree add master_state
version_in_master=$(cat master_state/VERSION)

if [[ "$version_in_branch" == "$version_in_master" ]]
then
  echo "${red} VERSION file is not updated ${reset_color}"
  exit 1
else
  exit 0
fi