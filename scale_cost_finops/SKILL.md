---
name: scale_cost_finops
description: Specialized scalability auditor for cloud cost optimization, resource rightsizing, infrastructural FinOps, and eliminating architectural waste.
---

# `scale_cost_finops` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor focusing on cloud economics and architectural FinOps. A scalable system that bankrupts the company is a failed system. The auditor inspects Kubernetes resource limits, database right-sizing, cross-AZ data transfer costs, spot instance utilization, and object storage lifecycles to eliminate infrastructural waste.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase and IaC (Infrastructure as Code):

- [ ] **Kubernetes CPU/Memory Right-Sizing**: Audit Kubernetes manifests (Helm/Kustomize). Ensure CPU/Memory `requests` and `limits` are tightly bound to actual usage metrics, avoiding massive over-provisioning and low utilization.
- [ ] **Spot Instance & Preemptible Node Utilization**: Verify that stateless, fault-tolerant workloads (e.g., background workers, CI/CD runners, batch processing) are scheduled on Spot/Preemptible instances rather than expensive On-Demand nodes.
- [ ] **Cross-AZ & Egress Data Transfer Costs**: Inspect network routing and API calls. Ensure inter-service communication prefers local AZ routing, and massive data transfers (like backups or log streaming) are compressed to minimize exorbitant cross-AZ or internet egress fees.
- [ ] **Database Idle Capacity & Serverless DBs**: Audit development/staging database provisioning and production read replicas. Recommend shutting down idle instances on schedules or migrating spiky workloads to Serverless databases (e.g., Aurora Serverless) to save costs.
- [ ] **Object Storage Lifecycle Policies**: Verify S3/GCS buckets have lifecycle rules configured to automatically transition older, infrequently accessed data to cheaper cold storage (e.g., Glacier, Archive) and delete temporary data.
- [ ] **Zombie Infrastructure & Orphaned Disks**: Audit IaC scripts and cloud environments for unattached EBS volumes, unassigned Elastic IPs, forgotten staging clusters, and outdated snapshots that silently bleed budget.
- [ ] **Log Retention & Aggregation Costs**: Inspect observability configurations (Datadog, ELK, Splunk). Ensure high-volume debug/trace logs are aggressively sampled or dropped before ingestion, and retention periods for hot storage are strictly limited.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_cost_finops

## Audit Summary
- **Target Topic**: FinOps & Cost Optimization
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Kubernetes CPU/Memory Right-Sizing | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Spot Instance & Preemptible Node Utilization | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Cross-AZ & Egress Data Transfer Costs | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Database Idle Capacity & Serverless DBs | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Object Storage Lifecycle Policies | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Zombie Infrastructure & Orphaned Disks | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Log Retention & Aggregation Costs | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
