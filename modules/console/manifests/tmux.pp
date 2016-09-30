# tmux configuration files
class console::tmux {
  package {'tmux':}
  file {'/etc/tmux.conf':
    source => 'puppet:///modules/console/tmux/tmux.conf',
    require => Package['tmux'],
    mode => '0644',
  }
}
    
