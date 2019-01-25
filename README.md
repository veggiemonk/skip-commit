# GitHub Actions to skip based on commit message

If a commit message contains a string defined as the environment variable `$COMMIT_FILTER`, the action will stop.

For example:

```workflow
action "Skip" {
  uses = "veggiemonk/skip-commit@master"
  env = {
    COMMIT_FILTER = "\[skip-ci\]"
  }
}
```

If the last commit message contains the string `[skip-ci]`, the action will stop.
