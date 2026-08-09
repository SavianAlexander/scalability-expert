---
name: scale_security
description: Specialized scalability auditor for distributed security, least-privilege IAM, secret scanning, dynamic secret rotation, KMS encryption, runtime syscall auditing, and SCA scanning.
---

# `scale_security` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting distributed security architectures, Cloud IAM least-privilege policies (Repokid, Aardvark), JWT/OAuth identity propagation down RPC chains, hardcoded secret detectors in CI, dynamic secret injection (HashiCorp Vault, AWS Secrets Manager), Enterprise Key Management Systems (KMS), runtime syscall auditing (Falco, osquery), and automated Software Composition Analysis (SCA) dependency scanners.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Least-Privilege Cloud IAM Policy Enforcement**: Audit AWS IAM / GCP Service Account policies using automated analysis tools (Repokid, Aardvark) to eliminate over-privileged wildcard permissions (e.g., `"Action": "*"`) across production workloads.
- [ ] **Secure Identity Context RPC Propagation**: Verify edge authentication tokens (JWT, OAuth) are validated at the gateway and mapped into secure internal identity contexts before downstream gRPC / HTTP RPC propagation.
- [ ] **Automated Secret Detector Integration in CI**: Audit CI/CD pipelines to confirm automated secret detectors (TruffleHog, Gitleaks, Yelp Secret Detector) scan repository commits and container layers to block committed keys or credentials.
- [ ] **Dynamic Secret Injection & Short TTL Rotation**: Inspect application configuration mechanisms to confirm database credentials, API keys, and TLS certificates are dynamically fetched from secret managers (Vault, AWS Secrets Manager) with short TTLs.
- [ ] **KMS Encryption at Rest with Customer-Managed Keys**: Audit database, object store, and block storage manifests to ensure encryption at rest utilizes Key Management Services (KMS) with Customer-Managed Keys (CMK).
- [ ] **Runtime Container Syscall Auditing**: Verify production Kubernetes node clusters run container security auditing agents (Falco, osquery, eBPF probes) to detect unauthorized shell execution or unexpected system call behavior in real time.
- [ ] **Automated SCA Dependency Vulnerability Scanning**: Inspect build pipelines to confirm Software Composition Analysis (SCA) tools (Snyk, Dependabot, Trivy) run on every pull request and fail builds containing High or Critical CVE vulnerabilities.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_security

## Audit Summary
- **Target Topic**: Distributed Security, Identity & Secret Management
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Least-Privilege Cloud IAM Policy Enforcement | [PASS/WARN/FAIL] | `infra/iam_roles.tf:10` | Description of findings | Concrete fix recommendation |
| Secure Identity Context RPC Propagation | [PASS/WARN/FAIL] | `auth/context_interceptor.go:25` | Description of findings | Concrete fix recommendation |
| Automated Secret Detector Integration in CI | [PASS/WARN/FAIL] | `.github/workflows/security.yml:12` | Description of findings | Concrete fix recommendation |
| Dynamic Secret Injection & Short TTL Rotation | [PASS/WARN/FAIL] | `config/vault_loader.py:40` | Description of findings | Concrete fix recommendation |
| KMS Encryption at Rest with Customer-Managed Keys | [PASS/WARN/FAIL] | `infra/storage.tf:30` | Description of findings | Concrete fix recommendation |
| Runtime Container Syscall Auditing | [PASS/WARN/FAIL] | `deploy/falco/falco_rules.yaml:5` | Description of findings | Concrete fix recommendation |
| Automated SCA Dependency Vulnerability Scanning | [PASS/WARN/FAIL] | `.github/workflows/snyk_scan.yml:15` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
