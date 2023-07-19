# FS = field separator
# RS = record separator
BEGIN {FS = "(:  )|(\r\n)"; RS = "--\n"; ORS="\n"; }

NR > 1 {
  for(i=1; i < NF-2; i = i + 2) {
    trim($i)
    a[$i] = trim($(i+1))
  }
  print a["Item name"], a["End time"], a["Sale price"], a["Quantity"]
  delete a;
} 

function lTrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rTrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)  { return rTrim(lTrim(s)); }