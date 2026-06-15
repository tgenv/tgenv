---
title: Installation
---

# Installation

TGEnv is distributed as a Git repository. Installing it is a two-step process:
clone the repository and expose its `bin` directory through your `PATH`.

> **Windows users:** TGEnv runs on Windows through
> [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/en-us/windows/wsl/).
> Follow the steps below inside your WSL terminal — the installation process is
> identical to Linux. TGEnv detects WSL as a Linux environment and installs the
> correct Linux binary automatically.

## Homebrew (macOS and Linux)

The repository ships a Homebrew formula. Add the tap and install:

```bash
brew tap tgenv/tgenv
brew install tgenv
```

## Manual Installation

Clone the latest version of TGEnv into your home directory:

```bash
git clone --depth 1 --branch main https://github.com/tgenv/tgenv.git ~/.tgenv
```

To pin a specific release, replace `main` with a tag name:

```bash
git clone --depth 1 --branch v1.2.1 https://github.com/tgenv/tgenv.git ~/.tgenv
```

## Add TGEnv to Your PATH

### Bash

Append `~/.tgenv/bin` to your `PATH`:

```bash
echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.bash_profile
```

Reload your shell or `source` the file so the change takes effect.

Alternatively, on Linux and macOS you can symlink the binaries into a directory
already on your `PATH`, for example `/usr/local/bin`:

```bash
ln -s ~/.tgenv/bin/* /usr/local/bin
```

### Zsh

Append `~/.tgenv/bin` to your `PATH`:

```bash
echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.zshrc
```

If you use [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh), reload your shell:

```bash
omz reload
```

## Verify the Installation

Run TGEnv without arguments to confirm it is on your `PATH`:

```bash
tgenv
```

You should see the version banner followed by the help text. From this point on
you can [install a Terragrunt version](./usage/install.md).
