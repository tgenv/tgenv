---
id: upgrade
title: tgenv upgrade
sidebar_position: 6
---

# tgenv upgrade

Updates TGEnv itself to the latest version available on the `main` branch.

## Synopsis

```bash
tgenv upgrade
```

## Behavior

The `upgrade` command is a thin wrapper around `git`:

1. Stashes any local changes in `~/.tgenv` so the working tree is clean.
2. Checks out the `main` branch.
3. Runs `git pull` to fetch the latest commits.
4. Prints the most recent commit through `git log -1`.

If you had local modifications, restore them with:

```bash
cd ~/.tgenv && git stash apply
```

## Notes

- This command does not change your installed Terragrunt versions.
- If you cloned TGEnv from a fork or a tag, `upgrade` will switch you to the
  upstream `main` branch. Re-clone if you want to keep tracking another ref.
