class jinteki::iptables {
  ensure_packages([
    'iptables',
  ])

  file {'/etc/iptables/iptables.rules':
    source => 'puppet:///modules/jinteki/iptables.rules',
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['iptables'],
  }

  File['/etc/iptables/iptables.rules'] ~> Service['iptables']

  service {'iptables':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
    require => File['/etc/iptables/iptables.rules'],
  }
}

