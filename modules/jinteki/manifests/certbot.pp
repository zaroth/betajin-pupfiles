class jinteki::certbot {
  ensure_packages([
    'certbot',
    'certbot-nginx',
  ])

  $jinteki_domains.each |String $domain| {
    exec {"certbot-obtain-$domain":
      command => "/usr/bin/certbot run -n --agree-tos --nginx --redirect --email ${admin_email} -d ${domain}",
      require => [Package['certbot'], Package['certbot-nginx'], Service['jinteki-site'], Service['nginx']],

      #creates => "/etc/letsencrypt/live/${domain}/fullchain.pem",
    }
  }

}
