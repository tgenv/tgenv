# TGENV - Terragrunt Version Manager

![Tests](https://github.com/tgenv/tgenv/actions/workflows/tests.yml/badge.svg?branch=main)

![lixnux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black) ![macos](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white) ![shell](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)

![tgenvlogo](/assets/tgenv-logo.png)

This project was forked from old project [cunymatthieu/tgenv](https://github.com/cunymatthieu/tgenv). The intention here it's keep the project alive.

>[Terragrunt](https://github.com/gruntwork-io/terragrunt) version manager inspired by [tfenv](https://github.com/kamatama41/tfenv) project.


## Support :computer:

Currently tgenv supports the following OSes
- Mac OS X (64bit)
- Mac OS M1 (arm64)
- Linux (64bit)

---

## Summary :bookmark: 

1. [Installation](#installation-🔧)
    1. [Cloning the repository](#1-cloning-the-repository)
    2. [Export PATH](#2-export-to-path)
         1. [Bash](#bash)
         2. [ZSH](#zsh)
2. [Usage](#usage-▶️)
    1. [tgenv install](#tgenv-install)
    2. [tgenv use](#tgenv-use)
    3. [tgenv uninstall](#tgenv-uninstall)
    4. [tgenv list](#tgenv-list)
    5. [tgenv list-remote](#tgenv-list-remote)
    5. [tgenv upgrade](#tgenv-upgrade)
3. [The terragrunt-version file](#the-terragrunt-version-file-📄)
4. [Environment Variables](#environment-variables-📦)
    1. [TGENV_AUTO_INSTALL](#tgenv_auto_install)
    2. [TGENV_DEBUG](#tgenv_debug)
5. [Uninstalling](#uninstalling-🚫)
6. [License](#license-👍)


---

## Installation :wrench:

### 1. Cloning the repository

Check out latest version of tgenv

  ```bash
  $ git clone --depth 1 --branch main https://github.com/tgenv/tgenv.git ~/.tgenv
  ```

Or checkout tgenv at specific tag

  ```bash
  $ git clone --depth 1 --branch v1.0.0 https://github.com/tgenv/tgenv.git ~/.tgenv
  ```

### 2. Add tgenv to $PATH

#### Bash

Add `~/.tgenv/bin` to your `$PATH` any way you like

  ```bash
  $ echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.bash_profile
  ```

  OR you can make symlinks for `tgenv/bin/*` scripts into a path that is already added to your `$PATH` (e.g. `/usr/local/bin`) `OSX/Linux Only!`

  ```bash
  $ ln -s ~/.tgenv/bin/* /usr/local/bin
  ```

#### ZSH

Add `~/.tgenv/bin` to your `$PATH` any way you like

  ```bash
  $ echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.zshrc
  ```

If you use [Oh My Zsh](ttps://github.com/ohmyzsh/ohmyzsh), after export just run

```bash
$ omz reload
```

## Usage :arrow_forward:

### tgenv install

Install a specific version of terragrunt  
`latest` is a syntax to install latest version
`latest:<regex>` is a syntax to install latest version matching regex (used by grep -e)

```bash
$ tgenv install 0.40.2
$ tgenv install latest
$ tgenv install latest:^0.9
```

If you use [.terragrunt-version](#terragrunt-version), `tgenv install` (no argument) will install the version written in it.

### tgenv use

Switch a version to use
`latest` is a syntax to use the latest installed version
`latest:<regex>` is a syntax to use latest installed version matching regex (used by grep -e)

```bash
$ tgenv use 0.40.2
$ tgenv use latest
$ tgenv use latest:^0.10
```

### tgenv uninstall

Uninstall a specific version of terragrunt
`latest` is a syntax to uninstall latest version
`latest:<regex>` is a syntax to uninstall latest version matching regex (used by grep -e)

```bash
$ tgenv uninstall 0.12.1
$ tgenv uninstall latest
$ tgenv uninstall latest:^0.9
```

### tgenv list

List installed versions

```bash
% tgenv list
0.12.15
0.12.8
0.10.0
0.9.9
```

### tgenv list-remote

List installable versions

```bash
% tgenv list-remote
0.42.5
0.42.4
0.42.3
0.42.2
0.42.1
0.42.0
0.41.0
0.40.2
0.40.1
0.40.0
0.39.2
0.39.1
0.39.0
...
```

### tgenv upgrade

Upgrade the version of TGEnv software to latest version

`$ tgenv upgrade`

## The terragrunt-version file :page_facing_up:

If you put `.terragrunt-version` file on your project root, tgenv detects it and use the version written in it. If the version is `latest` or `latest:<regex>`, the latest matching version currently installed will be selected.

```bash
$ cat .terragrunt-version
0.9.9

$ terragrunt --version
terragrunt version v0.9.9

Your version of terragrunt is out of date! The latest version
is 0.7.3. You can update by downloading from www.terragrunt.io

$ echo 0.9.9 > .terragrunt-version

$ terragrunt --version
terragrunt v0.12.15

$ echo latest:^0.10 > .terragrunt-version

$ terragrunt --version
terragrunt v0.10.3
```

### Environment Variables :package:

#### `TGENV_AUTO_INSTALL`

String (Default: true)

Should tgenv automatically install terragrunt if the version specified by defaults or a .terragrunt-version file is not currently installed.

```console
TGENV_AUTO_INSTALL=false terragrunt plan
```

#### `TGENV_DEBUG`

Integer (Default: "")

Set the debug level for TGENV.

* unset/empty-string: No debug output
* set: Bash execution tracing

#### `TGENV_DISABLE_COLOR`

Integer (Default: "")

Disable colored output for tgenv. This variable can either be set explicitly or will be set
automatically if the `-no-color` flag is used with the terragrunt binary.

## Uninstalling :no_entry_sign:

Just run:
```bash
$ rm -rf /some/path/to/tgenv
```

And delete the previous export `$PATH` .

> The uninstall command is under development.

## LICENSE :thumbsup:
- [tgenv itself](https://github.com/tgenv/tgenv/blob/master/LICENSE)
- [tfenv ](https://github.com/kamatama41/tgenv/blob/master/LICENSE) : tfenv mainly uses tfenv's source code
