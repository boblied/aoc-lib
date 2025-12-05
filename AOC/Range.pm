# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Range.pm
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# Description:
#=============================================================================

use v5.42;
use Feature::Compat::Class;


class AOC::Range;

use List::Util qw/min max/;
use List::MoreUtils qw/bsearch binsert/;

use constant { LOWER => 0, UPPER => 1 };

# List of [min,max] ranges, kept sorted by min
field @range;

method add($lower, $upper)
{
    if ( @range == 0 )  # Empty list, initialize
    {
        push @range, [$lower, $upper];
        return
    }
    if ( $upper < $range[0][LOWER] )    # Insert at the left
    {
        unshift @range, [$lower, $upper];
        return;
    }
    if ( $lower > $range[-1][UPPER] )   # Insert at the right
    {
        push @range, [$lower, $upper];
        return;
    }

    # Merge ranges that overlap or are adjacent to [lower,upper]
    my @temp;
    while ( defined( my $r = shift @range ) )
    {
        if ( canMerge(@$r, $lower, $upper) )
        {
            $lower = min($r->[LOWER], $lower);  # Extend to the left
            $upper = max($r->[UPPER], $upper);  # Extend to the right
        }
        else { push @temp, $r } # Copy non-overlapping ranges, preserves order
    }

    # Insert the new range into its correct spot. The list is sorted,
    # so we can use binary search/insert.
    binsert { $_->[LOWER] <=> $lower } [$lower, $upper], @temp;

    @range = @temp;
}

method total()
{
    use List::Util qw/sum/;
    return List::Util::sum map { $_->[UPPER] - $_->[LOWER] + 1 } @range
}

sub canMerge($beg1, $end1, $beg2, $end2)
{
    ($end2 >= $beg1 && $beg2 <= $end1)  # Overlap
    || $end1 == $beg2-1                 # Adjacent on the left
    || $end2 == $beg1-1                 # Adjacent on the right
}

method show()
{
    join ",", map { "[".$_->[LOWER]."-".$_->[UPPER]."]" } @range;
}

method find($val)
{
    use List::MoreUtils qw/bsearch/;
    scalar bsearch { ($val < $_->[LOWER]) ? 1 : (($val > $_->[UPPER]) ? -1 : 0) } @range;
}

true;
