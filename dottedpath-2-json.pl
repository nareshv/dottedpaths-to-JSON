#!/usr/bin/env perl -wl
#
# Author: Naresh
# Date  : 2015/Apr
#
# Convert dotted paths to JSON
#

use JSON;
use Hash::Merge qw(merge);
use Data::Dumper;

sub dottedpath2json($$);

sub dottedpath2json($$) {
    my ($dot, $value) = @_;
    my %output = ();
    my @parts = split(/\./, $dot);
    my $part  = shift(@parts);
    if (not defined $part) {
        return $value;
    } else {
        if (not defined $output{$part}) {
            $output{$part} = dottedpath2json(join('.', @parts), $value);
            return \%output;
        }
    }
}

if ($ENV{RUN_TESTS}) {
    my $a  = dottedpath2json('a', 100);
    my $b  = dottedpath2json('b.b', 100);
    my $b1 = dottedpath2json('b.b1', 500);
    my $c  = dottedpath2json('c.b.c', 100);
    my $d  = dottedpath2json('d', [100]);
    my $e  = dottedpath2json('e.b', [100]);
    my $f  = dottedpath2json('f.b.c', [100]);

    my $abc = merge(merge(merge($a, $b), $c), $b1);

    print encode_json($a);
    print encode_json($b);
    print encode_json($b1);
    print encode_json($c);
    print encode_json($abc);
}
