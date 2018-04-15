#!/bin/bash
FILENAME=$(echo "$1" | sed 's/.wav//')
declare -a arr=("ZA", "MB", "MD", "BD", "CC", "EC", "HE", "HF", "JF", "JJ", "LC", "TA", "WV", "WV-old", "NO", "veg", "ice", "sea", "sea-day", "HVC", "HVC-precip", "HVCT", "HVCT-precip", "MCIR", "MCIR-precip", "MCIR-anaglyph", "MSA", "MSA-precip", "MSA-anaglyph", "anaglyph", "canaglyph", "therm", "fire", "class", "invert", "bw", "histeq", "contrast")

for i in "${arr[@]}"
do
   TYPE=$(echo "$i" | sed 's/,//')
   /usr/local/bin/wxtoimg -N -q -Q 100 -A -e $TYPE $1 $FILENAME-$TYPE.jpg
done

/usr/local/bin/wxtoimg -N -q -Q 100 -A -p $1 $FILENAME-pristine.jpg
