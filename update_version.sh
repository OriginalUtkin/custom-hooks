#!/usr/bin/env bash
red='\033[0;31m'


version_in_branch=$(cat VERSION)
echo "MR branch:" $version_in_branch

git fetch -q origin master
git worktree add -q master_state origin/master

version_in_master=$(cat master_state/VERSION)

echo "master:" $version_in_master

if [[ "$version_in_branch" == "$version_in_master" ]]
then
  echo "VERSION file is not updated"
  exit 1
fi