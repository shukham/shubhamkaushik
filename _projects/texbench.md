---
layout: page
title: TexBench
description: Benchmark RocksDB, Cassandra, ScyllaDB, and Redis side by side on one workload, described in plain English. VLDB 2026 demo.
img: assets/img/texbench_architecture.png
importance: 1
category: Published
year: 2026
related_publications: chanda2026texbench, kaushik2026texbenchllm, ott2025tectonic
---

Picking the right key-value store for a workload &mdash; and tuning it correctly &mdash; usually means running the same benchmark against a dozen candidate databases by hand. Existing benchmarks like **YCSB**, **db_bench**, and **KVBench** make this harder than it should be: each has its own setup process, its own configuration language, and none of them let you compare multiple databases against the *same* workload side by side.

**TexBench** is a unified key-value benchmarking suite that abstracts away workload configuration, benchmark setup, and database connections behind one interface. Point it at a workload and a set of databases, and it runs the benchmark against all of them and lets you compare the results directly.

<div class="row justify-content-sm-center">
    <div class="col-sm-8 mt-3 mt-md-0">
        {% include figure.html path="assets/img/texbench_architecture.png" title="TexBench architecture" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">TexBench takes a workload &mdash; described in natural language or assembled from presets &mdash; and compiles it into a Tectonic specification that runs against multiple key-value stores side by side.</div>

Under the hood, TexBench builds on [**Tectonic**](/projects/tectonic/), a Rust-based, highly configurable key-value workload generator that can emulate multi-phased, dynamically shifting workloads &mdash; the kind of realistic access patterns that static benchmarks like YCSB can't capture. TexBench benchmarks databases against these shifting workloads and compares their performance phase by phase.

Writing a workload specification by hand still takes expertise, so TexBench integrates an **LLM plugin**: describe the workload in plain English, and TexBench translates it into a Tectonic specification and benchmarks it against every selected database in parallel &mdash; generating workloads up to **16.7× faster** than prompting an LLM directly. TexBench currently supports **RocksDB**, **Cassandra**, **ScyllaDB**, and **Redis**.

---

#### Resources
- 🐙 [GitHub Repository](https://github.com/SSD-Brandeis/TexBench)
