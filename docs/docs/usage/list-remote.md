---
title: tgenv list-remote
---

# tgenv list-remote

Lists every Terragrunt version available for installation from the official
release repository.

## Synopsis

```bash
tgenv list-remote
```

## Example

```shell-session
$ tgenv list-remote
0.42.5
0.42.4
0.42.3
0.42.2
0.42.1
0.42.0
0.41.0
0.40.2
...
```

## Behavior

1. TGEnv runs `git ls-remote --tags` against the Terragrunt repository.
2. Tags are filtered to keep only valid `MAJOR.MINOR.PATCH` versions.
3. The result is sorted in descending order and cached at
   `~/.tgenv/list_all_versions_offline` so the previous output is available
   even when offline.

If the network call fails, TGEnv warns and continues, leaving the previous
cached list in place.
