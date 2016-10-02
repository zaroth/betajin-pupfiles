class jinteki::nginx {
  ensure_packages([
    'nginx',
  ])

  File['/etc/nginx/nginx.conf'] ~> Service['nginx']

  file {'/etc/nginx/nginx.conf':
    content => epp('jinteki/nginx/nginx.conf.epp'),
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => [Package['nginx'], File["${jinteki::logdir}"]],
  }

  service {'nginx':
    require => File['/etc/nginx/nginx.conf'],
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
  }
}
