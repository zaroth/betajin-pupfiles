class jinteki::mongodb {
  ensure_packages([
    'mongodb',
    'mongodb-tools',
  ])
  service {'mongodb':
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => Package['mongodb'],
  }
}
