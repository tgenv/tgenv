#!/usr/bin/env bash

set -uo pipefail;
declare -a errors

source "${TGENV_ROOT}/libexec/helpers"

[ "${TGENV_DEBUG:-0}" -gt 0 ] && set -x
source "$(dirname "$0")/helpers.sh" \
  || error_and_die "Failed to load test helpers: $(dirname "${0}")/helpers.sh"

echo "### List local versions"
cleanup || error_and_die "Cleanup failed?!"

versions=(
  0.38.12
  0.37.4
  0.36.11
  0.33.0
  0.29.7
)
for v in "${versions[@]}"; do
  tgenv install "${v}" || error_and_proceed "Install of version ${v} failed"
done
tgenv use 0.38.12

result="$(tgenv list)";
expected="$(cat << EOS
* 0.38.12 (set by $(tgenv version-file))
  0.37.4
  0.36.11
  0.33.0
  0.29.7
EOS
)"

# Note macos appears to have problems with variable expansion here
if [ "${expected}" != "${result}" ]; then
  error_and_proceed "List mismatch.\nExpected:\n${expected}\nGot:\n${result}"
fi

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
