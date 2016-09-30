# network time synchronization
class base::ntp {
  ensure_packages([
  'ntp',
  ])
  service {'ntpd':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
    require => [Package['ntp'], File['/etc/ntp.conf']],
  }
  file {'/etc/ntp.conf':
    source => 'puppet:///modules/base/ntp/ntp.conf',
    mode => '0644',
  }
}
