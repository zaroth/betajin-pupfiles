#!/usr/bin/env bash

# for now we assume that this script is run from the main puppet directory
pupDir=`pwd`
modPath=$pupDir/modules
extModPath=$pupDir/modules_ext
factsPath=$pupDir/facts
puppetFlags=""

if [ "$EUID" -ne 0 ]; then
  echo 'Run me as root.' >&2
  exit 1
fi

if [ ! -d $modPath -o ! -f $pupDir/setup.sh ]; then
  echo 'Run me from puppet repo main directory.' >&2
  exit 1
fi

function cmd_clean {
  rm -rf $extModPath
  echo "Cleaned up downloaded modules."
}

function cmd_help {
  echo -e "$0 - tool for setting up boxes with the right configuration via Puppet\n"
  echo -e "  Syntax: $0 [COMMAND]\n"
  echo -e "  Commands:"
  echo -e "    clean  - remove all temporary files created by this script"
  echo -e "    help   - display this message"
  echo -e "    update - update config using Puppet"
  echo -e "    dryrun - check what will happen when you update config using Puppet"
}

function module_install {
  puppet module list --modulepath "${extModPath}" | grep "${1}" &> /dev/null
  MODULE_INSTALLED=$?
  if [ $MODULE_INSTALLED -ne 0 ]; then
    puppet module install $1 --modulepath "${extModPath}"
  fi
}


function cmd_update {
  # disable system speaker beeps
  setterm --blength 0 &> /dev/null

  # installing puppet if not present in system
  pacman -Q puppet &> /dev/null
  PUPPET_STATUS=$?
  pacman -Q puppet3 &> /dev/null
  PUPPET3_STATUS=$?
  if [ $PUPPET_STATUS -ne 0 -a $PUPPET3_STATUS -ne 0 ]; then
    pacman -Sy --noconfirm puppet || exit 1
  fi

  # manifest chosen based on hostname unless specified otherwise
  chosenManifest=$(hostname | tr '[:upper:]' '[:lower:]')
  if [ -f this.manifest ]; then
    read chosenManifest < this.manifest
  fi

  if [ ! -d $extModPath ]; then
    mkdir $extModPath
  fi

  # dependencies
  module_install "puppetlabs-stdlib"

  # we need to add local modules for puppet to find
  modulePath="$modPath:$extModPath:`puppet apply --configprint modulepath`"
  FACTERLIB="$factsPath"
  export FACTERLIB

  exec puppet apply $puppetFlags --verbose --modulepath "$modulePath" "manifests/${chosenManifest}.pp" 
}

if [ $# -lt 1 ]; then
  echo -e "You need to specify a command.\n" >&2
  cmd_help
  exit 1
fi

if [ $# -gt 1 ]; then
  echo -e "Too many arguments.\n" >&2
  cmd_help
  exit 1
fi

case $1 in 
  '-h'|'--help'|'help')
    cmd_help
    exit 0
    ;;
  'clean')
    cmd_clean
    exit 0
    ;;
  'update')
    cmd_update
    exit 0
    ;;
  'dryrun')
    puppetFlags="$puppetFlags --test --noop"
    cmd_update
    exit 0
    ;;
  *)
    echo -e "Invalid command: $1\n" >&2
    cmd_help
    exit 1
    ;;
esac

