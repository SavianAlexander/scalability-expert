---
name: scale_searching
description: Specialized scalability auditor for search engine clusters, shard routing, inverted index design, bulk indexing APIs, field mapping, and cluster master node stability.
---

# `scale_searching` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting search engine cluster performance (Elasticsearch, OpenSearch, Apache Solr, Meilisearch). The auditor checks index shard routing, shard sizing thresholds (10GB–50GB per shard), leading wildcard query anti-patterns, bulk indexing batch processing, field mapping memory optimization, refresh interval tuning, and dedicated master node quorum configurations.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Shard Sizing & Custom Routing Key Design**: Audit search index settings to confirm target shard sizes remain between 10GB and 50GB and high-volume queries utilize custom routing keys (`routing=user_id`) to avoid broadcasting queries across all cluster shards.
- [ ] **Leading Wildcard & Expensive Query Prevention**: Inspect search client queries for leading wildcards (e.g., `*keyword` wildcards, heavy regex queries) and enforce n-gram / edge-ngram tokenizers or match-phrase queries instead.
- [ ] **Bulk Indexing API Batching**: Audit document indexing handlers to ensure updates use bulk batch APIs (`_bulk`) with controlled batch sizes (e.g., 5MB–15MB or 1,000–5,000 documents per request) rather than executing single-document index requests.
- [ ] **Field Mapping & Memory Optimization**: Verify index mappings explicitly configure `doc_values: true` for sorting/aggregations and disable `index: true` or `norms` on unsearched or store-only string fields to minimize heap usage.
- [ ] **Refresh Interval & Indexing Throughput Tuning**: Inspect index settings on bulk ingestion pipelines to ensure `refresh_interval` is increased during heavy indexing runs (e.g., increased from `1s` to `30s` or `-1`) to reduce segment merging overhead.
- [ ] **Search Federation & Timeout Deadlines**: Audit search fan-out / federation code to ensure sub-queries execute concurrently with strict parent request timeouts and fallback results on partial node failures.
- [ ] **Dedicated Master Nodes & Split-Brain Prevention**: Inspect search cluster topology parameters to verify production clusters deploy dedicated master-eligible nodes with appropriate split-brain prevention configurations (`cluster.initial_master_nodes` or voting quorums).

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_searching

## Audit Summary
- **Target Topic**: Distributed Searching, Indexing & Retrieval
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Shard Sizing & Custom Routing Key Design | [PASS/WARN/FAIL] | `elasticsearch/indices.json:10` | Description of findings | Concrete fix recommendation |
| Leading Wildcard & Expensive Query Prevention | [PASS/WARN/FAIL] | `search/query_builder.py:45` | Description of findings | Concrete fix recommendation |
| Bulk Indexing API Batching | [PASS/WARN/FAIL] | `search/indexer.py:80` | Description of findings | Concrete fix recommendation |
| Field Mapping & Memory Optimization | [PASS/WARN/FAIL] | `mappings/products.json:20` | Description of findings | Concrete fix recommendation |
| Refresh Interval & Indexing Throughput Tuning | [PASS/WARN/FAIL] | `search/index_settings.py:15` | Description of findings | Concrete fix recommendation |
| Search Federation & Timeout Deadlines | [PASS/WARN/FAIL] | `services/search_federator.go:60` | Description of findings | Concrete fix recommendation |
| Dedicated Master Nodes & Split-Brain Prevention | [PASS/WARN/FAIL] | `k8s/opensearch_cluster.yaml:25` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
