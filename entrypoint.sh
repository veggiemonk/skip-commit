#!/usr/bin/env bash

# Exit immediately if a command returns a non-zero status.
set -e

# Get last commit message
readonly local last_commit_log=$(git log -1 --pretty=format:"%s")
echo "last commit log: $last_commit_log"

readonly local filter_count=$(echo "$last_commit_log" | grep -c "$COMMIT_FILTER" )
echo "number of occurence of '$COMMIT_FILTER' in '$last_commit_log': $filter_count"

if [[ "$filter_count" -eq 0 ]]; then
  echo "all good, continue"
else
  echo "the last commit log \"$last_commit_log\" contains \"$COMMIT_FILTER\", stopping"
  exit 78
fi
