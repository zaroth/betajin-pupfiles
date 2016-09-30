# network debugging tools
class base::networking {
  ensure_packages([
  'bind-tools',
  'iputils',
  'net-tools',
  'netctl',
  'nmap',
  'openbsd-netcat',
  'openssh',
  'rsync',
  'tcpdump',
  'traceroute',
  'whois',
  ])
}
