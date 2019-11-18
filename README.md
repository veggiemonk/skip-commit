# GitHub Actions to skip based on commit message

## Just use bash

```yaml
  - name: should it be skipped?
    env:
      COMMIT_FILTER: "skip-ci"
    run: | 
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
```

## Or use the container

If a commit message contains a string defined as the environment variable `$COMMIT_FILTER`, the action will stop.

For example:

```workflow
action "Skip" {
  uses = "veggiemonk/skip-commit@master"
  env = {
    COMMIT_FILTER = "skip-ci"
  }
}
```

#### If the last commit message contains the string `skip-ci`, the action will stop.
