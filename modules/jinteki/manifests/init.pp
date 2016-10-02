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

  Class[jinteki::users]
  -> Class[jinteki::iptables]
  -> Class[jinteki::nginx]
  -> Class[jinteki::nodejs]
  -> Class[jinteki::mongodb]
  -> Class[jinteki::clojure]
  -> Class[jinteki::game]
  -> Class[jinteki::scripts]
}
