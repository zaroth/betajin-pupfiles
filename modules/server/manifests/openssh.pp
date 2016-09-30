# sshd configuration
class server::openssh {
  ensure_packages(['openssh'])
  file {'/etc/ssh/sshd_config':
    source => 'puppet:///modules/server/sshd_config',
    owner => 'root',
    group => 'root',
    mode => '0600',
    notify => Service['sshd'],
    require => Package['openssh']
  }
  service {'sshd':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
  }
}
