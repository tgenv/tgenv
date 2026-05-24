---
title: Uninstalling TGEnv
---

# Uninstalling TGEnv

Removing TGEnv is a manual but quick process.

## 1. Delete the Installation Directory

```bash
rm -rf ~/.tgenv
```

This removes the TGEnv scripts, every installed Terragrunt version and the
cached remote release list.

If you cloned TGEnv to a different location, delete that directory instead.

## 2. Remove TGEnv From Your PATH

Open the shell startup file you edited during
[installation](./installation.md#add-tgenv-to-your-path) (for example
`~/.bash_profile`, `~/.bashrc` or `~/.zshrc`) and remove the line that adds
`~/.tgenv/bin` to your `PATH`.

If you symlinked the scripts into a directory like `/usr/local/bin`, remove the
broken symlinks:

```bash
find /usr/local/bin -maxdepth 1 -lname "*/.tgenv/*" -delete
```

## 3. Reload Your Shell

Restart your terminal or `source` the updated startup file so the change takes
effect.

## Notes

- A dedicated `tgenv uninstall-self` command is on the roadmap. Until it lands,
  follow the steps above.
- Removing TGEnv does not affect any system-wide Terragrunt binary that may be
  installed through your OS package manager.
