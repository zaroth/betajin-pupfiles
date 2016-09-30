# pacman config files, keyrings etc.
class base::pacman {
  ensure_packages([
    'base-devel',
    'pacman',
    'pkgfile',
  ])

  file {'/etc/pacman.conf':
    content => epp('base/pacman/pacman.conf.epp'),
    require => Package['pacman'],
    mode => '0644',
    owner => 'root',
    group => 'root',
  }

  file {'/etc/pacman.d':
    ensure => directory,
    require => Package['pacman'],
    mode => '0644',
    owner => 'root',
    group => 'root',
  }

  # stuff dependant on architecture
  if $::hardwaremodel =~ '^arm.*' {
    package {'archlinuxarm-keyring':
      ensure => installed,
      notify => Exec['pacman-key-populate']
    }

    exec {'pacman-key-populate':
      command => 'pacman-key --populate archlinuxarm',
      path => '/usr/bin/',
      require => Package['archlinuxarm-keyring'],
      refreshonly => true,
    }

    file {'/etc/pacman.d/mirrorlist':
      source => 'puppet:///modules/base/pacman/mirrorlist-arm',
      require => Package['pacman'],
      mode => '0644',
      owner => 'root',
      group => 'root',
    }
  } else {
    ensure_packages([
      'reflector'
    ])

    package {'archlinux-keyring':
      ensure => installed,
      notify => Exec['pacman-key-populate']
    }

    exec {'pacman-key-populate':
      command => 'pacman-key --populate archlinux',
      path => '/usr/bin/',
      require => Package['archlinux-keyring'],
      refreshonly => true,
    }

    file {'/etc/systemd/system/reflector.service':
      source => 'puppet:///modules/base/pacman/reflector.service',
      require => Package['reflector'],
      mode => '0644',
      owner => 'root',
      group => 'root',
    }
  }

  exec {'pacman-key-init':
    command => 'pacman-key --init',
    path => '/usr/bin/',
    creates => '/etc/pacman.d/gnupg/gpg.conf',
    notify => Exec['pacman-key-populate'],
  }
}
