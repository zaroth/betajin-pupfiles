# bash config files, prompts etc.
class console::bash {
  ensure_packages([
    'bash',
    'bash-completion',
  ])
  file {'/etc/inputrc':
    source => 'puppet:///modules/console/bash/inputrc',
    require => Package['bash'],
    mode => '0644',
  }
  file {'/etc/bash.bashrc':
    source => 'puppet:///modules/console/bash/bash.bashrc',
    require => Package['bash'],
    mode => '0644',
  }
  file {'/etc/profile':
    source => 'puppet:///modules/console/bash/profile',
    require => Package['bash'],
    mode => '0644',
  }
}
