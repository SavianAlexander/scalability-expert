---
name: scale_microservices
description: Specialized scalability auditor for microservice architecture, domain boundaries, container packaging, Kubernetes orchestration, probe isolation, and Saga transactions.
---

# `scale_microservices` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor evaluating microservice architecture, domain boundaries (Domain-Driven Design / DOMA), API Gateways, Backend-For-Frontend (BFF) layers, Dockerfile container optimizations, Kubernetes deployment resources, health probe configurations, and distributed transaction management via the Saga pattern.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Strict Domain Boundaries & No Shared DBs**: Audit microservice domain definitions to verify services interact exclusively via well-defined API/event interfaces and never perform cross-database queries against databases owned by other services.
- [ ] **Container Image Minimalization & Non-Root Execution**: Inspect Dockerfiles for multi-stage builds, non-root user enforcement (`USER 10001`), explicit version tags, and minimal base images (distroless / Alpine) to reduce attack surface and deployment cold-starts.
- [ ] **Kubernetes CPU & Memory Limit Enforcement**: Audit Kubernetes manifests (`deployment.yaml`) to confirm all containers define explicit CPU/Memory `requests` and `limits` to prevent OOMKills and noisy neighbor CPU starvation.
- [ ] **Probe Isolation from Downstream Dependencies**: Verify Kubernetes liveness and readiness probes perform strictly local node/health checks and do not query downstream databases or services (preventing cascading pod restarts during dependency outages).
- [ ] **API Gateway & BFF Service Tiering**: Check that mobile/web clients route requests through dedicated API Gateways or Backend-For-Frontend (BFF) aggregation services rather than opening direct fan-out connections to internal microservices.
- [ ] **Saga Pattern & Distributed Transaction Control**: Audit multi-service update flows to confirm the implementation of Saga pattern orchestration/choreography with compensating transactions instead of assuming two-phase commits (2PC) or single-DB ACID atomicity.
- [ ] **Service Mesh mTLS & Routing Policies**: Audit Istio/Linkerd service mesh policy manifests for mutual TLS (mTLS) enforcement, cross-cluster egress rules, and default request timeout thresholds.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_microservices

## Audit Summary
- **Target Topic**: Microservice Architecture & Service Orchestration
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Strict Domain Boundaries & No Shared DBs | [PASS/WARN/FAIL] | `services/order/db.py:30` | Description of findings | Concrete fix recommendation |
| Container Image Minimalization & Non-Root Execution | [PASS/WARN/FAIL] | `Dockerfile:1` | Description of findings | Concrete fix recommendation |
| Kubernetes CPU & Memory Limit Enforcement | [PASS/WARN/FAIL] | `deploy/kubernetes/deployment.yaml:45` | Description of findings | Concrete fix recommendation |
| Probe Isolation from Downstream Dependencies | [PASS/WARN/FAIL] | `deploy/kubernetes/deployment.yaml:80` | Description of findings | Concrete fix recommendation |
| API Gateway & BFF Service Tiering | [PASS/WARN/FAIL] | `gateway/routes.json:12` | Description of findings | Concrete fix recommendation |
| Saga Pattern & Distributed Transaction Control | [PASS/WARN/FAIL] | `services/payment/saga_orchestrator.py:15` | Description of findings | Concrete fix recommendation |
| Service Mesh mTLS & Routing Policies | [PASS/WARN/FAIL] | `deploy/istio/peer_authentication.yaml:5` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
