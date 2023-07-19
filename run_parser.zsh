#!/bin/zsh
if [[ -z $1 ]]; then
  echo "mbox file required"
  exit
fi

if [[ -z $2 ]]; then
  echo "destination not specified, defaulting to ./private"
  mkdir -p private
  DST="./private"
else
  DST=$2
  echo "found"
fi


rg $1 --no-filename -N -e "Item name:" -A9 | rg -N -v "http:.*\n.*\n.*" --multiline --no-filename | rg -e ":|(--)" --no-filename > $DST/block_records_result.rec

if [ -f result_block_records.rec ]; then
  awk -f ./record_to_csv.awk result_block_records.rec > $DST/result.csv
  exit
fi