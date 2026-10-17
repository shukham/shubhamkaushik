---
layout: page
title: Talks
permalink: /talks/
description: Research talks, seminars, and conference presentations.
nav: true
nav_order: 3
---

<ol class="talk-list">
  {%- assign talks = site.talks | sort: "date" | reverse -%}
  {%- for talk in talks %}
  <li class="talk">
    <h2 class="talk-title">{{ talk.title | escape_once }}</h2>
    {%- if talk.duration and talk.duration != "" %}
    <p class="talk-duration">{{ talk.duration }} min</p>
    {%- endif %}
    <ul class="talk-venues">
      {%- for venue in talk.venues %}
      <li class="talk-venue">
        <span class="talk-venue-info">
          <span class="talk-venue-name">{{ venue.name | escape_once }}</span>
          {%- if venue.institution and venue.institution != "" %}
          <span>{{ venue.institution | escape_once }}</span>
          {%- endif %}
        </span>
        <span class="talk-venue-meta">
          {%- if venue.video and venue.video != "" %}
          <a class="chip" href="{{ venue.video }}">{% include icon.html name="play" %} Video</a>
          {%- endif %}
          {%- if venue.slides and venue.slides != "" %}
          <a class="chip" href="{{ venue.slides | relative_url }}">{% include icon.html name="slides" %} Slides</a>
          {%- endif %}
          {%- if venue.poster and venue.poster != "" %}
          <a class="chip" href="{{ venue.poster | relative_url }}">{% include icon.html name="image" %} Poster</a>
          {%- endif %}
          {%- if venue.date %}
          <time datetime="{{ venue.date | date_to_xmlschema }}">{{ venue.date | date: "%b %Y" }}</time>
          {%- endif %}
        </span>
      </li>
      {%- endfor %}
    </ul>
  </li>
  {%- endfor %}
</ol>
