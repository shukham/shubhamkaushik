---
layout: page
title: Finding Vulnerabilities
description: An automated tool that found path traversal and Zip Slip vulnerabilities in 9 of 250 VS Code extensions.
img: assets/img/cyber.png
importance: 2
category: Academics
year: 2023
---

<div class="row justify-content-sm-center">
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.html path="assets/img/cyber.png" title="cyber" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.html path="assets/img/path-traversal.png" title="path traversal" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

VS Code is a widely used text editor with numerous extensions that enhance its functionality. However, these extensions can introduce security risks if not properly vetted. This project analyzed VS Code extensions for two classes of file-system vulnerabilities, **Path Traversal** and **Zip Slip**, and built an automated tool to find them.  

## **Motivation**  
With millions of developers relying on VS Code, extensions become an attractive target for attackers. Extensions run with the same privileges as the user, so a single extension that does not validate user input can expose the whole machine: a **path traversal** flaw lets an attacker read files outside the intended directory (credentials, configuration files, or system files), and a **Zip Slip** flaw lets a crafted archive overwrite or create files in arbitrary locations.  

## **Overview**  
We focused on two kinds of extensions: those that open a port on the local machine (for example, live servers that preview HTML, JSON, or Markdown files), which are candidates for **path traversal**, and those that unpack zip archives inside VS Code, which are candidates for **Zip Slip**.  

We built an **automated tool** using **Python, asyncio, and pyautogui**, which:  
1. **Searches & Downloads Extensions** – Queries the VS Code Marketplace by keyword, downloads matching extensions as VSIX files, and installs them with VS Code’s CLI.  
2. **Analyzes Exposed Commands** – Extracts each extension’s `package.json` to find the commands it exposes.  
3. **Executes & Tests** – Runs those commands one by one in a VS Code instance and attempts the exploit.  
4. **Flags Vulnerable Extensions** – Records vulnerable extensions and their details in a JSON report.  

The tool tests over 100 extensions within a few minutes.  

## **Challenges & Solutions**  
- **Identifying Risky Extensions** – Choosing search keywords that were both precise and comprehensive took several iterations.  
- **Rate Limits** – The VS Code Marketplace rate-limits requests, so the tool uses **asynchronous I/O** to download and test extensions in parallel.  

## **Results**  
We tested **250 extensions**:  
- **Path Traversal found in 8 of 200 extensions** that open a local port, including one with over 476,000 downloads  
- **Zip Slip found in 1 of 50 extensions** that unpack archives, with over 256,000 downloads  

For comparison, we also scanned the same extensions with the static-analysis tools **Semgrep** and **Snyk**; Semgrep caught more of the path traversal cases.  

## **Conclusion**  
Our tool found real vulnerabilities in popular VS Code extensions, which highlights the **need for better security vetting in the VS Code ecosystem**. The report also covers how extension developers can mitigate both vulnerability classes.  

---

#### For more details, check out:
- 📄 [Read Report](https://shubhamkaushik.com/assets/pdf/vulnerabilities_in_vs_code.pdf)
- 🐙 [GitHub Repository](https://github.com/prateekdceit06/VSCode-Extensions-Simulator)
