---
title: Architecture
---

# Architecture

TGEnv is intentionally small. Understanding its layout helps when debugging,
extending it or reviewing pull requests.

## Repository Layout

```
tgenv/
├── bin/
│   ├── tgenv          # Main entry point and dispatcher
│   └── terragrunt     # Shim that delegates to the active version
├── libexec/
│   ├── helpers        # Shared logging and HTTP helpers
│   ├── tgenv-install
│   ├── tgenv-use
│   ├── tgenv-list
│   ├── tgenv-list-remote
│   ├── tgenv-uninstall
│   ├── tgenv-upgrade
│   ├── tgenv-version-file
│   ├── tgenv-version-name
│   ├── tgenv-help
│   └── tgenv---version
├── docs/
│   ├── index.md           # Markdown documentation pages
│   ├── installation.md
│   ├── usage/
│   ├── img/               # Static assets (logo, favicon)
│   └── ...
├── mkdocs.yml             # MkDocs site configuration and navigation
├── list_all_versions_offline   # Cached remote release list
├── test/                       # Bash test harness
└── assets/                     # Logo and branding
```

## Command Dispatch

`bin/tgenv` is the user-facing entry point. It performs three jobs:

1. Resolves `TGENV_ROOT` from the symlink target so the script works from any
   `PATH` location.
2. Prepends `libexec/` to `PATH` so subcommands are discoverable as
   `tgenv-<subcommand>` executables.
3. Forwards the first positional argument to the matching `tgenv-<subcommand>`
   script (for example `tgenv install` runs `libexec/tgenv-install`).

Each subcommand is a self-contained Bash script. Adding a new command means
dropping a new `tgenv-<name>` script under `libexec/`.

## The Terragrunt Shim

`bin/terragrunt` is a thin wrapper that runs every time the user invokes
`terragrunt`. The shim:

1. Resolves the active version via `tgenv-version-name`, which honors
   `.terragrunt-version`, the global version file and `latest` constraints.
2. Auto-installs the requested version if it is missing and
   `TGENV_AUTO_INSTALL` is not `false`.
3. `exec`s the matching binary located at
   `~/.tgenv/versions/<version>/terragrunt` with the original arguments.

This indirection keeps the user-facing command stable while the underlying
binary changes per project.

## Version Resolution

The `tgenv-version-file` helper walks up the directory tree from `$PWD` looking
for a `.terragrunt-version` file. If none is found, it tries the user `HOME`
directory and finally falls back to the global `~/.tgenv/version`. The
`tgenv-version-name` helper reads that file and resolves any `latest` or
`latest:<regex>` expression against the installed versions.

## Logging Helpers

`libexec/helpers` provides four log levels:

- `info` — green, written to stdout
- `warn_and_continue` — yellow, written to stderr
- `error_and_die` — red, written to stderr, exits non-zero
- `debug` — blue, only printed when `TGENV_DEBUG` is set

Colors are suppressed when `TGENV_DISABLE_COLOR=1`.

## HTTP Helper

`libexec/helpers` also exposes `curlw`, a thin wrapper around `curl` that
toggles `--tlsv1.2` for older macOS versions. Every download goes through this
helper so TLS handling is consistent.

## Testing

The `test/` directory contains Bash tests that are executed both inside Docker
images (Alpine, Ubuntu, Fedora) and natively on macOS through GitHub Actions.
The CI pipeline also runs `shellcheck` against `bin/`, `libexec/` and `test/`.
