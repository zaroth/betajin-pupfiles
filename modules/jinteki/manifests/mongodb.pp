class jinteki::mongodb {
  ensure_packages([
    'mongodb',
  ])
  service {'mongodb':
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => Package['mongodb'],
  }
}
