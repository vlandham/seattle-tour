---
layout: default
---

{% for area in site.areas %}
  <a href="{{ area.url | relative_url }}">{{area.title}}</a>
{% endfor %}
