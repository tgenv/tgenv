---
title: tgenv install
---

# tgenv install

Installs a specific version of Terragrunt and switches to it.

## Synopsis

```bash
tgenv install [<version>]
```

## Arguments

- `<version>` — Optional. A literal version (`1.0.5`), the keyword `latest`,
  or a `latest:<regex>` constraint. The regex is evaluated by `grep -e`.

If no argument is provided and a `.terragrunt-version` file exists in the current
directory tree, TGEnv installs the version declared in it.

## Examples

Install an exact version:

```bash
tgenv install 1.0.5
```

Install the most recent stable release:

```bash
tgenv install latest
```

Install the latest version matching a regex (here, the latest `1.0.x`):

```bash
tgenv install latest:^1.0
```

Install the version pinned by `.terragrunt-version`:

```bash
tgenv install
```

## Behavior

1. TGEnv resolves the requested version against the remote release list.
2. The matching binary is downloaded from the official Terragrunt release page
   on GitHub.
3. The binary is placed under `~/.tgenv/versions/<version>/terragrunt` and made
   executable.
4. TGEnv automatically switches the active version to the one just installed
   (equivalent to running `tgenv use <version>` afterwards).

## Architecture Detection

TGEnv detects the host OS and CPU architecture automatically:

| OS       | Architectures           |
|----------|-------------------------|
| Linux    | `amd64`, `arm64`        |
| macOS    | `darwin_amd64`, `darwin_arm64` |

You can override the architecture by exporting `TGENV_ARCH` before running the
command.
