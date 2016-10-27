class jinteki::letsencrypt_renew {
  ensure_packages([
    'cronie'
  ])

  cron { 'letsencrypt_jinteki_renew':
    ensure => 'present',
    command => "/usr/bin/certbot renew --quiet --agree-tos",
    user => 'jinteki',
    hour => 10,
    minute => 42,
  }

}
