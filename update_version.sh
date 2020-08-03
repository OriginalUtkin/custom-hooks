#!/usr/bin/env bash

old_version=$(git diff VERSION | grep "^\-[1-9].[0-9].[0-9]" | cut -c2-6)
new_version=$(git diff VERSION | grep "^\+[1-9].[0-9].[0-9]" | cut -c2-6)

if [[ -z $(git diff VERSION) && -n $(git status | grep "$1*") ]]
then
    echo "[ERROR] VERSION file wasn't changed. Current version "
    exit 1
else
    echo "[OK] VERSION file was changed: $old_version -> $new_version"
fi

exit 0