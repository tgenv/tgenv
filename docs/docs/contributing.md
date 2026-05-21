---
id: contributing
title: Contributing
sidebar_position: 8
---

# Contributing

Contributions are welcome. The project lives at
[github.com/tgenv/tgenv](https://github.com/tgenv/tgenv).

## Coding Standards

All shell code must pass [ShellCheck](https://www.shellcheck.net/). The rules
that apply to the project are declared in `.shellcheckrc` at the repository
root.

Run ShellCheck locally before opening a pull request:

```bash
shellcheck test/* bin/* libexec/*
```

ShellCheck can produce diffs that are safe to apply automatically:

```bash
shellcheck -f diff my-script.sh | patch
```

## Running the Tests

The test harness is a set of Bash scripts under `test/`. The same scripts run
in CI inside Alpine, Ubuntu, Fedora and macOS environments.

To execute the suite locally:

```bash
./test/setup_runner.sh
./test/install_deps.sh
./test/run.sh
```

Each individual scenario lives in its own file (`test_install_and_use.sh`,
`test_list.sh`, `test_uninstall.sh`, `test_symlink.sh`) and can be invoked
directly when iterating on a fix.

## Continuous Integration

GitHub Actions runs three jobs on every pull request to `main`:

1. **shellcheck** — static analysis of every script.
2. **test-pull-requests-docker** — full test suite inside Alpine, Ubuntu and
   Fedora containers.
3. **test-pull-requests-non-docker** — full test suite on macOS.

A pull request must pass all three jobs before it can be merged.

## Submitting a Pull Request

1. Fork the repository and create a feature branch.
2. Make your change. Keep the diff focused and add tests when the behavior
   changes.
3. Run ShellCheck and the test suite locally.
4. Open a pull request describing the motivation and the change. The repository
   ships a pull request template — please fill it in.

## Reporting Bugs

Bug reports are best filed as GitHub issues. Include:

- Your operating system and architecture.
- The TGEnv commit or tag in use.
- A minimal reproduction with `TGENV_DEBUG=1` output.
