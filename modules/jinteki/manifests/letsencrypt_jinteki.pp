class jinteki::letsencrypt_jinteki {
  ensure_packages([
    'certbot',
    'certbot-nginx',
  ])

  exec { 'letsencrypt_jinteki':
    command => "/usr/bin/certbot -n --agree-tos --redirect --nginx -d jinteki.zaroth.net --email lukasz.dobrogowski@gmail.com",
    creates => "/etc/letsencrypt/live/jinteki.zaroth.net"
  }
}
