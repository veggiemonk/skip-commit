#!/bin/sh

# Exit immediately if a command returns a non-zero status.
set -e

commit_filter=${COMMIT_FILTER:-"\[skip ci\]"}

# Get last commit message
last_commit_log=$(git log -1 --pretty=format:"%s")

filter_count=$(echo "$last_commit_log" | grep -c "$commit_filter")

[ "$filter_count" -ne 0 ] && {
  echo "the last commit log \"$last_commit_log\" contains \"$commit_filter\", stopping"
  exit 78
}

