---
name: scale_caching
description: Specialized scalability auditor for distributed caching, key-space design, eviction policies, cache stampede prevention, and in-memory data store performance.
---

# `scale_caching` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor examining a target codebase and infrastructure architecture for distributed caching issues, in-memory data store bottlenecks, and invalidation anti-patterns. The auditor inspects cache topologies (Redis, Memcached, EVCache), TTL configurations, key-space namespacing, consistent hashing strategies, cache fallbacks, and connection pooling.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Cache Key Namespacing & Explicit TTL**: Audit all cache set and mutation operations (`redis.set`, `memcached.set`, `cache.put`) to ensure explicit Time-To-Live (TTL) parameters are configured and keys follow structured, versioned namespaces (e.g., `user:v2:profile:{id}`).
- [ ] **Thundering Herd & Cache Stampede Protection**: Verify high-traffic read paths employ single-flight locking, probabilistic early expiration (cache smearing / x-fetch algorithm), or background prefetching for hot keys to prevent database overload upon cache misses.
- [ ] **Cache Invalidation & Transactional Coupling**: Audit write operations to ensure cache invalidation happens transactionally post-database-commit or via Change Data Capture (CDC) event streams, preventing stale cache reads or race conditions.
- [ ] **Big Keys & Memory Allocation Limits**: Audit Redis/Memcached data structures (hashes, sets, sorted sets, lists) for unbounded growth (e.g., Redis HSET containing >10,000 fields or >1MB values) without pagination or TTL cleanup.
- [ ] **Eviction Policy & Memory Configuration**: Inspect cache server configurations (`maxmemory-policy`, `maxmemory`) to ensure appropriate eviction algorithms (e.g., `volatile-lru`, `allkeys-lru`) are enabled for transient workload patterns.
- [ ] **Cache Failure Fallback & Graceful Degradation**: Verify application code gracefully handles cache cluster downtime or latency spikes (e.g., falling back to read replicas, default values, or circuit breakers) without cascading application failures.
- [ ] **Connection Pooling & Socket Reuse**: Inspect client driver initialization code to confirm Redis/Memcached connections utilize bounded connection pools with socket timeouts rather than opening unpooled sockets per incoming request.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_caching

## Audit Summary
- **Target Topic**: Distributed Caching & In-Memory Systems
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Cache Key Namespacing & Explicit TTL | [PASS/WARN/FAIL] | `path/to/file.py:42` | Description of findings | Concrete fix recommendation |
| Thundering Herd & Cache Stampede Protection | [PASS/WARN/FAIL] | `path/to/file.py:88` | Description of findings | Concrete fix recommendation |
| Cache Invalidation & Transactional Coupling | [PASS/WARN/FAIL] | `path/to/file.py:112` | Description of findings | Concrete fix recommendation |
| Big Keys & Memory Allocation Limits | [PASS/WARN/FAIL] | `path/to/file.py:150` | Description of findings | Concrete fix recommendation |
| Eviction Policy & Memory Configuration | [PASS/WARN/FAIL] | `config/redis.conf:15` | Description of findings | Concrete fix recommendation |
| Cache Failure Fallback & Graceful Degradation | [PASS/WARN/FAIL] | `path/to/file.py:200` | Description of findings | Concrete fix recommendation |
| Connection Pooling & Socket Reuse | [PASS/WARN/FAIL] | `path/to/db.py:30` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
