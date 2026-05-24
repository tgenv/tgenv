---
title: tgenv uninstall
---

# tgenv uninstall

Removes a previously installed Terragrunt version from your system.

## Synopsis

```bash
tgenv uninstall [<version>]
```

## Arguments

- `<version>` — Optional. A literal version, `latest`, or `latest:<regex>` that
  matches an installed version.

If no argument is provided, TGEnv reads the version from the resolved
`.terragrunt-version` file.

## Examples

```bash
tgenv uninstall 0.12.1
tgenv uninstall latest
tgenv uninstall latest:^0.9
```

## Behavior

1. TGEnv selects the highest installed version matching the constraint.
2. The directory `~/.tgenv/versions/<version>` is removed.
3. The active version file is **not** updated automatically. If you uninstall
   the version currently in use, run [`tgenv use`](./use.md) afterwards to switch
   to a version that still exists.
