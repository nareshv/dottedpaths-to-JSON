<?php

/*
 * Author: Naresh
 * Date  : 2015/Apr
 *
 * Convert dotted paths to JSON
 */

function dots2json($dot, $value) {
    $output = [];
    $parts = explode('.', $dot);
    $part  = array_shift($parts);
    if (!$part) {
        return $value;
    } else {
        if (!isset($output[$part])) {
            $output[$part] = dots2json(join('.', $parts), $value);
            return $output;
        }
    }
}

if (PHP_SAPI == 'cli') {
    $a = dots2json('a', 100);
    $b = dots2json('b.b', 100);
    $c = dots2json('c.b.c', 100);
    $d = dots2json('d', [100]);
    $e = dots2json('e.b', [100]);
    $f = dots2json('f.b.c', [100]);

    $abc = array_merge($a, $b, $c);
    echo json_encode($a).PHP_EOL;
    echo json_encode($b).PHP_EOL;
    echo json_encode($c).PHP_EOL;
    echo json_encode($abc).PHP_EOL;
}
