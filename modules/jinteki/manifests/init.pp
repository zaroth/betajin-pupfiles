# Android: Netrunner jinteki server and dependencies
class jinteki {
  $rootdir = '/opt/jinteki'
  $repodir = "${jinteki::rootdir}/netrunner"
  $logdir = "${jinteki::rootdir}/logs"

  include jinteki::clojure
  include jinteki::game
  include jinteki::iptables
  include jinteki::nginx
  include jinteki::mongodb
  include jinteki::nodejs
  include jinteki::scripts
  include jinteki::users
  include jinteki::letsencrypt_jinteki
  include jinteki::letsencrypt_ws
  include jinteki::letsencrypt_renew

  Class[jinteki::users]
  -> Class[jinteki::iptables]
  -> Class[jinteki::nginx]
  -> Class[jinteki::nodejs]
  -> Class[jinteki::mongodb]
  -> Class[jinteki::clojure]
  -> Class[jinteki::game]
  -> Class[jinteki::scripts]
  -> Class[jinteki::letsencrypt_jinteki]
  -> Class[jinteki::letsencrypt_ws]
  -> Class[jinteki::letsencrypt_renew]
}
