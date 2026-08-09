---
name: scale_ci_cd_repo
description: Specialized scalability auditor for CI/CD pipeline scalability, repository monorepo/polyrepo engineering, test matrix parallelization, container build caching, and release deployment strategies.
---

# `scale_ci_cd_repo` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor examining CI/CD automation pipeline scaling, monorepo/polyrepo repository optimization, incremental build caching tools (Bazel, Nx, Turborepo), parallelized test matrix splitting, container layer build caching, artifact repository retention management, Git repository size boundaries (Git LFS), and progressive delivery rollout pipelines (Canary / Blue-Green).

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Incremental Build & Computation Caching**: Audit monorepo build tools to confirm incremental build execution graphs and remote action caching (Bazel, Nx, Turborepo, Gradle Build Cache) are enabled to prevent rebuilding unchanged modules.
- [ ] **Parallel Test Matrix Partitioning**: Verify CI build pipelines partition automated test suites into parallel execution runners based on historical execution time or test file counts to maintain sub-10-minute CI build feedback.
- [ ] **Docker Layer Caching & BuildKit Optimization**: Inspect Dockerfiles and CI container build steps to verify multi-stage caching (`--cache-from`, BuildKit inline cache) and dependency layer order optimizations are applied.
- [ ] **Artifact Repository Retention Policies**: Audit artifact registry configurations (Docker Registry, Nexus, Artifactory, GitHub Packages) to confirm automated retention and lifecycle cleanup rules prevent unbounded storage growth.
- [ ] **Git Repository Size & LFS Enforcement**: Audit repository history and file commit guidelines to ensure binary assets, large datasets, and compiled binaries use Git LFS or object storage rather than bloating Git history.
- [ ] **Progressive Delivery & Canary Deployment Automation**: Inspect deployment pipeline definitions to verify releases execute progressive deployment strategies (Canary rollouts, Blue-Green deployments with automated metrics rollback) rather than immediate all-at-once pod updates.
- [ ] **Pre-commit Hook Performance & Branch Protection Rules**: Audit pre-commit / pre-push Git hook scripts to ensure local checks execute within < 5 seconds (using incremental linting/staged file targeting) without blocking developer workflows.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_ci_cd_repo

## Audit Summary
- **Target Topic**: CI/CD Pipeline Scalability & Repository Engineering
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Incremental Build & Computation Caching | [PASS/WARN/FAIL] | `turbo.json:1` | Description of findings | Concrete fix recommendation |
| Parallel Test Matrix Partitioning | [PASS/WARN/FAIL] | `.github/workflows/ci.yml:25` | Description of findings | Concrete fix recommendation |
| Docker Layer Caching & BuildKit Optimization | [PASS/WARN/FAIL] | `.github/workflows/docker_build.yml:40` | Description of findings | Concrete fix recommendation |
| Artifact Repository Retention Policies | [PASS/WARN/FAIL] | `infra/artifactory_policy.tf:10` | Description of findings | Concrete fix recommendation |
| Git Repository Size & LFS Enforcement | [PASS/WARN/FAIL] | `.gitattributes:1` | Description of findings | Concrete fix recommendation |
| Progressive Delivery & Canary Deployment Automation | [PASS/WARN/FAIL] | `deploy/argo_rollout.yaml:15` | Description of findings | Concrete fix recommendation |
| Pre-commit Hook Performance & Branch Protection Rules | [PASS/WARN/FAIL] | `.pre-commit-config.yaml:1` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
