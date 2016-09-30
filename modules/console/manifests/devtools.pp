# developer tools in console environment
class console::devtools {
  ensure_packages([
    'ack',
    'nasm',
    'the_silver_searcher',
  ])
  include console::devtools::git
}
