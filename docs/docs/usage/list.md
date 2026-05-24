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
* 0.42.5 (set by /home/user/project/.terragrunt-version)
  0.40.2
  0.12.15
  0.10.0
```

The asterisk (`*`) indicates the active version and the source file that
controls the selection (either a `.terragrunt-version` file or the global TGEnv
version file).

## Notes

- Versions are sorted in descending semantic-version order.
- If no version is installed, the command fails and suggests
  [`tgenv install`](./install.md).
