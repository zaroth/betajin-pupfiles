class jinteki::letsencrypt_ws {
  ensure_packages([
    'certbot',
    'certbot-nginx',
  ])
  exec { 'letsencrypt_ws':
    command => "/usr/bin/certbot -n --agree-tos --redirect --nginx -d ws.zaroth.net --email lukasz.dobrogowski@gmail.com",
    creates => "/etc/letsencrypt/live/ws.zaroth.net
  }
}
