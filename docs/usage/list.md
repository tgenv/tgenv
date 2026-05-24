---
title: tgenv list
---

# tgenv list

Lists every Terragrunt version installed locally and highlights the active one.

## Synopsis

```bash
tgenv list
```

## Example

```shell-session
$ tgenv list
* 1.0.5 (set by /home/user/project/.terragrunt-version)
  1.0.3
  0.99.5
  0.67.0
```

The asterisk (`*`) indicates the active version and the source file that
controls the selection (either a `.terragrunt-version` file or the global TGEnv
version file).

## Notes

- Versions are sorted in descending semantic-version order.
- If no version is installed, the command fails and suggests
  [`tgenv install`](./install.md).
