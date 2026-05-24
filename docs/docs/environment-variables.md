---
title: Environment Variables
---

# Environment Variables

TGEnv reads a small set of environment variables to fine-tune its behavior.

## TGENV_AUTO_INSTALL

- **Type:** string
- **Default:** `true`

Controls whether TGEnv installs the requested Terragrunt version automatically
when it is not yet present locally. Set it to `false` to require an explicit
`tgenv install` call.

```bash
TGENV_AUTO_INSTALL=false terragrunt plan
```

## TGENV_DEBUG

- **Type:** string
- **Default:** unset

Enables shell tracing for every TGEnv command. When set to any non-empty value,
TGEnv runs with `set -x` and prefixes each line with the source file and line
number (`PS4='+ [${BASH_SOURCE##*/}:${LINENO}] '`). Useful when reporting bugs.

```bash
TGENV_DEBUG=1 tgenv install latest
```

## TGENV_DISABLE_COLOR

- **Type:** integer-like flag
- **Default:** unset

Disables colored output. Set to `1` to force plain text. The variable is also
honored by the Terragrunt shim when the `-no-color` flag is detected on the
command line.

```bash
TGENV_DISABLE_COLOR=1 tgenv list
```

## TGENV_ARCH

- **Type:** string
- **Default:** auto-detected (`amd64` or `arm64`)

Overrides the CPU architecture used to build the download URL. Useful when you
want to install a binary for an architecture that does not match the host (for
example, downloading the `amd64` binary on an Apple Silicon machine to run it
under Rosetta).

```bash
TGENV_ARCH=amd64 tgenv install latest
```

## TGENV_ROOT

- **Type:** path
- **Default:** the directory containing the `tgenv` script (`~/.tgenv` by
  convention)

Overrides where TGEnv stores its data: installed versions, the version file
and the offline release cache. Set it if you want to keep multiple TGEnv
installations side by side or relocate the data directory.

```bash
export TGENV_ROOT="/opt/tgenv"
```
