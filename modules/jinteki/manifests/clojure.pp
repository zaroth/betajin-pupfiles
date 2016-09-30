class jinteki::clojure {
  ensure_packages([
    'clojure',
  ])

  exec {'leinfetch':
    command => '/usr/bin/curl -s https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /usr/local/bin/lein',
    creates => '/usr/local/bin/lein',
  }

  file {'/usr/local/bin/lein':
    mode => '0755',
    require => Exec['leinfetch'],
  }
}
