# FS = field separator
# RS = record separator

BEGIN {
  FS = "(:  )|(\r\n)"; RS = "--\n"; ORS="\n"; OFS=", ";
    print "Item name", "End time", "Sale price", "Quantity sold"}

NR > 1 {
  for(i=1; i <= NF-2; i = i + 2) {
    trim($i)
    a[$i] = trim($(i+1))
  }
  print a["Item name"], a["End time"], a["Sale price"], a["Quantity sold"]
  delete a;
} 

function lTrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rTrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)  { return rTrim(lTrim(s)); }