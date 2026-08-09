---
name: scale_frontend_client
description: Specialized scalability auditor for frontend architecture, client-side scalability, edge delivery, and client-server synchronization efficiency.
---

# `scale_frontend_client` — Scalability Audit Skill

## Overview & Auditor Role
This minor skill operates as a specialized scalability auditor examining frontend codebases and client-side architecture. It focuses on how the client interacts with the backend at scale. The auditor inspects static asset CDN delivery, bundle optimization, SSR/hydration bottlenecks, API request batching, WebSocket connection management, and client-side state caching.

## Evaluation Checklist
Execute the following 7-point audit checklist against the target codebase:

- [ ] **Static Asset CDN Delivery & Fingerprinting**: Verify that all static assets (JS, CSS, images) are served via CDN, utilize content-hash fingerprinting for infinite caching, and employ Brotli/Gzip compression.
- [ ] **JS Bundle Splitting & Tree-Shaking**: Audit the frontend build pipeline (Webpack, Vite, Rollup) for excessive main bundle sizes. Ensure aggressive code-splitting (lazy loading routes) and tree-shaking of unused dependencies are implemented.
- [ ] **API Request Deduplication & Batching**: Inspect data fetching hooks (e.g., React Query, SWR, Apollo) to ensure simultaneous duplicate requests are coalesced, and rapid iterative requests are batched to reduce backend QPS.
- [ ] **SSR Hydration Bottlenecks**: For Server-Side Rendered (SSR) apps (Next.js, Nuxt), audit for expensive data-fetching blocking the initial render, massive serialized state payloads in HTML, and slow hydration metrics (Total Blocking Time).
- [ ] **WebSocket & Polling Efficiency**: Audit real-time features. Ensure WebSockets implement exponential backoff on reconnects (to prevent thundering herds on server restart) and polling mechanisms use adaptive intervals or pause when the tab is hidden.
- [ ] **Client-Side State Caching & Optimistic UI**: Verify the client effectively caches immutable or slow-moving data in memory or IndexedDB, and utilizes Optimistic UI updates to hide network latency from the user.
- [ ] **Third-Party Script Sandboxing**: Audit the inclusion of third-party tags (analytics, ads, chat widgets) to ensure they use `async`/`defer` attributes and do not block the main thread or impact Core Web Vitals at scale.

## Audit Output Protocol & Report Structure
When completing the audit, format the findings as a structured audit report and return it to the orchestrator:

```markdown
# Scalability Audit Report: scale_frontend_client

## Audit Summary
- **Target Topic**: Frontend Architecture & Client Scalability
- **Overall Status**: [PASS | WARN | FAIL]
- **Critical Issues Found**: [Count]

## Detailed Findings
| Check Item | Status | Location / Codebase Reference | Evidence / Details | Recommended Remediation |
|------------|--------|------------------------------|---------------------|--------------------------|
| Static Asset CDN Delivery & Fingerprinting | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| JS Bundle Splitting & Tree-Shaking | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| API Request Deduplication & Batching | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| SSR Hydration Bottlenecks | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| WebSocket & Polling Efficiency | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Client-Side State Caching & Optimistic UI | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |
| Third-Party Script Sandboxing | [PASS/WARN/FAIL] | `path/to/file` | Details | Fix recommendation |

## Risk Assessment & Priority Actions
1. High Priority: [Immediate architectural or operational fix]
2. Medium Priority: [Optimization fix]
```
