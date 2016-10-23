class jinteki::users {
  ensure_packages([
    'sudo',
  ])

  group {'jinteki':
    ensure => present,
  }

  user {'jinteki':
    ensure => present,
    require => Group['jinteki'],
    home => "${jinteki::rootdir}",
    managehome => false,
    system => true,
    shell => '/usr/bin/bash',
    gid => 'jinteki',
  }

  file {["${jinteki::rootdir}", "${jinteki::logdir}"]:
    ensure => directory,
    owner => 'jinteki',
    group => 'jinteki',
    mode => '0755',
    require => [User['jinteki'], Group['jinteki']],
  }

  $developers = [
    'joel',
    'neal',
    'saintis',
    'zaroth',
    'dom'
  ]

  $developers.each |String $developer| {
    user {$developer :
      ensure => present,
      require => Group['jinteki'],
      home => "/home/${developer}",
      managehome => false,
      system => false,
      shell => '/usr/bin/bash',
      gid => 'jinteki',
    }

    $directories = ["/home/${developer}", "/home/${developer}/.ssh"]
    file {$directories :
      ensure => directory,
      owner => $developer,
      group => 'jinteki',
      mode => '0755',
      require => User[$developer],
    }

    file {"/home/${developer}/.ssh/authorized_keys":
      source => "puppet:///modules/jinteki/ssh_keys/${developer}.pub",
      owner => $developer,
      group => 'jinteki',
      mode => '0644',
      require => File["/home/${developer}/.ssh"],
    }
  }

  file {'/etc/sudoers':
    source => 'puppet:///modules/jinteki/sudoers',
    owner => 'root',
    group => 'root',
    mode => '0440',
    require => Package['sudo'],
  }
}
