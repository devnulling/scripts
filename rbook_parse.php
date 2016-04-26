<?php
$csv = array_map('str_getcsv', file('data.csv'));

foreach ($csv as $c) {
    $output = trim($c[0]);
    $input = trim($c[1]);
    $loc = trim($c[5]);
    $call = trim($c[9]);

    $freq1 = str_replace(".", "", $output) . "0";
    $name = $call . " Output";
    $namelen = strlen($name);
    $freqlen = strlen($freq1);

    if ($freqlen == 9) {
        $buff = 25;
    } elseif ($freqlen == 10) {
        $buff = 24;
    } elseif ($freqlen == 11) {
        $buff = 23;
    } else {
        $buff = 25;
    }

    $add = $buff - $namelen;

    $str = '   ';
    $str .= $freq1;
    $str .= '; ';
    $str .= $name;

    for ($x = 0; $x < $add; $x++) {
        $str .= ' ';
    }

    $str .= '; Narrow FM           ;      10000; Untagged';
    $str .= "\n";

    echo $str;

    $freq1 = str_replace(".", "", $input) . "0";
    $name = $call . " Input";
    $namelen = strlen($name);
    $freqlen = strlen($freq1);

    if ($freqlen == 9) {
        $buff = 25;
    } elseif ($freqlen == 10) {
        $buff = 24;
    } elseif ($freqlen == 11) {
        $buff = 23;
    } else {
        $buff = 25;
    }

    $add = $buff - $namelen;

    $str = '   ';
    $str .= $freq1;
    $str .= '; ';
    $str .= $name;

    for ($x = 0; $x < $add; $x++) {
        $str .= ' ';
    }

    $str .= '; Narrow FM           ;      10000; Untagged';
    $str .= "\n";

    echo $str;
}
