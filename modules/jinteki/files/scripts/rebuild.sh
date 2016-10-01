#!/bin/bash

if [ ! "$(whoami)" == "jinteki" ]; then
  echo "This script needs to be run as 'jinteki' user. (use the sudo, Luke!)" >&2
  exit 1
fi

ROOT_DIR='/opt/jinteki'
REPO_DIR="${ROOT_DIR}/netrunner"
LOG_DIR="${ROOT_DIR}/logs"

LOG_FILE="${LOG_DIR}/$(date +%Y%m%d_%H%M)_build.log"
START_TIME=`date +%s`

function logmsg {
  echo "${1}"
  echo -en "\n\n${1}\n\n" >> $LOG_FILE
}

cd $REPO_DIR

logmsg "Pulling fresh changes from GitHub..."
git pull origin dev &>> $LOG_FILE

logmsg "Updating npm packages..."
npm update &>> $LOG_FILE

logmsg "Updating bower packages..."
bower update &>> $LOG_FILE

logmsg "Pulling new cards from NRDB..."
coffee "data/fetch.coffee" &>> $LOG_FILE

logmsg "Cleaning up previous build..."
lein clean &>> $LOG_FILE

logmsg "Compiling Stylus files..."
stylus src/css/ -o resources/public/css/ &>> $LOG_FILE

logmsg "Compiling Clojurescript..."
lein cljsbuild once prod &>> $LOG_FILE

logmsg "Compiling Clojure..."
lein uberjar &>> $LOG_FILE

let TIME_TAKEN=(`date +%s`-$START_TIME)
logmsg "Build finished at $(date) in ${TIME_TAKEN} seconds"
