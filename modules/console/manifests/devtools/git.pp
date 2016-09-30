# git config files
class console::devtools::git {
  ensure_packages(['git'])
  file {'/etc/gitconfig':
    source => 'puppet:///modules/console/git/gitconfig',
    require => Package['git'],
  }
}

