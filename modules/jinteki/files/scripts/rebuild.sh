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

cd $REPO_DIR

echo -en "Pulling fresh changes from GitHub...\n\n" | tee -a $LOG_FILE
git pull origin dev &>> $LOG_FILE

echo -en "\n\nUpdating npm packages...\n\n" | tee -a $LOG_FILE
npm update &>> $LOG_FILE

echo -en "\n\nUpdating bower packages...\n\n" | tee -a $LOG_FILE
bower update &>> $LOG_FILE

echo -en "\n\nPulling new cards from NRDB...\n\n" | tee -a $LOG_FILE
coffee "data/fetch.coffee" &>> $LOG_FILE

echo -en "\n\nCleaning up previous build...\n\n" | tee -a $LOG_FILE
lein clean &>> $LOG_FILE

echo -en "\n\nCompiling Stylus files...\n\n" | tee -a $LOG_FILE
stylus src/css/ -o resources/public/css/ &>> $LOG_FILE

echo -en "\n\nCompiling Clojurescript...\n\n" | tee -a $LOG_FILE
lein cljsbuild once prod &>> $LOG_FILE

echo -en "\n\nCompiling Clojure...\n\n" | tee -a $LOG_FILE
lein uberjar &>> $LOG_FILE

let TIME_TAKEN=(`date +%s`-$START_TIME)
echo -en "\n\nBuild finished at $(date) in ${TIME_TAKEN} seconds" | tee -a $LOG_FILE
