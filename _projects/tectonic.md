---
layout: page
title: Tectonic
description: A Rust workload generator for shifting, composite-key, and partially sorted workloads, with 2× the throughput of YCSB and up to 84% less memory. TPCTC 2025.
img: assets/img/tectonic.png
importance: 1
category: Published
year: 2025
related_publications: ott2025tectonic
---

Key-value stores power the backbone of modern data infrastructure — from user-facing applications to internal analytics pipelines. Yet evaluating their performance accurately remains a hard, largely unsolved problem. Existing benchmarks like **YCSB**, **KVBench**, and **db_bench** fall short in critical ways.

## The Problem with Existing Benchmarks

State-of-the-art key-value benchmarks cannot:

1. **Emulate dynamic workloads** — real applications shift their access patterns over time (e.g., morning read-heavy, evening write-heavy). Static benchmarks miss this entirely.
2. **Generate composite keys** — production keys often have structured prefixes (user IDs, tenant IDs, timestamps). Uniform random key generation fails to capture prefix distributions.
3. **Control data sortedness** — ingested data in real systems often arrives partially sorted. Benchmarks that always generate random keys miss this dimension.

These gaps lead to **inaccurate performance evaluations** and mask how storage engines actually behave under production conditions.

## Introducing Tectonic

**Tectonic** is a Rust-based, highly configurable, and resource-efficient key-value workload generator designed to close this gap. It models the temporal, structural, and dynamic properties of real-world workloads.

### Key Features

- **Fine-grained operation control:** Configure insert rates, update patterns, merge semantics, point/range queries, and point/range deletes independently — and vary them over time.
- **Composite key generation:** Pluggable strategies for prefix distributions, enabling simulation of multi-tenant and structured-key workloads.
- **Dynamic workload shifts:** Define workload phases that change composition and distribution at arbitrary intervals, simulating realistic production traffic evolution.
- **Sortedness control:** Generate data with user-specified sortedness levels — from fully random to nearly sorted — to evaluate storage engine behavior across the ingestion spectrum.

### Performance

Tectonic achieves:
- **2× higher throughput** than YCSB and KVBench
- **Up to 84% lower memory footprint** during workload generation

This efficiency makes it viable for long-running benchmark suites without the generator itself becoming a bottleneck.

## Impact

Tectonic enables researchers and engineers to evaluate key-value stores under conditions that genuinely reflect production demands — exposing performance characteristics that synthetic benchmarks miss entirely.

---

#### Resources
- 📄 [View the Paper](/assets/pdf/Tectonic.pdf)
- 🐙 [GitHub Repository](https://github.com/SSD-Brandeis/tectonic)
