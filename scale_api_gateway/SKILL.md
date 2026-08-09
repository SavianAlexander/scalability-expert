---
name: scale_api_gateway
description: Specialized scalability auditor for API Gateways, edge routing, GraphQL federation, traffic proxy layers, and authentication offloading.
---

# `scale_api_gateway` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor examining a target codebase and infrastructure architecture for API Gateway configurations, edge routing efficiency, and proxy layer bottlenecks. The auditor inspects rate limiting at the edge, JWT/auth offloading, payload size validations, backend connection multiplexing, and routing timeout strategies.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Auth Offloading & Edge JWT Validation**: Verify that the API Gateway handles JWT token validation, rate-limiting, and basic auth at the edge, preventing unauthenticated traffic from saturating backend microservices.
- [ ] **Payload Size Limits & Request Validation**: Audit gateway configurations for strict request body size limits, URL length constraints, and schema validation to mitigate slow-loris and oversized payload attacks.
- [ ] **Backend Connection Pooling & Keep-Alive**: Inspect the proxy configuration (e.g., NGINX, Envoy, Kong) to ensure upstream keep-alive connections are enabled and backend socket multiplexing is optimized, avoiding TCP handshake overhead per request.
- [ ] **Timeouts & Circuit Breaking at Edge**: Verify the gateway implements strict read/write timeouts and circuit breakers for upstream routes to prevent edge thread exhaustion when a backend service hangs.
- [ ] **Response Caching & CDN Integration**: Audit the API Gateway for HTTP response caching (using standard `Cache-Control` headers) for read-heavy, low-churn endpoints, minimizing backend load.
- [ ] **GraphQL Federation / BFF Anti-Patterns**: For GraphQL or Backend-For-Frontend (BFF) setups, audit for excessive subgraph scatter-gather queries, un-paginated list resolutions, and lack of complexity/depth limits that could cause gateway OOM errors.
- [ ] **TLS Termination & Cipher Overhead**: Ensure TLS termination occurs strictly at the edge load balancer/gateway, using hardware-accelerated cyphers (e.g., AES-GCM), with internal microservice communication optionally using lighter TLS meshes like mTLS via Istio.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_api_gateway

## Audit Summary
- **Target Topic**: API Gateways & Edge Routing
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Auth Offloading & Edge JWT Validation | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Payload Size Limits & Request Validation | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Backend Connection Pooling & Keep-Alive | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Timeouts & Circuit Breaking at Edge | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Response Caching & CDN Integration | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| GraphQL Federation / BFF Anti-Patterns | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| TLS Termination & Cipher Overhead | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
