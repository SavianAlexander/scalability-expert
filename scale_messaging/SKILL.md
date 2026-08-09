---
name: scale_messaging
description: Specialized scalability auditor for distributed messaging, event-driven streaming, queue topologies, partition key strategy, and consumer idempotency.
---

# `scale_messaging` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting message broker architecture (Apache Kafka, Apache Pulsar, RabbitMQ, AWS SQS), event-driven schemas, pub-sub topologies, consumer group scalability, dead-letter queues (DLQ), poison pill isolation, and CQRS synchronization.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Consumer Idempotency & Deduplication**: Audit event processing handlers to ensure at-least-once message processing is fully idempotent (e.g., using transaction UUIDs, idempotency keys, or unique DB constraints before applying state mutations).
- [ ] **Schema Evolution & Compatibility Guards**: Verify event streams enforce strict schema validation and backward compatibility checks (e.g., Protobuf, Apache Avro, JSON Schema Registry checks in CI/CD).
- [ ] **Dead Letter Queue (DLQ) & Retry Policy**: Inspect message broker consumers and try/catch exception blocks to confirm unparseable or repeatedly failing messages route to a DLQ after exponential backoff retries.
- [ ] **Partition Key Cardinality & Hotspotting**: Audit producer partitioning strategy (e.g., Kafka `producer.send`) to ensure partition keys have high cardinality and avoid static null/low-cardinality keys that cause partition hotspots.
- [ ] **Consumer Backpressure & Lag Monitoring**: Verify consumers implement backpressure control (e.g., controlling max poll records, rate-limited execution) and publish real-time consumer lag metrics per partition.
- [ ] **Poison Pill Isolation & Circuit Breaking**: Confirm single malformed or poison pill payloads are isolated immediately without triggering continuous consumer crashes or blocking entire partition offsets.
- [ ] **CQRS Event Synchronization**: Audit CQRS architectures to ensure write model to read view projection pipelines handle eventual consistency propagation delays gracefully without client race conditions.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_messaging

## Audit Summary
- **Target Topic**: Distributed Messaging, Queuing & Event Streaming
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Consumer Idempotency & Deduplication | [PASS/WARN/FAIL] | `path/to/consumer.py:45` | Description of findings | Concrete fix recommendation |
| Schema Evolution & Compatibility Guards | [PASS/WARN/FAIL] | `schemas/order_event.proto` | Description of findings | Concrete fix recommendation |
| Dead Letter Queue (DLQ) & Retry Policy | [PASS/WARN/FAIL] | `path/to/queue.py:90` | Description of findings | Concrete fix recommendation |
| Partition Key Cardinality & Hotspotting | [PASS/WARN/FAIL] | `path/to/producer.py:30` | Description of findings | Concrete fix recommendation |
| Consumer Backpressure & Lag Monitoring | [PASS/WARN/FAIL] | `path/to/worker.py:120` | Description of findings | Concrete fix recommendation |
| Poison Pill Isolation & Circuit Breaking | [PASS/WARN/FAIL] | `path/to/handler.py:65` | Description of findings | Concrete fix recommendation |
| CQRS Event Synchronization | [PASS/WARN/FAIL] | `path/to/projections.py:110` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
