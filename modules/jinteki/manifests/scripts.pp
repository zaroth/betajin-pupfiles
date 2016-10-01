class jinteki::scripts {
  ensure_packages([
    'python',
  ])

  file {'/usr/local/bin/rebuild.sh':
    source => 'puppet:///modules/jinteki/scripts/rebuild.sh',
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
}
