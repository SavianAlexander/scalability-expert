---
name: scale_tracing_monitoring
description: Specialized scalability auditor for distributed tracing, context propagation, telemetry overhead, SLI/SLO definitions, error budget burn rates, and correlated logs.
---

# `scale_tracing_monitoring` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor examining distributed tracing systems (OpenTelemetry, Zipkin, Jaeger), trace sampling algorithms, metric collection backends (Prometheus, M3, Datadog), SLI/SLO definition standards, multi-window error budget burn-rate alerts, alert flap suppression, and correlated trace-log telemetry.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Context Propagation Header Ingestion & Forwarding**: Audit all inter-service HTTP, gRPC, and message queue clients to verify distributed tracing context headers (`traceparent`, `b3`, `baggage`) are automatically extracted and injected across service boundaries.
- [ ] **Adaptive & Tail Sampling Configuration**: Verify high-throughput production environments employ probabilistic head sampling (e.g., 1%-5% normal traffic sampling) or tail-based sampling rules to capture 100% of error traces without overwhelming telemetry storage.
- [ ] **Asynchronous Non-Blocking Telemetry Exporters**: Inspect OpenTelemetry collector SDK initializations to confirm span batching and memory-buffered asynchronous export (UDP / gRPC) are configured to prevent telemetry calls from blocking application request execution.
- [ ] **Sensitive Data & PII Scrubbing**: Audit tracing filters, span attributes, and log formatters to confirm PII (passwords, JWT tokens, credit card numbers, social security numbers) is scrubbed prior to exporter delivery.
- [ ] **Correlated Structured Log Injections**: Verify logging frameworks automatically inject active `trace_id` and `span_id` fields into JSON log outputs for seamless correlation between trace graphs and log lines in APM dashboards.
- [ ] **Multi-Window Error Budget Burn-Rate Alerting**: Inspect Prometheus / Alertmanager alerting rules to verify critical alerts trigger on multi-window error budget burn-rate thresholds (e.g., 2% error budget consumed in 1 hour) rather than unstable point-in-time metric spikes.
- [ ] **Alert Flap Suppression & Actionable Runbook Links**: Verify alert rules set explicit `for` durations (e.g., `for: 5m`) to suppress transient alerting noise and contain direct URLs to actionable operational runbooks and troubleshooting dashboards.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_tracing_monitoring

## Audit Summary
- **Target Topic**: Distributed Tracing, Telemetry & SLO Alerting
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Context Propagation Header Ingestion & Forwarding | [PASS/WARN/FAIL] | `tracing/interceptor.py:20` | Description of findings | Concrete fix recommendation |
| Adaptive & Tail Sampling Configuration | [PASS/WARN/FAIL] | `config/otel_collector.yaml:15` | Description of findings | Concrete fix recommendation |
| Asynchronous Non-Blocking Telemetry Exporters | [PASS/WARN/FAIL] | `telemetry/exporter.go:40` | Description of findings | Concrete fix recommendation |
| Sensitive Data & PII Scrubbing | [PASS/WARN/FAIL] | `tracing/sanitizer.py:12` | Description of findings | Concrete fix recommendation |
| Correlated Structured Log Injections | [PASS/WARN/FAIL] | `logging/logger.py:30` | Description of findings | Concrete fix recommendation |
| Multi-Window Error Budget Burn-Rate Alerting | [PASS/WARN/FAIL] | `alerts/prometheus_rules.yaml:45` | Description of findings | Concrete fix recommendation |
| Alert Flap Suppression & Actionable Runbook Links | [PASS/WARN/FAIL] | `alerts/alertmanager.yaml:22` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
