---
name: scale_load_balancing
description: Specialized scalability auditor for L4/L7 load balancers, edge CDNs, TLS termination, distributed rate limiting, quota engines, and connection draining.
---

# `scale_load_balancing` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor examining Layer 4 and Layer 7 load balancing (Envoy, NGINX, HAProxy, Katran), API Gateways (Zuul, Kong, Traefik), CDN edge caching, HTTP keep-alive connection reuse, TLS offloading, WAF / DDoS protections, and connection draining during deployment transitions.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Distributed Rate Limiting Engine**: Audit public API endpoints to confirm distributed rate limiters (e.g., Redis-backed sliding window or Token Bucket algorithms) are enforced by client API key, IP address, or OAuth client ID.
- [ ] **L7 Load Balancing Algorithm**: Inspect load balancer target group routing policies; ensure naive round-robin is replaced with least-connections, power of two random choices, or peak-EWMA algorithms for heterogeneous workloads.
- [ ] **Edge CDN Cache Control Headers**: Audit HTTP headers (`Cache-Control`, `Surrogate-Control`, `Vary`) emitted by backend application handlers to maximize static asset and dynamic content caching at CDN edge nodes.
- [ ] **TLS Termination & Keep-Alive Connection Pools**: Inspect L4/L7 proxy configurations to confirm TLS termination is offloaded at the edge and HTTP keep-alive connections to upstream backends are reused with configurable timeouts.
- [ ] **Tiered Quota Engine & Latency Isolation**: Audit API quota enforcement logic to ensure user account quota calculations run asynchronously or out-of-band without increasing synchronous API response latency.
- [ ] **DDoS Protection & Web Application Firewall (WAF)**: Verify edge proxies enforce WAF inspection rules, automated SYN flood mitigation, and bad bot / IP rate throttling at the perimeter.
- [ ] **Zero-Downtime Connection Draining**: Inspect deployment automation manifests to ensure load balancers implement graceful target deregistration (`deregistration_delay` / connection draining) before terminating application pods or instances.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_load_balancing

## Audit Summary
- **Target Topic**: Distributed Load Balancing, Edge & Rate Limiting
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Distributed Rate Limiting Engine | [PASS/WARN/FAIL] | `gateway/rate_limiter.go:30` | Description of findings | Concrete fix recommendation |
| L7 Load Balancing Algorithm | [PASS/WARN/FAIL] | `haproxy.cfg:45` | Description of findings | Concrete fix recommendation |
| Edge CDN Cache Control Headers | [PASS/WARN/FAIL] | `controllers/asset_controller.py:18` | Description of findings | Concrete fix recommendation |
| TLS Termination & Keep-Alive Connection Pools | [PASS/WARN/FAIL] | `nginx/conf.d/upstream.conf:12` | Description of findings | Concrete fix recommendation |
| Tiered Quota Engine & Latency Isolation | [PASS/WARN/FAIL] | `services/quota_service.py:65` | Description of findings | Concrete fix recommendation |
| DDoS Protection & Web Application Firewall (WAF) | [PASS/WARN/FAIL] | `terraform/aws_waf.tf:10` | Description of findings | Concrete fix recommendation |
| Zero-Downtime Connection Draining | [PASS/WARN/FAIL] | `k8s/service.yaml:25` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
