#!/usr/bin/env bash

declare -a errors

source "${TGENV_ROOT}/libexec/helpers"

[ -n "$TGENV_DEBUG" ] && set -x
source $(dirname $0)/helpers.sh \
  || error_and_die "Failed to load test helpers: $(dirname $0)/helpers.sh"

##################################################
# Test install latest version
##################################################
echo "### Install latest version"
cleanup || error_and_die "Cleanup failed?!"

v=$(tgenv list-remote | head -n 1)
(
  tgenv install latest || exit 1
  tgenv use ${v} || exit 1
  check_version ${v} || exit 1
) || error_and_proceed "Installing latest version ${v}"

##################################################
# Test install latest:<regex>
##################################################
echo "### Install latest version with Regex"
cleanup || error_and_die "Cleanup failed?!"

v=$(tgenv list-remote | grep 0.54.11 | head -n 1)
(
  tgenv install latest:^0.54 || exit 1
  tgenv use latest:^0.54 || exit 1
  check_version ${v} || exit 1
) || error_and_proceed "Installing latest version ${v} with Regex"

##################################################
# Test install specific version
##################################################
echo "### Install specific version"
cleanup || error_and_die "Cleanup failed?!"

v=0.54.10
(
  tgenv install ${v} || exit 1
  tgenv use ${v} || exit 1
  check_version ${v} || exit 1
) || error_and_proceed "Installing specific version ${v}"

##################################################
# Test specific version from .terragrunt-version
##################################################
echo "### Install specific .terragrunt-version"
cleanup || error_and_die "Cleanup failed?!"

v=0.54.11
echo ${v} > ./.terragrunt-version
(
  tgenv install || exit 1
  check_version ${v} || exit 1
) || error_and_proceed "Installing .terragrunt-version ${v}"

##################################################
# Use specific terragrunt version .terragrunt-version
# without preinstalling
##################################################
echo "### Install latest:<regex> .terragrunt-version"
cleanup || error_and_die "Cleanup failed?!"

echo "0.50.17" > ./.terragrunt-version
(
  terragrunt --version || exit 1
  check_version "0.50.17" || exit 1
) || error_and_proceed "Installing .terragrunt-version ${v}"

##################################################
# Install invalid specific version .terragrunt-version
##################################################
echo "### Install latest:<regex> .terragrunt-version"
cleanup || error_and_die "Cleanup failed?!"

v=$(tgenv list-remote | grep -e '^0.38' | head -n 1)
echo "latest:^0.38" > ./.terragrunt-version
(
  tgenv install || exit 1
  check_version ${v} || exit 1
) || error_and_proceed "Installing .terragrunt-version ${v}"

##################################################
# Install invalid specific version .terragrunt-version
##################################################
echo "### Install invalid specific version .terragrunt-version"
cleanup || error_and_die "Cleanup failed?!"

v=9.9.9
expected_error_message="No versions matching '${v}' found in remote"
[ -z "$(tgenv install ${v} 2>&1 | grep "${expected_error_message}")" ] \
  && error_and_proceed "Installing invalid version ${v}"

##################################################
# Install invalid latest:<regex> version
##################################################
echo "### Install invalid latest:<regex> version"
cleanup || error_and_die "Cleanup failed?!"

v="latest:word"
expected_error_message="No versions matching '${v}' found in remote"
[ -z "$(tgenv install ${v} 2>&1 | grep "${expected_error_message}")" ] \
  && error_and_proceed "Installing invalid version ${v}"

if [ ${#errors[@]} -gt 0 ]; then
  echo -e "\033[0;31m===== The following install_and_use tests failed =====\033[0;39m" >&2
  for error in "${errors[@]}"; do
    echo -e "\t${error}"
  done
  exit 1
else
  echo -e "\033[0;32mAll install_and_use tests passed.\033[0;39m"
fi;
exit 0
