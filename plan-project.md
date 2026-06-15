# tgenv — Project Improvement Plan

> Technical analysis and implementation roadmap for the tgenv project.
> Organized in Jira hierarchy: **Epic → Story → Task → Subtask**.
> Scope evaluated: `bin/`, `libexec/`, `test/`, `.github/workflows/tests.yml`, `.shellcheckrc` (~533 lines of bash across 14 files).

---

## Table of Contents

1. [Technical Analysis Summary](#1-technical-analysis-summary)
2. [Issue Catalog (B1–B22)](#2-issue-catalog-b1b22)
3. [Implementation Roadmap](#3-implementation-roadmap)
   - [Epic 0 — Project Setup](#epic-0--project-setup)
   - [Epic 1 — Critical Stability & Security](#epic-1--critical-stability--security)
   - [Epic 2 — Quality & Robustness](#epic-2--quality--robustness)
   - [Epic 3 — Polish & Standardization](#epic-3--polish--standardization)
   - [Epic 4 — Tooling & Infrastructure](#epic-4--tooling--infrastructure)
4. [Execution Order & Dependencies](#4-execution-order--dependencies)
5. [Final Considerations](#5-final-considerations)

---

## 1. Technical Analysis Summary

### Strengths

- **rbenv-style architecture** (`bin/` + `libexec/` separation with PATH-based command dispatch)
- **Transparent `terragrunt` wrapper** in `bin/terragrunt`
- **Centralized helpers** with colored logging (`info`, `debug`, `warn_and_continue`, `error_and_die`)
- **Uniform debug toggle** (`TGENV_DEBUG=1` enables `set -x` with formatted `PS4`)
- **ShellCheck integrated in CI** with documented `.shellcheckrc`
- **Multi-OS test matrix** (alpine, ubuntu, fedora, macos-latest)
- **Functional test suite** covering install, use, list, uninstall and symlink flows
- **Auto-install** via `TGENV_AUTO_INSTALL`
- **Offline cache** of available versions (`list_all_versions_offline`)
- **Regex support** in version selection (`latest:^0.37`)
- **Apple Silicon (ARM64)** support

### Weaknesses

- **Lack of defensive rigor**: inconsistent `set -euo pipefail`, duplicated logic across three commands (root cause of PR #44 bug), incorrect exit code capture in `tgenv-list-remote`, latent bug in `curlw`
- **No integrity verification of downloaded binaries** — most critical issue from a security standpoint
- **Tight coupling to GitHub** (hardcoded download URL)
- **Race conditions** possible on concurrent installs
- **Fragile upgrade path** (assumes git clone with main tracking)

### Executive Summary

The project has **solid architecture** for a ~500-line version manager with good UX. However, it lacks defensive shell scripting practices and supply-chain security controls. The **critical path to project health** runs through Epic 1 alone (~6 small-to-medium PRs).

---

## 2. Issue Catalog (B1–B22)

### 🔴 Critical

| ID | Title | Files |
|----|-------|-------|
| **B1** | Inconsistent `set -e` across scripts | `libexec/*` |
| **B2** | `curlw` passes empty string as argument | `libexec/helpers` |
| **B3** | Wrong exit code captured in `tgenv-list-remote` (post-pipe) | `libexec/tgenv-list-remote` |
| **B4** | Duplicated `version_requested` resolution in 3 commands | `tgenv-install`, `tgenv-use`, `tgenv-uninstall` |
| **B5** | Error message uses `${1}` when version comes from file | `libexec/tgenv-install` |
| **B6** | No SHA256/signature verification of downloaded binaries | `libexec/tgenv-install` |

### 🟡 Medium

| ID | Title | Files |
|----|-------|-------|
| **B7** | `set -u` (nounset) absent | all libexec |
| **B8** | `tgenv install <exact-version>` always hits the network | `libexec/tgenv-install` |
| **B9** | Race condition on concurrent installs | `libexec/tgenv-install` |
| **B10** | Empty install dir left behind on download failure | `libexec/tgenv-install` |
| **B11** | `tgenv-upgrade` brittle (shallow clones, detached HEAD, forks, brew) | `libexec/tgenv-upgrade` |
| **B12** | `mktemp /tmp/tgenv.XXXXXXXX` ignores `TMPDIR` | `libexec/tgenv-list-remote` |
| **B13** | Hardcoded GitHub Releases URL | `libexec/tgenv-install` |
| **B14** | `tgenv-version-file` returns non-existent path as fallback | `libexec/tgenv-version-file` |

### 🟢 Minor

| ID | Title | Files |
|----|-------|-------|
| **B15** | Numeric sort fails on prereleases | `tgenv-list`, `tgenv-use`, `tgenv-version-name` |
| **B16** | `errors` array used in helpers without declaration | `libexec/helpers` |
| **B17** | Inconsistent log destination (stdout vs stderr) | `libexec/helpers` |
| **B18** | Dead code comment in `tgenv-list-remote` | `libexec/tgenv-list-remote` |
| **B19** | `tgenv-exec` exports binary file (not directory) to PATH | `libexec/tgenv-exec` |
| **B20** | Windows support code present but broken | `libexec/tgenv-install` |
| **B21** | `tgenv---version` parses CHANGELOG.md | `libexec/tgenv---version` |
| **B22** | `ls -1` parsing instead of glob | `tgenv-list`, `tgenv-use`, `tgenv-version-name` |

---

## 3. Implementation Roadmap

> Each Task corresponds to one self-contained Pull Request unit.
> Subtasks are concrete steps to complete a Task.

---

## Epic 0 — Project Setup

> **Goal**: Establish process foundations before code work begins.
> **Outcome**: Public traceability, contributor onboarding, consistent conventions.

### Story 0.1 — Public traceability via GitHub Issues

#### Task 0.1.1 — Create GitHub issues for all cataloged problems
- **Acceptance**: 22 issues open in `tgenv/tgenv`, each linking back to this plan section.
- **Dependencies**: none.

##### Subtasks
- [ ] Create issue templates (bug, enhancement, security)
- [ ] Open one issue per ID (B1–B22) with severity label
- [ ] Apply area labels (`area:install`, `area:use`, `area:ci`, etc.)
- [ ] Cross-reference issues in this document

### Story 0.2 — Contribution conventions

#### Task 0.2.1 — Define branch naming policy
- **Acceptance**: `CONTRIBUTING.md` documents branch convention.
- **Dependencies**: none.

##### Subtasks
- [ ] Adopt naming: `fix/<id>-<slug>`, `feat/<id>-<slug>`, `refactor/<id>-<slug>`, `chore/<id>-<slug>`
- [ ] Document in `CONTRIBUTING.md`
- [ ] Add PR template referencing the convention

#### Task 0.2.2 — Define label scheme
- **Acceptance**: GitHub labels created and documented.
- **Dependencies**: none.

##### Subtasks
- [ ] Priority labels: `priority:critical`, `priority:medium`, `priority:low`
- [ ] Type labels: `type:bug`, `type:enhancement`, `type:security`, `type:tech-debt`
- [ ] Area labels: `area:install`, `area:use`, `area:list`, `area:ci`, `area:helpers`

---

## Epic 1 — Critical Stability & Security

> **Goal**: Eliminate the highest-risk defects (security, silent failures, latent bugs).
> **Outcome**: Project becomes safe to depend on in production environments.
> **Critical path**: Yes. All other epics build on this foundation.

### Story 1.1 — Supply-chain integrity

#### Task 1.1.1 — Verify downloaded binaries with SHA256 (B6)
- **Branch**: `fix/B6-checksum-verification`
- **Files**: `libexec/tgenv-install`, `libexec/helpers`, `test/test_install_and_use.sh`
- **Acceptance**:
  - All downloads validated against published `SHA256SUMS`
  - Mismatch removes the partial file and aborts with clear error
  - `TGENV_SKIP_VERIFY=true` documented escape hatch
  - Tests cover: success, mismatch, skip-verify
- **Dependencies**: Epic 0.

##### Subtasks
- [ ] Add `verify_checksum <file> <expected_sha>` helper
- [ ] Detect available tool (`shasum -a 256` on macOS, `sha256sum` on Linux) — wrapper function
- [ ] Download `SHA256SUMS` from the same release URL
- [ ] Parse expected hash for the architecture-specific tarball
- [ ] Verify and abort on mismatch (delete partial file)
- [ ] Add `TGENV_SKIP_VERIFY` env var with warning when active
- [ ] Add three test cases (happy path, mismatch, skip)
- [ ] Update help/docs

### Story 1.2 — Defensive shell defaults

#### Task 1.2.1 — Extract `resolve_version_requested` helper (B4)
- **Branch**: `refactor/B4-extract-version-resolver`
- **Files**: `libexec/helpers`, `libexec/tgenv-install`, `libexec/tgenv-use`, `libexec/tgenv-uninstall`
- **Acceptance**:
  - Single source of truth for version resolution
  - Existing test suite passes unchanged
  - ~5 lines removed from each command
- **Dependencies**: PR #49 merged first (avoids conflicts).

##### Subtasks
- [ ] Implement `resolve_version_requested()` in `helpers`
- [ ] Replace duplicated block in `tgenv-install`
- [ ] Replace duplicated block in `tgenv-use`
- [ ] Replace duplicated block in `tgenv-uninstall`
- [ ] Run full test suite locally on Linux + macOS

#### Task 1.2.2 — Standardize `set -euo pipefail` (B1, B7)
- **Branch**: `fix/B1-B7-strict-mode`
- **Files**: all `libexec/*`, `bin/terragrunt`
- **Acceptance**:
  - Every script starts with `set -euo pipefail`
  - All test suites pass on alpine, ubuntu, fedora, macOS
  - No new ShellCheck warnings
- **Dependencies**: Task 1.2.1 (easier to test deduplicated logic).

##### Subtasks
- [ ] Add `set -euo pipefail` after each shebang
- [ ] Audit unset variables, add `${VAR:-}` defaults where appropriate
- [ ] Audit pipelines, add explicit `|| true` where upstream failure is acceptable
- [ ] Run full CI matrix
- [ ] Run ShellCheck locally with project config

### Story 1.3 — Latent bug fixes

#### Task 1.3.1 — Fix `curlw` empty-arg bug (B2)
- **Branch**: `fix/B2-curlw-array-args`
- **Files**: `libexec/helpers`
- **Acceptance**:
  - `curlw` works on macOS 10.11, 10.12.6+, and Linux
  - `TGENV_DEBUG=1 tgenv install latest` shows correct curl args
- **Dependencies**: none.

##### Subtasks
- [ ] Refactor `curlw` to use bash array for args
- [ ] Conditionally append `--tlsv1.2` only when needed
- [ ] Manual verification on macOS and Linux

#### Task 1.3.2 — Fix exit-code capture in `tgenv-list-remote` (B3, B18)
- **Branch**: `fix/B3-list-remote-pipefail`
- **Files**: `libexec/tgenv-list-remote`
- **Acceptance**:
  - Network failures surface correctly
  - Offline fallback reads from cache (`list_all_versions_offline`)
  - No `return` outside functions
  - Dead-code comment removed
- **Dependencies**: Task 1.2.2 (`pipefail`).

##### Subtasks
- [ ] Replace `return_code=$?` with `${PIPESTATUS[0]}` (or rely on `pipefail`)
- [ ] Replace `return` with `exit`
- [ ] Wire offline-cache fallback on network error
- [ ] Remove dead comment
- [ ] Add test simulating network failure (uses cached file)
- [ ] Add test for empty cache + no network → clear error

#### Task 1.3.3 — Fix error message variable (B5)
- **Branch**: `fix/B5-error-message-version`
- **Files**: `libexec/tgenv-install`
- **Acceptance**:
  - When version comes from file, error includes the resolved value (not empty)
- **Dependencies**: Task 1.2.1 (centralized variable).

##### Subtasks
- [ ] Replace `${1}` with `${version_requested}` in `error_and_die` call

---

## Epic 2 — Quality & Robustness

> **Goal**: Improve performance, correctness, and operational ergonomics.
> **Outcome**: Production-grade behavior across edge cases.

### Story 2.1 — Configurability for restricted environments

#### Task 2.1.1 — Support `TGENV_DOWNLOAD_BASE_URL` (B13)
- **Branch**: `feat/B13-download-base-url`
- **Files**: `libexec/tgenv-install`
- **Acceptance**:
  - Env var overrides hardcoded URL
  - Documented in help and README
  - Test against local mock server
- **Dependencies**: none.

##### Subtasks
- [ ] Read `TGENV_DOWNLOAD_BASE_URL` with default
- [ ] Update version URL composition
- [ ] Document in `tgenv-help` and main docs
- [ ] Add test with local file:// URL

### Story 2.2 — Concurrency and failure handling

#### Task 2.2.1 — Cleanup partial install on failure (B10)
- **Branch**: `fix/B10-cleanup-on-failure`
- **Files**: `libexec/tgenv-install`
- **Acceptance**:
  - Failed download leaves no leftover directory
  - Test simulating failure verifies cleanup
- **Dependencies**: Task 1.2.2 (needs `set -e` for ERR trap).

##### Subtasks
- [ ] Register `trap 'rm -rf "${dst_path}"' ERR`
- [ ] Add test forcing download failure (invalid URL)
- [ ] Verify directory absent after failure

#### Task 2.2.2 — File lock for concurrent installs (B9)
- **Branch**: `feat/B9-install-locking`
- **Files**: `libexec/tgenv-install`
- **Acceptance**:
  - Simultaneous `tgenv install <v>` calls do not corrupt state
  - Fallback works on systems without `flock`
- **Dependencies**: Task 1.2.2.

##### Subtasks
- [ ] Implement `flock`-based lock on `${TGENV_ROOT}/.lock-${version}`
- [ ] Add `mkdir`-based fallback for legacy macOS
- [ ] Add test running two installs in parallel

### Story 2.3 — Network efficiency

#### Task 2.3.1 — Cache-first resolution (B8)
- **Branch**: `fix/B8-cache-first-resolution`
- **Files**: `libexec/tgenv-install`, `libexec/tgenv-list-remote`
- **Acceptance**:
  - Exact-version installs use cache when valid
  - `TGENV_FORCE_REMOTE=true` bypasses cache
  - Cache automatically refreshed on miss
- **Dependencies**: Task 1.3.2.

##### Subtasks
- [ ] Add cache lookup before remote call for exact versions
- [ ] On miss, refresh cache via `tgenv-list-remote`
- [ ] Implement `TGENV_FORCE_REMOTE` bypass
- [ ] Update test suite

### Story 2.4 — API hygiene

#### Task 2.4.1 — Separate path resolution from existence in `tgenv-version-file` (B14)
- **Branch**: `fix/B14-version-file-existence`
- **Files**: `libexec/tgenv-version-file`, all callers
- **Acceptance**:
  - Callers explicitly handle missing file
  - No more "non-existent path" surprises (root cause of PR #44)
- **Dependencies**: Task 1.2.1.

##### Subtasks
- [ ] Add `--exists-only` flag (or split into two functions)
- [ ] Update `tgenv-install`, `tgenv-use`, `tgenv-uninstall`, `tgenv-version-name` callers
- [ ] Run full test suite

#### Task 2.4.2 — Robust `tgenv-upgrade` (B11)
- **Branch**: `fix/B11-upgrade-robustness`
- **Files**: `libexec/tgenv-upgrade`
- **Acceptance**:
  - Detects non-git installs (Homebrew) and prints guidance
  - Aborts with clear message on detached HEAD
  - Validates upstream remote on forks
  - No silent `git stash`
- **Dependencies**: none.

##### Subtasks
- [ ] Detect missing `.git` directory
- [ ] Detect detached HEAD via `git symbolic-ref`
- [ ] Detect missing/wrong upstream
- [ ] Prompt user before stashing (or remove stash, document expectation)

### Story 2.5 — Portability

#### Task 2.5.1 — Portable `mktemp` (B12)
- **Branch**: `fix/B12-mktemp-portable`
- **Files**: `libexec/tgenv-list-remote`
- **Acceptance**:
  - Honors `TMPDIR`
  - Works in containers with read-only `/tmp`
- **Dependencies**: none.

##### Subtasks
- [ ] Replace `mktemp /tmp/tgenv.XXXXXXXX` with `mktemp -t tgenv.XXXXXXXX`
- [ ] Verify behavior on alpine, ubuntu, macOS

---

## Epic 3 — Polish & Standardization

> **Goal**: Address quality-of-life issues and code consistency.
> **Outcome**: Codebase ready for long-term maintenance.

### Story 3.1 — Logging hygiene

#### Task 3.1.1 — Send logs to stderr (B17)
- **Branch**: `fix/B17-stderr-logging`
- **Files**: `libexec/helpers`
- **Acceptance**:
  - `info` and `debug` write to stderr
  - Pipeable commands (e.g. `tgenv list-remote`) keep stdout clean
- **Dependencies**: none.

##### Subtasks
- [ ] Redirect `info` output to stderr
- [ ] Redirect `debug` output to stderr
- [ ] Verify no test depends on log lines via stdout

#### Task 3.1.2 — Honor `NO_COLOR` env var
- **Branch**: `feat/no-color-env`
- **Files**: `libexec/helpers`
- **Acceptance**:
  - `NO_COLOR=1` disables colored output (per https://no-color.org)
- **Dependencies**: none.

##### Subtasks
- [ ] Treat `NO_COLOR` (any non-empty value) as `TGENV_DISABLE_COLOR=1`
- [ ] Document in README

### Story 3.2 — Consistent sorting and globbing

#### Task 3.2.1 — Use `sort -Vr` for version sort (B15)
- **Branch**: `fix/B15-version-sort`
- **Files**: `tgenv-list`, `tgenv-use`, `tgenv-version-name`
- **Acceptance**:
  - Prereleases sort correctly
  - Behavior matches `tgenv-list-remote`
- **Dependencies**: none.

##### Subtasks
- [ ] Replace per-field numeric sort with `sort -Vr`
- [ ] Verify behavior on macOS (may need `gsort` from coreutils)

#### Task 3.2.2 — Replace `ls -1` with bash globbing (B22)
- **Branch**: `fix/B22-replace-ls-globbing`
- **Files**: `tgenv-list`, `tgenv-use`, `tgenv-version-name`
- **Acceptance**:
  - No `ls` parsing
  - `disable=SC2012` removed from `.shellcheckrc`
- **Dependencies**: Task 3.2.1.

##### Subtasks
- [ ] Replace `ls "${TGENV_ROOT}/versions"` with `("${TGENV_ROOT}/versions"/*)`
- [ ] Use `basename` to strip path
- [ ] Remove `disable=SC2012` from `.shellcheckrc`

### Story 3.3 — Internal correctness

#### Task 3.3.1 — Declare `errors` array in helpers (B16)
- **Branch**: `fix/B16-errors-array-declared`
- **Files**: `libexec/helpers`
- **Acceptance**:
  - Works under `set -u`
- **Dependencies**: Task 1.2.2.

##### Subtasks
- [ ] Add `declare -ga errors=()` in helpers
- [ ] Remove redundant declarations from test files

#### Task 3.3.2 — Fix PATH semantics in `tgenv-exec` (B19)
- **Branch**: `fix/B19-exec-path-semantics`
- **Files**: `libexec/tgenv-exec`
- **Acceptance**:
  - PATH receives the directory containing the binary, not the binary itself
- **Dependencies**: none.

##### Subtasks
- [ ] Change `export PATH="${TG_BIN_PATH}:${PATH}"` to use directory

### Story 3.4 — Project metadata

#### Task 3.4.1 — Decide on Windows support (B20)
- **Branch**: `chore/B20-windows-decision`
- **Files**: `libexec/tgenv-install`
- **Acceptance**:
  - Either complete Windows support (binary suffix `.exe`, path mapping) or remove dead code
  - Recommendation: remove and open separate tracking issue
- **Dependencies**: none.

##### Subtasks
- [ ] Decision (team discussion)
- [ ] Implement chosen path
- [ ] Update CI matrix

#### Task 3.4.2 — Replace CHANGELOG parsing for version (B21)
- **Branch**: `chore/B21-version-source`
- **Files**: `libexec/tgenv---version`
- **Acceptance**:
  - Version sourced from a `VERSION` file or `git describe` only
  - No CHANGELOG parsing
- **Dependencies**: none.

##### Subtasks
- [ ] Choose between `VERSION` file or `git describe`
- [ ] Update `tgenv---version`
- [ ] Update release process docs

---

## Epic 4 — Tooling & Infrastructure

> **Goal**: Strengthen the developer experience and CI pipeline.
> **Outcome**: Faster feedback, lower onboarding cost, sustainable maintenance.

### Story 4.1 — Modern test infrastructure

#### Task 4.1.1 — Migrate tests to bats-core
- **Branch**: `feat/bats-migration`
- **Files**: `test/*.sh` → `test/*.bats`
- **Acceptance**:
  - All current scenarios run under bats
  - Per-test isolation
  - Optional parallel execution
- **Dependencies**: Epic 1 stable.

##### Subtasks
- [ ] Add bats-core dependency to CI
- [ ] Migrate `test_install_and_use.sh`
- [ ] Migrate `test_list.sh`
- [ ] Migrate `test_uninstall.sh`
- [ ] Migrate `test_symlink.sh`
- [ ] Update CI to call `bats`

### Story 4.2 — Local developer experience

#### Task 4.2.1 — Add pre-commit hook
- **Branch**: `feat/pre-commit-hook`
- **Files**: `.pre-commit-config.yaml`, `CONTRIBUTING.md`
- **Acceptance**:
  - ShellCheck runs locally on staged files
  - Documented setup
- **Dependencies**: none.

##### Subtasks
- [ ] Create `.pre-commit-config.yaml` with shellcheck hook
- [ ] Document install in `CONTRIBUTING.md`

#### Task 4.2.2 — Makefile entry points
- **Branch**: `feat/makefile-entrypoints`
- **Files**: `Makefile`
- **Acceptance**:
  - `make test`, `make lint`, `make install`, `make uninstall` work locally
- **Dependencies**: none.

##### Subtasks
- [ ] Define `test`, `lint`, `install`, `uninstall` targets
- [ ] Document in README

### Story 4.3 — CI optimization

#### Task 4.3.1 — Cache versions directory
- **Branch**: `feat/ci-cache-versions`
- **Files**: `.github/workflows/tests.yml`
- **Acceptance**:
  - Test runtime reduced (no repeated terragrunt downloads)
- **Dependencies**: none.

##### Subtasks
- [ ] Add `actions/cache` step keyed on terragrunt versions used
- [ ] Verify cache hit/miss behavior

### Story 4.4 — Documentation

#### Task 4.4.1 — Per-command `--help`
- **Branch**: `feat/per-command-help`
- **Files**: `libexec/*`, new `libexec/tgenv-help-printer`
- **Acceptance**:
  - Every subcommand responds to `--help` / `-h`
  - Centralized formatting
- **Dependencies**: none.

##### Subtasks
- [ ] Create `print_usage` helper
- [ ] Add usage block to each `tgenv-*` script
- [ ] Wire `--help`/`-h` argument detection

---

## 4. Execution Order & Dependencies

```
Epic 0 (process bootstrap)
  ↓
┌─ Task 1.3.1 (curlw) ────────────────┐
│  Task 1.3.3 (error msg)             │
│  Task 2.5.1 (mktemp)                │
└─→ Task 1.2.1 (extract resolver) ────┤
                                       ├─→ Task 1.2.2 (strict mode)
                                       │     ↓
                                       │     ├─→ Task 1.1.1 (checksum)
                                       │     ├─→ Task 1.3.2 (list-remote)
                                       │     │     ↓
                                       │     │     └─→ Task 2.3.1 (cache-first)
                                       │     ├─→ Task 2.2.1 (cleanup)
                                       │     ├─→ Task 2.2.2 (lock)
                                       │     └─→ Task 3.3.1 (errors array)
                                       └─→ Task 2.4.1 (version-file API)
                                             ↓
                                             Epic 3 (polish, parallelizable)
                                             ↓
                                             Epic 4 (tooling, parallelizable)
```

### Suggested PR sequencing rationale

1. **Trivial wins first** (Tasks 1.3.1, 1.3.3, 2.5.1) — independent, low-risk warm-up.
2. **Refactor before strictness** (1.2.1 → 1.2.2) — avoids rework.
3. **Strict mode unlocks** ERR trap (2.2.1), `pipefail` reliance (1.3.2), and `set -u` for the rest of the codebase.
4. **Security first among new features** (1.1.1) — highest-impact item once base is stable.
5. **Epic 2 parallelizes well** across contributors.
6. **Epics 3 & 4** are optional but valuable for sustainability.

### ID → Task → Effort Mapping

| ID | Severity | Task | Effort |
|----|----------|------|--------|
| B1 | 🔴 | 1.2.2 | M |
| B2 | 🔴 | 1.3.1 | S |
| B3 | 🔴 | 1.3.2 | M |
| B4 | 🔴 | 1.2.1 | M |
| B5 | 🟡 | 1.3.3 | XS |
| B6 | 🔴 | 1.1.1 | M |
| B7 | 🟡 | 1.2.2 (bundled) | – |
| B8 | 🟡 | 2.3.1 | M |
| B9 | 🟡 | 2.2.2 | M |
| B10 | 🟡 | 2.2.1 | S |
| B11 | 🟡 | 2.4.2 | M |
| B12 | 🟡 | 2.5.1 | XS |
| B13 | 🟡 | 2.1.1 | S |
| B14 | 🟡 | 2.4.1 | M |
| B15 | 🟢 | 3.2.1 | XS |
| B16 | 🟢 | 3.3.1 | XS |
| B17 | 🟢 | 3.1.1 | S |
| B18 | 🟢 | 1.3.2 (bundled) | – |
| B19 | 🟢 | 3.3.2 | XS |
| B20 | 🟢 | 3.4.1 | depends |
| B21 | 🟢 | 3.4.2 | S |
| B22 | 🟢 | 3.2.2 | S |

> Effort: **XS** (≤5 lines) · **S** (≤30 lines) · **M** (≤100 lines) · **L** (broad refactor)

---

## 5. Final Considerations

- **Contract-breaking changes** (Task 1.2.2 strict mode, Task 2.4.1 version-file API, Task 3.1.1 stderr logging) should be communicated in `CHANGELOG.md` and ideally bundled into a single minor release (e.g. `v1.4.0`).
- **Trivial items** (XS effort) may be grouped into a single "house-keeping PR" if review overhead becomes a concern.
- **Security items** (Task 1.1.1) deserve a GitHub Security Advisory once delivered.
- **Critical path to project health passes through Epic 1 alone** (~6 small-to-medium PRs). Epics 2–4 are incremental.
- The plan is incremental: any phase can be paused or reordered if priorities shift, as long as listed dependencies are respected.
