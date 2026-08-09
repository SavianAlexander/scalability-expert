---
name: scale_rate_limiting
description: Specialized scalability auditor for rate limiting algorithms, token bucket/sliding window implementations, response standard compliance, and client quota enforcement.
---

# `scale_rate_limiting` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting rate limiting algorithms (Token Bucket, Leaky Bucket, Sliding Window Log, Fixed Window Counter), Redis atomic operation overhead, rate limit key granularity, standard IETF HTTP response header formatting, multi-tenant quota management, and adaptive throttling under resource exhaustion.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Algorithm Selection & Boundary Precision**: Audit rate limiting implementations to ensure window algorithms (e.g., Sliding Window Counter via Redis Lua scripts) prevent burst traffic spikes at fixed window boundaries.
- [ ] **Granular Key Space Identification**: Verify rate limiters evaluate requests against high-cardinality composite keys (e.g., `rate:v1:{tenant_id}:{api_key}:{endpoint}`) rather than relying solely on coarse IP address tracking.
- [ ] **IETF Standard Rate Limit Headers**: Inspect API response pipelines to verify compliance with standard HTTP rate limit headers (`X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`, `Retry-After`) on HTTP 429 Too Many Requests responses.
- [ ] **Distributed Storage Lock & Lua Overhead**: Audit distributed backend operations (e.g., Redis `EVALSHA` scripts) to ensure rate check execution is atomic and completes in sub-millisecond execution times without blocking Redis threads.
- [ ] **Tiered Quota Async Enforcement**: Verify long-term account tier quotas (e.g., monthly 1,000,000 request caps) are tracked out-of-band or via asynchronous counters to avoid slowing critical API request paths.
- [ ] **Adaptive Throttling & Dynamic Load Shedding**: Audit rate limiting rules for dynamic adjustment triggers during high backend CPU/memory usage or upstream latency spikes.
- [ ] **Rate Limiter Fallback & Circuit Breaking**: Verify application gateways handle rate limiter storage cluster outages gracefully (e.g., failing open with local emergency rate limits or circuit breaking) without rejecting 100% of legitimate user traffic.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_rate_limiting

## Audit Summary
- **Target Topic**: Distributed Rate Limiting & Traffic Shaping
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Algorithm Selection & Boundary Precision | [PASS/WARN/FAIL] | `middleware/rate_limiter.py:25` | Description of findings | Concrete fix recommendation |
| Granular Key Space Identification | [PASS/WARN/FAIL] | `security/throttle_keys.go:14` | Description of findings | Concrete fix recommendation |
| IETF Standard Rate Limit Headers | [PASS/WARN/FAIL] | `middleware/response_headers.py:60` | Description of findings | Concrete fix recommendation |
| Distributed Storage Lock & Lua Overhead | [PASS/WARN/FAIL] | `scripts/sliding_window.lua:1` | Description of findings | Concrete fix recommendation |
| Tiered Quota Async Enforcement | [PASS/WARN/FAIL] | `services/quota_tracker.py:95` | Description of findings | Concrete fix recommendation |
| Adaptive Throttling & Dynamic Load Shedding | [PASS/WARN/FAIL] | `gateway/load_shedder.go:40` | Description of findings | Concrete fix recommendation |
| Rate Limiter Fallback & Circuit Breaking | [PASS/WARN/FAIL] | `middleware/rate_limiter.py:110` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
