{# https://github.com/bechtoldt/saltstack-repos-formula #}
repos:
  lookup:
    repos:
      repositorio:
        url: http://rex.linux-files.org/debian
        comps:
          - rex
        keyurl: https://rex.linux-files.org/DPKG-GPG-KEY-REXIFY-REPO

repositorio:
  lookup:
    source:
      version: 1.1.0
      archive_checksum: md5=199a309752d68c6210da8f0b8932d017
    repos:
      saltstack_wheezy_all_main:
        url: http://debian.saltstack.com/debian/
        local: saltstack-wheezy-all-main/debian
        type: Apt
        arch: amd64
        dist: wheezy-saltstack
        component: main
      opennebula_48_wheezy:
        url: http://downloads.opennebula.org/repo/4.8/Debian/7/
        local: opennebula-48-wheezy/debian
        type: Apt
        arch: amd64
        dist: stable
        component: opennebula
      ubuntu-precise-amd64-main:
        url: http://de.archive.ubuntu.com/ubuntu/
        local: ubuntu-precise-amd64-main/ubuntu
        type: Apt
        arch: amd64
        dist: precise
        component: main
        proxy: 'true'
