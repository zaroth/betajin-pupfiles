# puppet settings
class base::puppet {
  file {'/etc/puppetlabs/puppet/hiera.yaml':
    ensure => 'link',
    target => '/etc/hiera.yaml',
  }
}
