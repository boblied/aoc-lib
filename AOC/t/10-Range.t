# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
#         FILE: 10-Range.t
#===============================================================================

use v5.42;

use Test2::V0;
use Log::Log4perl qw/:easy/;

use AOC::Range;

my $Range = AOC::Range->new();

$Range->add( 100, 180 );
is( $Range->show(), "[100-180]", "First add");

$Range->add( 20, 30 );
is( $Range->show(), "[20-30],[100-180]", "Insert before");

$Range->add( 201, 222 );
is( $Range->show(), "[20-30],[100-180],[201-222]", "Insert after");

$Range->add( 40, 50 );
is( $Range->show(), "[20-30],[40-50],[100-180],[201-222]", "Insert between");

$Range->add( 15, 25 );
is( $Range->show(), "[15-30],[40-50],[100-180],[201-222]", "Merge at left");

$Range->add( 215, 230 );
is( $Range->show(), "[15-30],[40-50],[100-180],[201-230]", "Merge at right");

$Range->add( 155, 165 );
is( $Range->show(), "[15-30],[40-50],[100-180],[201-230]", "Merge complete overlap");

$Range->add( 35, 44 );
is( $Range->show(), "[15-30],[35-50],[100-180],[201-230]", "Merge one range, left");

$Range->add( 45, 55 );
is( $Range->show(), "[15-30],[35-55],[100-180],[201-230]", "Merge one range, right");

$Range->add( 10, 60 );
is( $Range->show(), "[10-60],[100-180],[201-230]", "Merge eat two");

$Range->add(90, 99);
is( $Range->show(), "[10-60],[90-180],[201-230]", "Merge adjacent left");

$Range->add(61, 70);
is( $Range->show(), "[10-70],[90-180],[201-230]", "Merge adjacent right");

for my $valid ( 10,20,70, 90,111,180, 230 )
{
    ok( $Range->find($valid), "Find true: $valid");
}

for my $invalid ( 5, 80, 240 )
{
    ok( ! $Range->find($invalid), "Find false: $invalid" );
}

done_testing;
#use Test::More tests => 12;                      # last test to print

