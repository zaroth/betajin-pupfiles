# managing motd file
class base::motd {
  file {'/etc/motd':
    content => '',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
}
