---
layout: page
title: Range Reduce
description: Query-driven compaction for LSM-trees, with up to 18% faster range queries and 90% less compaction debt. Published at ICDE 2026.
img: assets/img/range_reduce_3.png
importance: 1
category: Published
year: 2026
related_publications: kaushik2026rangereduce
---

<div class="row justify-content-sm-center">
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.html path="assets/img/range_reduce_1.png" title="cyber" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.html path="assets/img/range_reduce_2.png" title="path traversal" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

Log-structured merge (LSM) trees are the backbone of modern databases, powering high-ingestion workloads in systems like RocksDB, Cassandra, and LevelDB. However, they suffer from poor range query performance due to high read amplification, redundant merging, and excessive compactions.  

## **Problem: Excessive Reads & Merging**  
LSM-trees store data in multiple sorted runs across hierarchical levels. While this design optimizes writes, it creates inefficiencies for range queries:  

- **High Read Amplification:** Queries must scan and merge multiple sorted runs, leading to excessive disk I/O and CPU usage.  
- **Redundant Work:** Repeated queries must reprocess and merge the same data, wasting resources.  
- **Compaction Overhead:** Frequent updates and deletes generate "logically invalid" entries, which persist until removed by costly compactions.  

## **Introducing RangeReduce**  
RangeReduce is a novel optimization that **piggybacks on range queries** to improve future performance by proactively compacting data. Instead of repeatedly reading and merging duplicate entries, RangeReduce:  

1. **Sort-merges data once** during a range query.  
2. **Writes back only valid entries** at a higher level in the LSM-tree.  
3. **Reduces read and space amplification** for subsequent queries.  

<div class="row justify-content-sm-center">
    <div class="col-sm-7 mt-3 mt-md-0">
        {% include figure.html path="assets/img/range_reduce_3.png" title="path traversal" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

By eliminating duplicate entries early and delaying unnecessary compactions, RangeReduce speeds up range queries and reduces database bloat.  

## **The Trade-Off**  
Writing the merged data back to storage after a range query is not free. Instead of compacting eagerly on every query, RangeReduce runs a lightweight cost-benefit check that decides when a query-driven compaction pays off, so faster range queries never come at the cost of high write amplification. The compactions it performs are work the tree would otherwise do later, which leaves the shallower levels less saturated and means fewer compactions in the future.  

## **Real-World Impact**  
Implemented on RocksDB, RangeReduce outperforms the state of the art on range-query-intensive workloads, delivering:  

- up to **18%** lower average range-query latency  
- up to **90%** lower compaction debt  
- **12%** less overall data movement (reads and writes)  
- up to **20%** lower space amplification  

For workloads with frequent updates and deletes, it keeps the storage engine fast and compact.  

<div class="row justify-content-sm-center">
    <div class="col-sm-12 mt-3 mt-md-0">
        {% include figure.html path="assets/img/range_reduce_4.png" title="path traversal" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

## **Conclusion**  
RangeReduce represents a **new approach to LSM-tree optimization**, tackling one of its biggest challenges—slow range queries. By leveraging existing reads to optimize future queries, it brings **better space utilization, lower read amplification, and fewer compactions** to modern storage engines.

---

#### For more details, check out:
- 📄 [View the Poster](https://nedbday.github.io/2025/download/posters/RangeReduce_Range_Query_Driven_Compactions_in_LSM-Engine.pdf)  
- 🎥 [Watch the Talk](https://www.youtube.com/watch?v=xgJ2g_CLjSQ)  
- 🐙 [GitHub Repository](https://github.com/SSD-Brandeis/RangeReduce)