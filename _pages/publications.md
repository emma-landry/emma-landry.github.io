---
layout: page
permalink: /publications/
title: publications
description:
years: [2024, 2025]
nav: true
nav_order: 1
---
<!-- _pages/publications.md -->
<figure style="
  position: relative;
  margin: 20px 0 40px 0;
  max-width: 885px;
  overflow: visible;
">
  <img
    src="{{ '/assets/img/IMG_9374.jpeg' | relative_url }}"
    alt="Publications Photo"
    style="
      width: 100%;
      height: auto;
      border-radius: 8px;
      display: block;
      box-shadow: 0 2px 6px rgba(0,0,0,0.08);
      z-index: 0;
    "
  >
  <figcaption style="
    position: absolute;
    bottom: 0;
    left: 0;
    background: rgba(255, 255, 255, 0.45);
    padding: 4px 8px;
    border-bottom-left-radius: 8px;
    border-top-right-radius: 8px;
    font-size: 0.9em;
    color: #333;
    font-style: italic;
    z-index: 2;
  ">
    My home, Paris
  </figcaption>
</figure>
<div class="publications">

{%- for y in page.years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f papers -q @*[year={{y}}] %}
{% endfor %}

</div>
