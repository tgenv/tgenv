#!/usr/bin/env bash

declare -a errors

source "${TGENV_ROOT}/libexec/helpers"

[ -n "${TGENV_DEBUG}" ] && set -x
source "$(dirname "${0}")/helpers.sh" \
  || error_and_die "Failed to load test helpers: $(dirname "${0}")/helpers.sh"

echo "### Uninstall local versions"
cleanup || error_and_die "Cleanup failed?!"

v=0.35.2
(
  tgenv install "${v}" || exit 1
  tgenv uninstall "${v}" || exit 1
  tgenv list | grep 0.35.2 && exit 1 || exit 0
) || error_and_proceed "Uninstall of version ${v} failed"

echo "### Uninstall latest version"
cleanup || error_and_die "Cleanup failed?!"

v=$(tgenv list-remote | head -n 1)
(
  tgenv install latest || exit 1
  tgenv uninstall latest || exit 1
  tgenv list | grep "${v}" && exit 1 || exit 0
) || error_and_proceed "Uninstalling latest version ${v}"

echo "### Uninstall latest version with Regex"
cleanup || error_and_die "Cleanup failed?!"

v=$(tgenv list-remote | grep 0.33.2 | head -n 1)
(
  tgenv install latest:^0.33 || exit 1
  tgenv uninstall latest:^0.33 || exit 1
  tgenv list | grep "${v}" && exit 1 || exit 0
) || error_and_proceed "Uninstalling latest version ${v} with Regex"

if [ ${#errors[@]} -gt 0 ]; then
  echo -e "\033[0;31m===== The following list tests failed =====\033[0;39m" >&2
  for error in "${errors[@]}"; do
    echo -e "\t${error}"
  done
  exit 1
else
  echo -e "\033[0;32mAll list tests passed.\033[0;39m"
fi;
exit 0
