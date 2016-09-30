# basic resources no linux install should do without
class base ($tzone = 'UTC') {
  include base::locale
  include base::motd
  include base::networking
  include base::ntp
  include base::pacman
  include base::puppet
  include base::python
  include base::root
  class {'base::timezone':
    tzone => $tzone,
  }
  include base::vconsole
}
