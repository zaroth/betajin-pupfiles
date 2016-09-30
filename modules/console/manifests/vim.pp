# vim config files
class console::vim {
  package {'vim':}
  file {'/etc/vimrc':
    source => 'puppet:///modules/console/vim/vimrc',
    require => Package['vim'],
    mode => '0644',
  }
}
    
