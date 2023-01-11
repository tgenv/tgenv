#!/usr/bin/env bash

declare -a errors

function error_and_proceed() {
  errors+=("${1}")
  echo -e "tgenv: ${0}: Test Failed: ${1}" >&2
}

function error_and_die() {
  echo -e "tgenv: ${0}: ${1}" >&2
  exit 1
}

[ -n "${TGENV_DEBUG}" ] && set -x
source $(dirname $0)/helpers.sh \
  || error_and_die "Failed to load test helpers: $(dirname $0)/helpers.sh"

echo "### List local versions"
cleanup || error_and_die "Cleanup failed?!"

for v in 0.38.12 0.37.4 0.36.11 0.33.0 0.29.7; do
  tgenv install ${v} || error_and_proceed "Install of version ${v} failed"
done

# NOTE(iokiwi): Hardcoding the expected output like this may work for the github action
# but will probably fail if run locally. I believe there is an example of the output 
# being generated more dynamically in the tfenv project that we could 'borrow'.
result="$(tgenv list)";
expected="$(cat << EOS
  0.38.12
  0.37.4
  0.36.11
  0.33.0
* 0.29.7 (set by /home/runner/work/tgenv/tgenv/version)
EOS
)"

# echo "---- BEGIN DEBUG INFO ----"
# uname -a
# echo "${BASH_VERSION}"
# echo "${expected}"
# echo "${result}"
# echo "---- END DEBUG INFO ----"

[ "${expected}" == "${result}" ] \
  || error_and_proceed "List mismatch.\nExpected:\n${expected}\nGot:\n${result}"

# # Note macos appears to have problems with variable expansion here
# if [ "${expected}" != "${result}" ]; then
#   error_and_proceed "List mismatch.\nExpected:\n${expected}\nGot:\n${result}"
# fi

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
