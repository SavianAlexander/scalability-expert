---
name: scale_timeseries
description: Specialized scalability auditor for time-series databases, high-cardinality metric control, retention policies, real-time stream buffering, and analytical query caps.
---

# `scale_timeseries` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting Time-Series Databases (TSDB) and real-time analytical query engines (Prometheus, InfluxDB, TimescaleDB, ClickHouse, Apache Druid, Apache Pinot, Presto/Trino). The auditor checks high-cardinality metric label prevention, automated data retention and rollup policies, stream buffering, partition pruning, columnar file layout, and execution memory caps.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **High Cardinality Tag & Label Control**: Audit metric collection calls (`counter.inc()`, `histogram.observe()`) to ensure dynamic, high-cardinality variables (e.g., user IDs, order IDs, IP addresses, full URL paths) are never injected as metric tags or labels.
- [ ] **Automated Retention & Downsampling Rollups**: Verify TSDB and analytical store configurations enforce automated retention TTL windows (e.g., raw data stored 14 days, 5-minute rollups retained 90 days, 1-hour downsampled rollups retained 1 year).
- [ ] **Real-Time Data Ingestion Stream Buffering**: Inspect real-time ingestion architectures feeding analytical stores (ClickHouse, Druid, Pinot) to confirm incoming data passes through distributed stream buffers (Kafka / Kinesis) to absorb ingestion spikes smoothly.
- [ ] **Analytical Query Partition Pruning**: Audit analytical SQL and TSDB queries to ensure all query paths mandate explicit partition pruning filter predicates (e.g., `WHERE date_partition >= '2026-08-01'`) to prevent full table/index scans.
- [ ] **Columnar Compression & Encoding Efficiency**: Check analytical table storage formats (Parquet, ORC, ClickHouse MergeTree) to verify columnar compression algorithms (Zstandard, Snappy, LZ4) and dictionary encoding are enabled.
- [ ] **In-Memory Query Spill & Execution Memory Caps**: Verify analytical query engine node configurations enforce strict per-query memory limits and disk spill limits to prevent out-of-memory crashes during heavy analytical aggregations.
- [ ] **End-to-End Ingestion Latency (NRT Latency)**: Audit near-real-time telemetry and event processing pipelines to confirm ingestion lag remains within target SLAs (e.g., metrics available for query within < 5 seconds of event generation).

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_timeseries

## Audit Summary
- **Target Topic**: Time-Series Databases & Real-Time Analytics
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| High Cardinality Tag & Label Control | [PASS/WARN/FAIL] | `metrics/prometheus.py:30` | Description of findings | Concrete fix recommendation |
| Automated Retention & Downsampling Rollups | [PASS/WARN/FAIL] | `config/prometheus.yml:12` | Description of findings | Concrete fix recommendation |
| Real-Time Data Ingestion Stream Buffering | [PASS/WARN/FAIL] | `ingest/clickhouse_sink.py:50` | Description of findings | Concrete fix recommendation |
| Analytical Query Partition Pruning | [PASS/WARN/FAIL] | `queries/analytics_report.sql:8` | Description of findings | Concrete fix recommendation |
| Columnar Compression & Encoding Efficiency | [PASS/WARN/FAIL] | `db/tables/events.sql:22` | Description of findings | Concrete fix recommendation |
| In-Memory Query Spill & Execution Memory Caps | [PASS/WARN/FAIL] | `config/trino_config.properties:15` | Description of findings | Concrete fix recommendation |
| End-to-End Ingestion Latency (NRT Latency) | [PASS/WARN/FAIL] | `ingest/pipeline_monitor.py:40` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
