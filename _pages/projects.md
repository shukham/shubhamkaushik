---
layout: page
title: Projects
permalink: /projects/
description: Building brilliance, bit by bit.
nav: true
nav_order: 1
# Each section lists project categories in display order; cards keep their own category label.
sections:
  - title: Ongoing
    categories: [Ongoing]
  - title: Accepted & Published
    categories: [Accepted, Published]
  - title: Academics
    categories: [Academics]
---

{% for section in page.sections %}
{%- assign section_projects = site.projects | where_exp: "project", "section.categories contains project.category" -%}
{%- if section_projects.size > 0 %}
<section class="section" aria-labelledby="{{ section.title | slugify }}">
  <div class="section-header">
    <h2 id="{{ section.title | slugify }}">{{ section.title }}</h2>
  </div>
  {% include project-grid.html categories=section.categories %}
</section>
{%- endif %}
{% endfor %}
