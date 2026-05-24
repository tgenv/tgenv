---
title: tgenv use
---

# tgenv use

Switches the active Terragrunt version. Only versions previously installed are
eligible.

## Synopsis

```bash
tgenv use [<version>]
```

## Arguments

- `<version>` — Optional. A literal version, `latest`, or `latest:<regex>` that
  matches an already installed version.

If no argument is provided, TGEnv first looks for a `.terragrunt-version` file
walking up the directory tree. If none is found, it falls back to `latest`.

## Examples

```bash
tgenv use 1.0.5
tgenv use latest
tgenv use latest:^1.0
```

## Behavior

1. TGEnv lists the locally installed versions and selects the highest one that
   matches the constraint.
2. The selected version is written to the active version file (either
   `.terragrunt-version` in the resolved directory or the global TGEnv version
   file).
3. `terragrunt --version` is invoked to validate the switch.

If no installed version matches the request, the command fails with a clear
error message. Use [`tgenv install`](./install.md) first to download the desired
version.
