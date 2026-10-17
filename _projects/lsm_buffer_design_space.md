---
layout: page
title: Mind the Buffer
description: Dissecting the LSM-Buffer Design Space — Under Review
importance: 2
category: Ongoing
related_publications: chen2026lsmbufferdesign, kaushik2024lsmbuffer
---

LSM-trees power the storage layer of virtually every major NoSQL key-value store — RocksDB at Meta, LevelDB at Google, WiredTiger at MongoDB, Cassandra and HBase at Apache. Every single operation — read or write — passes through the in-memory buffer before touching disk. Despite being this critical, the LSM-buffer design space is vast and largely unexplored. Production systems offer users a handful of buffer choices with no systematic guidance on when each one is appropriate.

This work is an extension of our earlier [DBTest 2024 workshop paper](../lsm_memory_buffer/) that first benchmarked four buffer implementations across three operation types. The extended study dissects the entire design space — nine buffer implementations, 1,200+ experiments, and a practitioner handbook.

## The Hidden Bottleneck

The in-memory buffer is the entry point for every operation in an LSM-engine. Its choice of data structure, access method, and tuning directly determines:

- **Ingestion throughput**: how fast data can be written before a flush to storage
- **Query performance**: the cost of point and range lookups against buffered, uncompacted data
- **Flush frequency**: how often data moves to storage, which drives compaction overhead
- **Tail latency**: write stalls caused by compaction debt and buffer resizing

Even with the same buffer *size*, switching from one implementation to another can change performance by **several orders of magnitude** under the same workload. No single buffer wins across all conditions.

## Nine Buffer Implementations

We evaluate four existing implementations from commercial LSM-engines and introduce five new ones:

**Vector variants** (lowest memory overhead, best for writes):
- `V-Qsort`: appends on insert, sorts snapshot on each query (RocksDB default)
- `V-Qscan` *(new)*: appends on insert, linear backward scan on point queries
- `V-Sorted` *(new)*: maintains sorted order on insert; binary search for queries; no sorting

**Node-based**:
- `Link-L`: doubly linked sorted list; high random access cost, rarely used standalone
- `Skip-L`: classical probabilistic skip-list; logarithmic reads and writes
- `InSkip-L`: RocksDB's default; inline key storage with *splice* caching for temporal locality

**Prefix-hash hybrids** (fastest for point queries, high memory cost):
- `Hash-SL`: hash buckets backed by skip-lists
- `Hash-LL`: hash buckets backed by linked-lists (lower memory, linear search)
- `Hash-V` *(new)*: hash buckets backed by sorted vectors; lowest metadata overhead among hybrids

## The Adaptive Buffer

No static buffer choice handles workload shifts well. We design an **Adaptive buffer** that monitors operation composition over a sliding window and switches to the best-fit implementation at each flush boundary. Across a seven-phase workload spanning insert-heavy, read-heavy, update-intensive, and scan-heavy phases, the Adaptive buffer matches the best specialist in each phase — delivering 1.14 MOpS in the write phase, switching to Hash-LL for read-heavy phases, and switching back to `V-Qscan` when ingestion resumes.

<center>
<div class="col-sm-8 mt-3 mt-md-0">
  {% include figure.html path="assets/img/switching_buffer_legend.png" class="img-fluid" %}
</div>
<div class="col-sm-8 mt-1 mt-md-0">
  {% include figure.html path="assets/img/switching_buffer.png" title="Adaptive buffer throughput across seven workload phases" class="img-fluid rounded z-depth-1" %}
</div>
</center>

## Practitioner Handbook

From 1,200+ experiments, we distill 10 concrete guidelines:

1. **Write-heavy workloads** → `V-Qscan` (constant insert, no sort on PQ)
2. **Memory-constrained** → vector variants (15% overhead vs. 50%+ for hash-hybrids)
3. **Fewer flushes and compactions** → vector variants
4. **Unpredictable workloads** → `InSkip-L` (balanced across all types)
5. **PQ-heavy with sufficient memory** → hash-hybrids, prefer `Hash-V`
6. **Avoid `V-Qsort` if any point queries exist** → sorting overhead is prohibitive
7. **Static allocation** → prevents latency spikes from dynamic resizing
8. **Set `low_pri` to reduce compaction debt** → unset accumulates shallower levels
9. **Larger buffer sizes** → reduce stalls for node-based and hash-hybrid structures
10. **Shifting workloads** → use the Adaptive buffer

---

#### Resources
- 📄 [View the Paper](/assets/pdf/LSMBufferAnalysis-2.pdf)
- 🐙 [GitHub Repository](https://github.com/SSD-Brandeis/LSMMemoryProfiling)
