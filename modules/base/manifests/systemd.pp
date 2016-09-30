# systemd configuration
class base::systemd {
    package {'systemd':}
    group {'adm':
        require => Package['systemd']
    }

    file {'/etc/systemd/system.conf':
        source => 'puppet:///modules/base/systemd/system.conf',
        owner => 'root',
        group => 'root',
        mode => '0644',
    }

    file {'/etc/systemd/journald.conf':
        source => 'puppet:///modules/base/systemd/journald.conf',
        owner => 'root',
        group => 'root',
        mode => '0644',
    }
}
