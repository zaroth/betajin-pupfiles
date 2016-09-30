# root user settings
class base::root {
    include base::systemd
    user {'root':
        home => '/root',
        managehome => true,
        gid => 'root',
        groups => ['root', 'wheel', 'sys', 'adm'],
        membership => minimum,
        comment => 'System root account',
        system => false,
        shell => '/bin/bash',
        require => [Group['adm']],
    }
    file {'/root':
        ensure => directory,
        mode => '0600',
        owner => 'root',
        group => 'root'
    }
}
