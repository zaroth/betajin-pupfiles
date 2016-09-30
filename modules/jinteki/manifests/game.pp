class jinteki::game {
  ensure_packages([
    'git',
  ])

  exec {'gitclone':
    command => "/usr/bin/git clone -b dev https://github.com/mtgred/netrunner.git ${jinteki::repodir} && chown -R jinteki:jinteki ${jinteki::repodir}",
    creates => "${jinteki::repodir}",
  }
}

