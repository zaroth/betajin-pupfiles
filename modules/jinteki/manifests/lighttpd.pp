class jinteki::lighttpd {
  ensure_packages([
    'lighttpd',
  ])

  File['/etc/lighttpd/lighttpd.conf'] ~> Service['lighttpd']

  file {'/etc/lighttpd/lighttpd.conf':
    content => epp('jinteki/lighttpd/lighttpd.conf.epp'),
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => [Package['lighttpd'], File["${jinteki::logdir}"]],
  }

  service {'lighttpd':
    require => File['/etc/lighttpd/lighttpd.conf'],
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
  }
}
