---
name: scale_stability
description: Specialized scalability auditor for system stability patterns, circuit breakers, timeouts, retries with backoff and jitter, bulkheads, load shedding, and log isolation.
---

# `scale_stability` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting system stability engineering patterns (Resilience4j, Envoy Circuit Breakers, Hystrix, Go failsafe), client network timeouts, exponential backoff with full jitter, thread pool bulkheads, resource-based load shedding, and disk log volume isolation.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Circuit Breakers on Downstream Calls**: Audit all HTTP, gRPC, database, and queue client wrappers to verify circuit breakers open automatically after N consecutive failures or high error rate percentages (e.g., >50% failure rate over 10s window).
- [ ] **Explicit Timeouts & Deadline Propagation**: Verify every outgoing network client configures explicit connection, read, and write timeouts, and propagates incoming request deadline headers across service call chains.
- [ ] **Retry Exponential Backoff with Full Jitter**: Inspect retry loops and client configurations to confirm retries utilize exponential backoff combined with randomized full jitter to prevent thundering herd retry storms.
- [ ] **Bulkhead Isolation & Dedicated Thread Pools**: Audit application thread pools, connection pools, and worker queues to ensure critical and non-critical downstream dependencies run in isolated pools (preventing one degraded dependency from starving all worker threads).
- [ ] **CPU/Memory Resource Load Shedding**: Verify microservice frameworks implement load shedding middleware that rejects low-priority incoming requests (returning HTTP 503 / 429) when CPU or memory usage exceeds safe operating limits (e.g., >85%).
- [ ] **Graceful Feature Degradation Fallbacks**: Audit failure handling in application handlers to confirm non-essential features (e.g., recommendation widgets, non-critical telemetry, optional social counts) degrade gracefully to static defaults or cached values during dependency outages.
- [ ] **Log Volume Isolation & Disk Protection**: Verify application, access, and debug logs are written to dedicated log storage volumes or asynchronous log aggregators (e.g., FluentBit, Vector) to prevent log floods from filling up application OS disks.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_stability

## Audit Summary
- **Target Topic**: System Stability Patterns & Fault Isolation
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Circuit Breakers on Downstream Calls | [PASS/WARN/FAIL] | `http/client_wrapper.py:35` | Description of findings | Concrete fix recommendation |
| Explicit Timeouts & Deadline Propagation | [PASS/WARN/FAIL] | `grpc/interceptor.go:20` | Description of findings | Concrete fix recommendation |
| Retry Exponential Backoff with Full Jitter | [PASS/WARN/FAIL] | `utils/retry.py:50` | Description of findings | Concrete fix recommendation |
| Bulkhead Isolation & Dedicated Thread Pools | [PASS/WARN/FAIL] | `config/thread_pools.yaml:12` | Description of findings | Concrete fix recommendation |
| CPU/Memory Resource Load Shedding | [PASS/WARN/FAIL] | `middleware/load_shedder.py:15` | Description of findings | Concrete fix recommendation |
| Graceful Feature Degradation Fallbacks | [PASS/WARN/FAIL] | `services/home_feed.py:90` | Description of findings | Concrete fix recommendation |
| Log Volume Isolation & Disk Protection | [PASS/WARN/FAIL] | `k8s/volume_mounts.yaml:18` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
