---
name: scale_resilience_failover
description: Specialized scalability auditor for high availability, multi-region failover, automated database failover, DNS traffic steering, RPO/RTO parameters, and chaos engineering.
---

# `scale_resilience_failover` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting High Availability (HA), Multi-Region Active-Active and Active-Passive failover, global traffic steering (Route 53 ARC, Anycast DNS), database failover automation (Patroni, Orchestrator), RPO/RTO compliance, chaos engineering validation, and warm standby cache readiness.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Cross-Region Database Replication & RPO/RTO Definition**: Audit multi-region database replication topologies (AWS Aurora Global Database, CockroachDB, active-active Cassandra) and verify Recovery Point Objective (RPO) and Recovery Time Objective (RTO) parameters are documented and tested.
- [ ] **Stateless Global Traffic Steering**: Verify global DNS / Anycast routing configurations (e.g., Route 53 Application Recovery Controller, Cloudflare Load Balancing) can drain a degraded region or data center within 60 seconds without session loss.
- [ ] **Automated Database Master Failover & Split-Brain Safeguards**: Inspect database cluster failover controllers (Patroni, Orchestrator, AWS RDS Multi-AZ) for automated consensus health checks, stonith/fencing mechanisms, and split-brain prevention.
- [ ] **Chaos Engineering Pipeline Integration**: Audit continuous integration and staging infrastructure for automated chaos experiment validation (Chaos Mesh, LitmusChaos, Gremlin) simulating node, availability zone, and region network partitions.
- [ ] **Automated Disaster Recovery (DR) Drill Automation**: Check runbooks and automation scripts to verify bi-annual or continuous automated failover drills execute without manual intervention or data corruption.
- [ ] **Localized Multi-Region Read/Write Execution**: Inspect cross-service call paths to confirm requests execute local reads and writes within the local region, avoiding synchronous cross-region RPC dependencies.
- [ ] **Warm Standby Capacity & Cache Warming**: Verify secondary failover regions maintain pre-provisioned resource capacity and automated cache warming pipelines capable of absorbing 100% of diverted production traffic seamlessly.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_resilience_failover

## Audit Summary
- **Target Topic**: High Availability, Disaster Recovery & Multi-Region Failover
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Cross-Region Database Replication & RPO/RTO Definition | [PASS/WARN/FAIL] | `infra/terraform/aurora.tf:20` | Description of findings | Concrete fix recommendation |
| Stateless Global Traffic Steering | [PASS/WARN/FAIL] | `infra/terraform/route53_arc.tf:15` | Description of findings | Concrete fix recommendation |
| Automated Database Master Failover & Split-Brain Safeguards | [PASS/WARN/FAIL] | `config/patroni.yml:30` | Description of findings | Concrete fix recommendation |
| Chaos Engineering Pipeline Integration | [PASS/WARN/FAIL] | `.github/workflows/chaos.yml:1` | Description of findings | Concrete fix recommendation |
| Automated Disaster Recovery (DR) Drill Automation | [PASS/WARN/FAIL] | `scripts/dr_failover.sh:10` | Description of findings | Concrete fix recommendation |
| Localized Multi-Region Read/Write Execution | [PASS/WARN/FAIL] | `services/user_service.py:85` | Description of findings | Concrete fix recommendation |
| Warm Standby Capacity & Cache Warming | [PASS/WARN/FAIL] | `scripts/cache_warmer.py:25` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
