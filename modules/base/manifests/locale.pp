# setting up /etc/locale.* files
class base::locale {
  file {'/etc/locale.gen':
    source => 'puppet:///modules/base/locale/locale.gen',
    mode => '0644',
    owner => 'root',
    group => 'root',
    notify => Exec['locale-gen'],
  }
  file {'/etc/locale.conf':
    source => 'puppet:///modules/base/locale/locale.conf',
    mode => '0644',
    owner => 'root',
    group => 'root',
  }
  exec {'locale-gen':
    command => 'locale-gen',
    path => '/usr/bin/',
    refreshonly => true,
  }
}
