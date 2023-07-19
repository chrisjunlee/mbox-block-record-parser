#!/bin/zsh
if [[ -z $1 ]]; then
  echo "mbox file required"
  exit
fi

DST=""
RECORDFILE="block_records_result.rec"
CSVFILE="results.csv"

if [[ -z $2 ]]; then
  echo "destination not specified, defaulting to ./private"
  mkdir -p private
  DST="./private"
else
  DST=$2
  echo "found"
fi

rg $1 --no-filename -N -e "Item name:" -A9 \
  | rg -N -v "http:.*\n.*\n.*" --multiline --no-filename | rg -e ":|(--)" --no-filename \
  | tr -d ',' > $DST/$RECORDFILE

if [ -f $DST/$RECORDFILE ]; then
  awk -f ./record_to_csv.awk $DST/$RECORDFILE > $DST/$CSVFILE
  cat $DST/$CSVFILE
  exit
fi