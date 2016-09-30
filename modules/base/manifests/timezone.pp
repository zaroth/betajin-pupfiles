# timezone settings
class base::timezone($tzone) {
  file {'/etc/localtime':
    ensure => 'link',
    target => "/usr/share/zoneinfo/${tzone}", 
  }
}
