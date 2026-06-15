# TGEnv — Terragrunt Version Manager

[![Tests](https://github.com/tgenv/tgenv/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/tgenv/tgenv/actions/workflows/tests.yml)
[![Latest Release](https://img.shields.io/github/v/release/tgenv/tgenv?label=release)](https://github.com/tgenv/tgenv/releases/latest)
[![License](https://img.shields.io/github/license/tgenv/tgenv)](LICENSE)
![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)
![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white)
![WSL](https://img.shields.io/badge/WSL-0078D4?logo=windows&logoColor=white)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?logo=gnu-bash&logoColor=white)

> A [Terragrunt](https://github.com/gruntwork-io/terragrunt) version manager inspired by [tfenv](https://github.com/tfutils/tfenv). Install, switch and manage multiple Terragrunt versions from a single shell environment.

---

## Documentation

Full documentation is available at **[tgenv.github.io/tgenv](https://tgenv.github.io/tgenv/)**, covering:

- [Installation](https://tgenv.github.io/tgenv/installation/)
- [Usage](https://tgenv.github.io/tgenv/usage/install/) — `install`, `use`, `list`, `list-remote`, `uninstall`, `upgrade`
- [The `.terragrunt-version` file](https://tgenv.github.io/tgenv/terragrunt-version-file/)
- [Environment Variables](https://tgenv.github.io/tgenv/environment-variables/)
- [Architecture](https://tgenv.github.io/tgenv/architecture/)
- [Contributing](https://tgenv.github.io/tgenv/contributing/)

## Quick Start

```bash
git clone --depth 1 --branch main https://github.com/tgenv/tgenv.git ~/.tgenv
echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.bash_profile
```

```bash
tgenv install latest
tgenv use latest
```

## License

[MIT](LICENSE) — forked from [cunymatthieu/tgenv](https://github.com/cunymatthieu/tgenv).

