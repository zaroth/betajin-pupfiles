# general purpose console apps
class console {
  ensure_packages([
  'cmake',
  'htop',
  'unzip',
  'wget',
  ])
  unless $::hardwaremodel =~ '^arm.*' {
    package {'lshw':
      ensure => present
    }
  }
  include console::bash
  include console::tmux
  include console::vim
}
