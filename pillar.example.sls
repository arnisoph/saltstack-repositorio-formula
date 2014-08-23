repositorio:
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
