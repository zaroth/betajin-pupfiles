class jinteki::game {
  ensure_packages([
    'git',
  ])

  exec {'gitclone':
    command => "/usr/bin/git clone -b dev https://github.com/mtgred/netrunner.git ${jinteki::repodir} && chown -R jinteki:jinteki ${jinteki::repodir}",
    creates => "${jinteki::repodir}",
  }

  file {'/etc/systemd/system/jinteki-game.service':
    content => epp('jinteki/systemd/jinteki-game.service.epp'),
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  service {'jinteki-game':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
    require => File['/etc/systemd/system/jinteki-game.service'],
  }
  
  file {'/etc/systemd/system/jinteki-site.service':
    content => epp('jinteki/systemd/jinteki-site.service.epp'),
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  service {'jinteki-site':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
    require => File['/etc/systemd/system/jinteki-site.service'],
  }
}

