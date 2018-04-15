#!/bin/bash
#/usr/local/bin/wxtoimg -N -e MSA $1 apt-msa.png
#/usr/local/bin/wxtoimg -N -e MCIR $1 apt-mcir.png
#/usr/local/bin/wxtoimg -N -e HVCT $1 apt-hvct.png
#/usr/local/bin/wxtoimg -N -e fire $1 apt-fire.png
#/usr/local/bin/wxtoimg -N -e therm $1 apt-therm.png

#echo $1
FILENAME=$(echo "$1" | sed 's/.wav//')
#echo $FILENAME

## declare an array variable
declare -a arr=("ZA", "MB", "MD", "BD", "CC", "EC", "HE", "HF", "JF", "JJ", "LC", "TA", "WV", "WV-old", "NO", "veg", "ice", "sea", "sea-day", "HVC", "HVC-precip", "HVCT", "HVCT-precip", "MCIR", "MCIR-precip", "MCIR-anaglyph", "MSA", "MSA-precip", "MSA-anaglyph", "anaglyph", "canaglyph", "therm", "fire", "class", "invert", "bw", "histeq", "contrast")

## now loop through the above array
for i in "${arr[@]}"
do
   TYPE=$(echo "$i" | sed 's/,//')
   #echo "$TYPE"
   /usr/local/bin/wxtoimg -N -q -Q 100 -A -e $TYPE $1 $FILENAME-$TYPE.jpg
   
   # or do whatever with individual element of the array
done

/usr/local/bin/wxtoimg -N -q -Q 100 -A -p $1 $FILENAME-pristine.jpg

# You can access them using echo "${arr[0]}", "${arr[1]}" also

#ZA, MB, MD, BD, CC, EC, HE, HF, JF, JJ, LC, TA, WV, WV-old, NO, veg, ice, sea, sea-day, HVC, HVC-precip, HVCT, HVCT-precip, MCIR, MCIR-precip, MCIR-anaglyph, MSA, MSA-precip, MSA-anaglyph, anaglyph, canaglyph, therm, fire, class, invert, bw, histeq, contrast
