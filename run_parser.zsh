#!/bin/zsh
if [[ -z $1 ]]; then
  echo "mbox file required"
  exit
fi

rg $1 --no-filename -N -e "Item name:" -A9 | rg -N -v "http:.*\n.*\n.*" --multiline --no-filename | rg -e ":|(--)" --no-filename > result_block_records.rec

if [ -f result_block_records.rec ]; then
  awk -f record_to_csv.awk result_block_records.rec 
  exit
fi