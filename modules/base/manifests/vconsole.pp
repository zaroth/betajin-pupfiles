# console font
class base::vconsole {
  ensure_packages([
  'terminus-font',
  ])
  file {'/etc/vconsole.conf':
    source => 'puppet:///modules/base/vconsole/vconsole.conf',
    mode => '0644',
    require => [Package['terminus-font'], File['/etc/locale.conf']],
  }
}
