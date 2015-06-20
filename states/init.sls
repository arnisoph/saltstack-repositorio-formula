#!jinja|yaml

{% set datamap = salt['formhelper.defaults']('repositorio', saltenv) %}

# SLS includes/ excludes
include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

repositorio:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs }}

repositorio_docroot:
  file:
    - directory
    - name: {{ datamap.docroot.path|default('/var/www/repo/') }}
    - makedirs: True
    - mode: {{ datamap.docroot.mode|default(755) }}
    - user: {{ datamap.docroot.user|default('root') }}
    - group: {{ datamap.docroot.group|default('root') }}

repositorio_extract_archive:
  archive:
    - extracted
    - name: /var/tmp/
    - source: {{ datamap.source.baseurl }}/Rex-Repositorio-{{ datamap.source.version }}.tar.gz
    - source_hash: {{ datamap.source.archive_checksum }}
    - if_missing: /var/tmp/Rex-Repositorio-{{ datamap.source.version }}
    - keep: True
    - archive_format: tar

repositorio_make_source:
  cmd:
    - run
    - name: perl Makefile.PL && make && make test && make install
    - user: root
    - unless: test -e /usr/local/bin/repositorio
    - cwd: /var/tmp/Rex-Repositorio-{{ datamap.source.version }}

{% for i in datamap.config.manage|default([]) %}
  {% set f = datamap.config[i] %}
repositorio_file_{{ i }}:
  file:
    - managed
    - name: {{ f.path }}
    - source: {{ f.template_path|default('salt://repositorio/files/' ~ i) }}
    - mode: {{ f.mode|default(640) }}
    - user: {{ f.user|default('root') }}
    - group: {{ f.group|default('root') }}
    - template: jinja
    - makedirs: True
{% endfor %}
