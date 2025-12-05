# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#===============================================================================
#         FILE: 00-load.t
#===============================================================================

use v5.42;

use Test::More tests => 1;                      # last test to print

BEGIN {
    use_ok('AOC::Range') || say STDERR "Can't make class AOC::Range";
}

diag( "Testing Range, Perl $], $^X" )
