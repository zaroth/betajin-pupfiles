class jinteki::build {
  ensure_packages([
    'git',
  ])

  Exec['gitclone']
  -> File['/usr/local/bin/rebuild.sh']
  -> Exec['rebuild']

  exec {'gitclone':
    command => "/usr/bin/git clone -b ${jinteki_remote_git_branch} ${jinteki_remote_git_address} ${jinteki::repodir} && chown -R jinteki:jinteki ${jinteki::repodir}",
    creates => "${jinteki::repodir}",
  }

  file {'/usr/local/bin/rebuild.sh':
    content => epp('jinteki/scripts/rebuild.sh'),
    owner => 'root',
    group => 'root',
    mode => '0755',
  }

  exec {'rebuild':
    command => '/usr/local/bin/rebuild.sh -f',
    creates => "${jinteki::repodir}/target/netrunner-standalone.jar",
    user => 'jinteki',
    group => 'jinteki',
  }
}

