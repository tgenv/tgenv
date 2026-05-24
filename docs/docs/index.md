---
title: Introduction
---

# Introduction

**TGEnv** is a [Terragrunt](https://terragrunt.gruntwork.io/) version manager
inspired by the [tfenv](https://github.com/tfutils/tfenv) project. It lets you
install, switch and manage multiple Terragrunt versions from a single shell
environment.

This project was forked from the original
[cunymatthieu/tgenv](https://github.com/cunymatthieu/tgenv) repository to keep
the tool maintained and up to date.

## Why TGEnv

Terragrunt evolves quickly and different projects often pin different versions.
TGEnv solves this without container overhead or heavy runtimes: it is a small
collection of shell scripts that download official Terragrunt binaries on demand
and expose the active version through a thin shim on your `PATH`.

## Features

- Install any released Terragrunt version, or the latest matching a regex.
- Switch versions globally or per project.
- Detect a `.terragrunt-version` file walking up from the current directory.
- Auto-install the requested version when missing (configurable).
- List installed and remotely available versions.
- Self-upgrade through `tgenv upgrade`.

## Supported Platforms

TGEnv currently supports the following operating systems:

- macOS (Intel, 64-bit)
- macOS (Apple Silicon, arm64)
- Linux (64-bit, amd64 and arm64)

Continuous integration runs the test suite on Alpine, Ubuntu, Fedora and macOS.

## Requirements

- `bash` 4 or newer
- `curl`
- `git`
- Standard POSIX utilities (`grep`, `sed`, `awk`, `sort`, `cut`, `tee`)

## Next Steps

- [Install TGEnv](./installation.md)
- [Install your first Terragrunt version](./usage/install.md)
- [Pin a version per project](./terragrunt-version-file.md)
