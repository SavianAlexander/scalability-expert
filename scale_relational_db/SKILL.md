---
name: scale_relational_db
description: Specialized scalability auditor for relational databases, indexing performance, N+1 query elimination, connection pooling, sharding strategies, and online schema migrations.
---

# `scale_relational_db` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor reviewing relational database usage (MySQL, PostgreSQL, Vitess, Citus). The auditor inspects SQL query execution plans (`EXPLAIN ANALYZE`), indexing efficiency, ORM usage for N+1 anti-patterns, connection pool sizing (HikariCP, PgBouncer), read-replica replication lag, database sharding keys, and zero-downtime DDL migrations.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Unindexed Query Identification & Execution Plans**: Audit SQL query logs and ORM query builders for missing composite indexes on `WHERE`, `JOIN`, `ORDER BY`, and `GROUP BY` clauses using `EXPLAIN ANALYZE`.
- [ ] **N+1 Query Detection & Batch Loading**: Audit application data access layers for sequential database queries inside loops; enforce eager loading (`JOIN FETCH`, `preload`, `select_related`) or batched IDs (`WHERE id IN (...)`).
- [ ] **Replication Lag Resilience & Read Routing**: Verify read operations executed against read replicas gracefully handle replication lag or route strict read-after-write operations directly to the primary/master node.
- [ ] **Sharding Key Selection & Cross-Shard Joins**: Audit sharded database architectures (Vitess, Citus, custom sharding) to confirm shard keys distribute data evenly and eliminate cross-shard joins or distributed transactions.
- [ ] **Connection Pool Sizing & Proxy Management**: Inspect connection pool settings (`max_connections`, `pool_size`, PgBouncer transaction pooling) to ensure application instances cannot exhaust database connection limits under peak concurrency.
- [ ] **Lock Contention & Transaction Isolation**: Audit explicit transaction lock statements (`SELECT ... FOR UPDATE`, table locks) and transaction duration to prevent deadlocks and long-held row locks.
- [ ] **Zero-Downtime Online Schema Migrations**: Audit database migration scripts to verify non-blocking DDL tools (`gh-ost`, `pt-online-schema-change`, `pg_repack`, shadow tables) are used for large production tables.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_relational_db

## Audit Summary
- **Target Topic**: Relational Database Scaling, Replication & Sharding
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Unindexed Query Identification & Execution Plans | [PASS/WARN/FAIL] | `db/queries/users.sql:15` | Description of findings | Concrete fix recommendation |
| N+1 Query Detection & Batch Loading | [PASS/WARN/FAIL] | `services/order_service.py:72` | Description of findings | Concrete fix recommendation |
| Replication Lag Resilience & Read Routing | [PASS/WARN/FAIL] | `config/database.py:40` | Description of findings | Concrete fix recommendation |
| Sharding Key Selection & Cross-Shard Joins | [PASS/WARN/FAIL] | `db/sharding_config.json:8` | Description of findings | Concrete fix recommendation |
| Connection Pool Sizing & Proxy Management | [PASS/WARN/FAIL] | `config/datasource.yaml:22` | Description of findings | Concrete fix recommendation |
| Lock Contention & Transaction Isolation | [PASS/WARN/FAIL] | `repositories/payment_repo.py:105` | Description of findings | Concrete fix recommendation |
| Zero-Downtime Online Schema Migrations | [PASS/WARN/FAIL] | `db/migrations/V42__add_index.sql` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
