## Puppet files for configuration of jinteki beta server

Just run `./setup.sh dryrun` to confirm nothing is out of whack, then `./setup.sh update`. Prepared for Arch Linux only ATM.

The following are currently not automated and you need to complete these manually BEFORE running the puppet for the first time:

* Installation of `cower`, `pacaur`
* Installation of `jdk` or `jdk-arm` from AUR
