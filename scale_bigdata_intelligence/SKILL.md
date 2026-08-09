---
name: scale_bigdata_intelligence
description: Specialized scalability auditor for big data processing, distributed compute engines, Spark skew mitigation, streaming watermarks, data lake file layouts, and ML model inference scaling.
---

# `scale_bigdata_intelligence` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting big data pipelines, distributed computing runtimes (Apache Spark, Apache Flink, Ray, Hadoop/HDFS, Hive, Trino), data lake table formats (Apache Iceberg, Delta Lake, Apache Hudi), Spark data skew salting techniques, streaming window watermarks, data lake compaction, ML feature stores (Feast, Tecton), and distributed ML inference batching.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Spark Data Skew Mitigation & Key Salting**: Audit Spark / Flink join and aggregation transformations for data skew symptoms; verify skewed join keys implement key salting or broadcast joins to prevent single-task memory spills and stragglers.
- [ ] **Streaming Window Watermarks & Late Event Handling**: Inspect streaming processing pipelines (Flink, Spark Structured Streaming) to ensure explicit watermark tolerances and allowed lateness windows are declared for event-time processing.
- [ ] **Data Lake Small File Compaction & Layout**: Verify data lake table storage (Iceberg, Delta Lake, Parquet) runs automated small-file compaction jobs (e.g., target file sizes of 128MB–512MB) and partition layout tuning to prevent metastore bottlenecking.
- [ ] **Distributed ML Inference Batching & GPU Utilization**: Audit ML model serving pipelines (Triton Inference Server, Ray Serve, vLLM) to ensure dynamic request batching, GPU tensor core utilization, and concurrency limits are configured.
- [ ] **Feature Store Consistency & Online Low Latency**: Inspect ML feature pipelines (Feast, Tecton) to confirm feature definitions maintain dual materialization (low-latency key-value online store vs point-in-time correct offline data lake store).
- [ ] **Distributed Compute Memory Spill Management**: Audit Spark executor driver configuration (`spark.executor.memory`, `spark.memory.fraction`) to ensure memory execution caps prevent disk spill thrashing and executor OOM kills.
- [ ] **Data Lineage Tracking & SLA Alerting**: Verify big data DAG orchestration tools (Apache Airflow, Dagster, Prefect) enforce task retry backoff, SLA breach alerts, and data lineage capture (OpenLineage, Marquez).

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_bigdata_intelligence

## Audit Summary
- **Target Topic**: Big Data Pipelines, Distributed Computing & ML Scaling
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Spark Data Skew Mitigation & Key Salting | [PASS/WARN/FAIL] | `jobs/etl_join.py:45` | Description of findings | Concrete fix recommendation |
| Streaming Window Watermarks & Late Event Handling | [PASS/WARN/FAIL] | `streaming/flink_job.java:80` | Description of findings | Concrete fix recommendation |
| Data Lake Small File Compaction & Layout | [PASS/WARN/FAIL] | `pipelines/compaction.py:20` | Description of findings | Concrete fix recommendation |
| Distributed ML Inference Batching & GPU Utilization | [PASS/WARN/FAIL] | `serving/triton_config.pbtxt:12` | Description of findings | Concrete fix recommendation |
| Feature Store Consistency & Online Low Latency | [PASS/WARN/FAIL] | `feature_store/features.py:35` | Description of findings | Concrete fix recommendation |
| Distributed Compute Memory Spill Management | [PASS/WARN/FAIL] | `config/spark_defaults.conf:15` | Description of findings | Concrete fix recommendation |
| Data Lineage Tracking & SLA Alerting | [PASS/WARN/FAIL] | `dags/daily_pipeline.py:110` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
