---
id: terragrunt-version-file
title: The .terragrunt-version File
sidebar_position: 4
---

# The .terragrunt-version File

TGEnv supports a per-project version file named `.terragrunt-version`. When you
run any TGEnv-aware command from inside a directory tree containing this file,
the version it declares becomes the active one.

## Resolution Rules

When TGEnv needs to determine the active version, it walks up the directory tree
starting from `$PWD` and stops at the first `.terragrunt-version` it finds. If
none is found, it falls back to the user `HOME` directory and finally to the
global TGEnv version file at `~/.tgenv/version`.

## Accepted Values

The file must contain a single line with one of:

- A literal version, for example `0.42.5`.
- The keyword `latest`.
- A regex constraint with the `latest:<regex>` syntax. The regex is evaluated by
  `grep -e` against the locally installed versions.

## Examples

Pin a project to an exact version:

```bash
echo 0.42.5 > .terragrunt-version
```

Track the latest installed `0.10.x`:

```bash
echo latest:^0.10 > .terragrunt-version
```

Use the most recent installed release:

```bash
echo latest > .terragrunt-version
```

## Interaction with Auto-Install

If the version declared by `.terragrunt-version` is not installed locally,
TGEnv installs it automatically the first time it is needed. This behavior is
controlled by the [`TGENV_AUTO_INSTALL`](./environment-variables#tgenv_auto_install)
environment variable.

## Recommended Workflow

1. Commit `.terragrunt-version` to your repository.
2. New contributors only need to install TGEnv. Their first `terragrunt`
   invocation downloads and pins the correct version automatically.
3. Bump the version by editing the file and running `tgenv install` so every
   developer can move in lockstep.
