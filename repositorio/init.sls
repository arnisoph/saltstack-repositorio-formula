#!jinja|yaml

{% from 'repositorio/defaults.yaml' import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('repositorio:lookup')) %}

include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

repositorio:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs }}

docroot:
  file:
    - directory
    - name: {{ datamap.docroot.path|default('/var/www/repo/') }}
    - mode: {{ datamap.docroot.mode|default(755) }}
    - user: {{ datamap.docroot.user|default('root') }}
    - group: {{ datamap.docroot.group|default('root') }}

{% if 'main' in datamap.config.manage|default([]) %}
  {% set f = datamap.config.main %}
repositorio_file_main:
  file:
    - managed
    - name: {{ f.path|default('/etc/rex/repositorio.conf') }}
    - source: {{ f.template_path|default('salt://repositorio/files/main') }}
    - mode: {{ f.mode|default(644) }}
    - user: {{ f.user|default('root') }}
    - group: {{ f.group|default('root') }}
    - template: jinja
{% endif %}

{% if 'log4perl' in datamap.config.manage|default([]) %}
  {% set f = datamap.config.log4perl %}
repositorio_file_log4perl:
  file:
    - managed
    - name: {{ f.path|default('/etc/rex/log4perl.conf') }}
    - source: {{ f.template_path|default('salt://repositorio/files/log4perl') }}
    - mode: {{ f.mode|default(644) }}
    - user: {{ f.user|default('root') }}
    - group: {{ f.group|default('root') }}
    - template: jinja
{% endif %}
