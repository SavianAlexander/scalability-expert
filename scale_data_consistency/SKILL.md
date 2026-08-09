---
name: scale_data_consistency
description: Specialized scalability auditor for distributed transactions, state management, eventual consistency patterns, and distributed lock handling.
---

# `scale_data_consistency` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor examining a target codebase for complex distributed state management. It focuses on how data consistency is maintained across disparate microservices and datastores. The auditor inspects transactional boundaries, Saga patterns, outbox pattern implementations, idempotent API designs, and distributed locking mechanisms.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Transactional Outbox Pattern**: Verify that services publishing domain events to message brokers do so transactionally alongside database writes (e.g., using the Outbox Pattern or CDC/Debezium) to prevent dual-write inconsistencies.
- [ ] **API Idempotency**: Audit state-mutating API endpoints (POST/PUT/PATCH) for strict idempotency keys, ensuring retried network requests do not result in duplicate financial transactions or data creation.
- [ ] **Distributed Transactions (Saga Pattern)**: Inspect cross-service workflows. Ensure legacy two-phase commit (2PC) is avoided in favor of the Saga Pattern (choreography/orchestration) with explicit compensating transactions for rollback handling.
- [ ] **Distributed Locking & Deadlock Risks**: Audit the use of distributed locks (e.g., Redis Redlock, ZooKeeper). Verify locks have explicit TTLs, fencing tokens are used to prevent split-brain writes, and deadlocks are actively monitored.
- [ ] **Eventual Consistency UI Handling**: Check how eventual consistency is presented to the client. Ensure the system does not confuse users (e.g., showing a stale read immediately after a write) by utilizing read-your-own-writes consistency strategies.
- [ ] **Conflict Resolution & Vector Clocks**: For distributed master-master databases or highly concurrent writes, verify conflict resolution logic (e.g., Last-Writer-Wins, CRDTs, or vector clocks) is intentionally designed rather than accidental.
- [ ] **Background Reconciliation Jobs**: Ensure critical eventually consistent workflows have background reconciliation sweeps (cron jobs) to detect, alert, and repair split-brain states or failed orchestrations.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_data_consistency

## Audit Summary
- **Target Topic**: Distributed Data Consistency
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Transactional Outbox Pattern | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| API Idempotency | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Distributed Transactions (Saga Pattern) | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Distributed Locking & Deadlock Risks | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Eventual Consistency UI Handling | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Conflict Resolution & Vector Clocks | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Background Reconciliation Jobs | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
