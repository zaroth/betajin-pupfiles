$admin_email = 'lukasz.dobrogowski@gmail.com'
$jinteki_domains = [
  'jinteki.zaroth.net',
  'ws.zaroth.net',
]
$jinteki_remote_git_address = 'https://github.com/mtgred/netrunner.git'
$jinteki_remote_git_branch = 'dev'

$developers = [
    'dom',
    'joel',
    'neal',
    'saintis',
    'zaroth',
]

class {'base':}

class {'console':}
class {'console::devtools':}

class {'server::openssh':}

class {'jinteki':}
