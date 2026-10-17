---
layout: page
title: Flink Scheduler
description: Heterogeneity-aware operator placement that offloads Apache Flink operators to edge devices to cut WAN traffic.
img: assets/img/flink-scheduler.png
importance: 2
category: Academics
year: 2023
related_publications: 
---

<div class="row justify-content-sm-center">
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.html path="assets/img/flink-scheduler.png" title="flink scheduler" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.html path="assets/img/flink-results.png" title="flink results" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

Stream processing systems handle real-time data but often struggle with latency and resource limitations, especially over **Wide Area Networks (WANs)**. This project proposes a **heterogeneity-aware operator placement algorithm** that offloads processing tasks to **edge systems (Raspberry Pi devices)** to reduce WAN data traffic and improve efficiency.  

## **Motivation**  
Traditional stream processing systems like **Apache Flink** are designed for **homogeneous data center servers**, making them inefficient for WAN-based applications. Limited bandwidth and high latency can slow down data ingestion from multiple sources, leading to performance bottlenecks.  

## **Overview**  
The project introduces a **dynamic offloading mechanism** that analyzes performance metrics to determine which tasks can be processed at the edge. The system will:  
1. **Extract Key Metrics** – Gather data such as `backPressureTimeMsPerSecond`, `idleTimeMsPerSecond`, and `numRecordsOutPerSecond` from Flink.  
2. **Develop a Cost Model** – Predict and optimize data stream flow.  
3. **Modify the Flink Scheduler** – Implement a new placement strategy to offload lightweight operators to Raspberry Pi devices.  

## **Challenges & Solutions**  
- **Heterogeneous Resources** – Adjusting Flink’s scheduling model to accommodate edge devices.  
- **Latency Reduction** – Optimizing placement decisions using real-time performance metrics.  
- **Resource Utilization** – Ensuring edge systems efficiently process tasks without overloading.  

## **Experimental Setup**  
The prototype will be built using **Apache Flink, Raspberry Pi 4B, Python, and Java**, with tests conducted on open-source datasets. Tasks will initially run on the server, followed by selective offloading to edge systems based on performance analysis.  

## **Expected Impact**  
- **Reduced WAN Latency** – Offloading tasks at the edge minimizes network delays.  
- **Optimized Resource Usage** – Efficiently balances processing between cloud and edge.  
- **Improved System Efficiency** – Enhances real-time data processing without sacrificing performance.  

## **Conclusion**  
By integrating **edge-aware task offloading** into Apache Flink, this project aims to **improve stream processing performance**, reduce latency, and enhance resource utilization, making real-time data processing more efficient over WANs.  

---

#### For more details, check out:
- 🐙 [GitHub Repository](https://github.com/shukham/MorphStream)
