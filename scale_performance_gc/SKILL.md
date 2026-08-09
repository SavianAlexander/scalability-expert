---
name: scale_performance_gc
description: Specialized scalability auditor for runtime performance optimization, Garbage Collection (GC) tuning, serialization efficiency, async I/O loops, and continuous profiling.
---

# `scale_performance_gc` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor inspecting runtime performance optimization, Garbage Collection (GC) behavior, runtime memory layout (Go memory ballast, JVM low-latency GC, Python Copy-On-Write GC), binary serialization protocols (Protobuf/gRPC vs JSON), async non-blocking I/O event loops, custom memory allocators (`jemalloc`), container CPU quota unthrottling, and continuous flame graph profiling.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Runtime GC Flag & Allocation Tuning**: Audit JVM, Go, Node.js, and Python runtime execution configurations for low-latency GC settings (e.g., JVM `-XX:+UseZGC` or `-XX:+UseShenandoahGC`, Go `GOGC` tuning / memory ballast, Python `gc.freeze()` for fork/pre-fork web servers).
- [ ] **High-Efficiency Binary Serialization**: Inspect high-throughput inter-service and RPC communications to confirm binary serialization protocols (Protobuf, gRPC, FlatBuffers, Apache Avro) are preferred over heavy text JSON or XML formatting.
- [ ] **Payload Compression Thresholds**: Audit HTTP endpoints and event stream producers to ensure payload compression algorithms (Brotli, Zstandard, Gzip) are selectively applied to network payloads exceeding 1KB.
- [ ] **Async Non-Blocking I/O Event Loops**: Verify high-concurrency network microservices utilize non-blocking I/O event loop runtimes (Netty, Tokio, Node.js, Python `asyncio`, Go netpoll) rather than thread-per-request models.
- [ ] **Custom Memory Allocator Integration**: Audit native C/C++/Rust/Python C-extension worker services for high-performance memory allocators (`jemalloc`, `tcmalloc`) to mitigate heap fragmentation and improve multithreaded allocation speed.
- [ ] **Container CPU CFS Quota Unthrottling**: Inspect Kubernetes deployment manifests and kernel settings (`cpu.cfs_quota_us`) to confirm CPU CFS quotas are tuned or disabled where necessary to prevent artificial multi-threaded CPU throttling latency spikes.
- [ ] **Continuous Flame Graph Profiling Setup**: Verify continuous low-overhead production CPU and memory profiling instrumentation (e.g., Pyroscope, Parca, eBPF, Go `pprof`, Uber JVM Profiler) is configured to capture production bottlenecks.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_performance_gc

## Audit Summary
- **Target Topic**: Performance Optimization, Resource Efficiency & Runtime Tuning
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Runtime GC Flag & Allocation Tuning | [PASS/WARN/FAIL] | `scripts/entrypoint.sh:10` | Description of findings | Concrete fix recommendation |
| High-Efficiency Binary Serialization | [PASS/WARN/FAIL] | `proto/service.proto:1` | Description of findings | Concrete fix recommendation |
| Payload Compression Thresholds | [PASS/WARN/FAIL] | `middleware/compress.py:20` | Description of findings | Concrete fix recommendation |
| Async Non-Blocking I/O Event Loops | [PASS/WARN/FAIL] | `server/main.go:35` | Description of findings | Concrete fix recommendation |
| Custom Memory Allocator Integration | [PASS/WARN/FAIL] | `Dockerfile:15` | Description of findings | Concrete fix recommendation |
| Container CPU CFS Quota Unthrottling | [PASS/WARN/FAIL] | `deploy/kubernetes/deployment.yaml:30` | Description of findings | Concrete fix recommendation |
| Continuous Flame Graph Profiling Setup | [PASS/WARN/FAIL] | `profiling/tracer.go:12` | Description of findings | Concrete fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
