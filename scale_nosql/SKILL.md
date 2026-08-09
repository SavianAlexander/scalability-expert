---
name: scale_nosql
description: Specialized scalability auditor for NoSQL and key-value datastores, partition key cardinality, query pattern alignment, tombstone thresholds, and consistency configurations.
---

# `scale_nosql` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor evaluating NoSQL databases (Apache Cassandra, Amazon DynamoDB, MongoDB, Couchbase, ScyllaDB). The auditor inspects data models, partition key cardinality, tombstone generation risks, read/write consistency levels (`LOCAL_QUORUM`, `EVENTUAL`, `STRONG`), document size boundaries, and secondary indexing overhead.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Partition Key High Cardinality**: Audit Cassandra/DynamoDB primary key definitions to ensure partition keys possess sufficient cardinality to distribute writes evenly and avoid single-node hot partitions.
- [ ] **Access Pattern Query Alignment**: Verify NoSQL tables are designed strictly around application access patterns (denormalized schemas per query) rather than attempting relational normalization or unindexed filtering.
- [ ] **Cassandra Tombstone Threshold Prevention**: Audit Cassandra query patterns for range scans or frequent `DELETE` operations that generate tombstones exceeding read limits or causing garbage collection pauses.
- [ ] **DynamoDB Auto-Scaling & Throttling Guards**: Inspect DynamoDB configurations for auto-scaling policies, RCU/WCU provisioning, global table multi-region setups, and cloud metric alerts on throttled requests.
- [ ] **MongoDB Document Size & Array Growth Limits**: Audit MongoDB collections for unbounded embedded arrays within single documents to prevent exceeding the 16MB document size ceiling.
- [ ] **Global Secondary Index (GSI) Overhead**: Inspect secondary index definitions in key-value/document stores to verify write-throughput amplification and storage expansion costs are controlled.
- [ ] **Explicit Consistency Level Declarations**: Audit database client configuration and query execution code to confirm read/write operations explicitly declare required consistency levels (`LOCAL_QUORUM`, `EVENTUAL`, `STRONG`).

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_nosql

## Audit Summary
- **Target Topic**: NoSQL & Specialized Data Stores
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Partition Key High Cardinality | [PASS/WARN/FAIL] | `models/schema.cql:10` | Description of findings | Concrete fix recommendation |
| Access Pattern Query Alignment | [PASS/WARN/FAIL] | `path/to/repository.py:50` | Description of findings | Concrete fix recommendation |
| Cassandra Tombstone Threshold Prevention | [PASS/WARN/FAIL] | `queries/analytics.cql:25` | Description of findings | Concrete fix recommendation |
| DynamoDB Auto-Scaling & Throttling Guards | [PASS/WARN/FAIL] | `infrastructure/dynamo.tf:15` | Description of findings | Concrete fix recommendation |
| MongoDB Document Size & Array Growth Limits | [PASS/WARN/FAIL] | `models/user_document.js:35` | Description of findings | Concrete fix recommendation |
| Global Secondary Index (GSI) Overhead | [PASS/WARN/FAIL] | `infrastructure/db_gsi.tf:40` | Description of findings | Concrete fix recommendation |
| Explicit Consistency Level Declarations | [PASS/WARN/FAIL] | `path/to/db_client.py:80` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
