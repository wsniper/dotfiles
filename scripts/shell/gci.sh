#!/usr/bin/env bash

if [ -z "$EDITOR" ]; then
    EDITOR='vi'
fi
TMP_FILE=".git-commit.diff"

GitDiff=$(git diff --staged)

if [ -z "$GitDiff" ]; then
    echo "No file(s) staged."
    exit 1
fi

printf "\n\n\n\n# Please input commit message\n" > $TMP_FILE
echo "$GitDiff" >> $TMP_FILE

$EDITOR "$TMP_FILE"

msg=$(sed -n '1,3p' $TMP_FILE)
rm -f $TMP_FILE

if [ -z "$msg" ]; then
    echo "No commit message, aborting commit."
    exit 2
fi

git commit -m "$msg"

