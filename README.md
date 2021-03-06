# GitHub Actions to skip based on commit message (UNMAINTAINED)

If the last commit message contains the string `skip-ci`, the action will stop.

You might want to check out this repository: https://github.com/styfle/cancel-workflow-action

## Just use YAML (recommended)

Thank to [@smnbbrv](https://github.com/smnbbrv) who kindly shared this solution with us [here](https://github.com/veggiemonk/skip-commit/issues/5)

```yaml
jobs:
  main:
    name: Build and test
    runs-on: ubuntu-latest
    if: "!contains(github.event.head_commit.message, 'ci skip')"
```

## Just use BASH

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

## Or use the container (not recommended / deprecated)

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


