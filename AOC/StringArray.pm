# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Grid.pm
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Description: Convenience functions for handling a matrix represented
# as an array of strings, e.g.
# [ "0.#.#.",
#   ".l..33" ]
#=============================================================================

package AOC::StringArray;

use v5.38;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(showAofS transposeAofS getColAofS diaglrAofS diagrlAofS);
our @EXPORT_OK = qw();

sub showAofS($aOfs)
{
    my $height = $aOfs->$#*;
    my $width  = length($aOfs->[0]) - 1;
    my $colFormat = " %2s" x ($width+1);
    my $s = "\n";

    $s .= sprintf("      $colFormat\n", 0 .. $width);
    $s .=         "    + " . (" --" x ($width+1)) . "+\n";
    for my $row ( 0 .. $height )
    {
        $s .= sprintf(" %2s |$colFormat | %-2s\n", $row,
            split("", $aOfs->[$row]), $row);
    }
    $s .=          "    + " . (" --" x ($width+1)) . "+\n";
    $s .= sprintf( "      $colFormat\n", 0 .. $width);
}

# Transpose a grid that's represented as an array of strings
sub transposeAofS($m)
{
    my @t;
    my $width = length($m->[0]);

    for (my $c = 0 ; $c < $width ; $c++ )
    {
        push @t, join "", map { substr($_, $c, 1) } $m->@*;
    }
    return \@t;
}

sub getColAofS($m, $col)
{
    return (map { substr($m->[$_], $col, 1) } 0 .. $m->$#*);
}

# Extract all the diagonals that slope down from left to right
#    \ \ \ \
#     \ \ \
#    \ \ \ \
sub diaglrAofS($m)
{
    my @diag;
    my $width = length($m->[0]);
    for my $row ( 0 .. $m->$#* )
    {
        my $d = "";
        for (my $c = 0, my $r = $row; $r >= 0 && $c < $width; $c++, $r-- )
        {
            $d .= substr($m->[$r], $c, 1);
        }
        push @diag, $d;
    }
    for my $col ( 1 .. length($m->[0])-1 )
    {
        my $d = "";
        for ( my $c = $col, my $r = $m->$#*; $r >= 0 && $c < $width; $c++, $r-- )
        {
            $d .= substr($m->[$r], $c, 1);
        }
        push @diag, $d;
    }
    return \@diag;
}

# Extract all the diagonals that slope down from right to left
#    / / / /
#     / / /
#    / / / /
sub diagrlAofS($m)
{
    my @diag;
    my $width = length($m->[0]) - 1;
    my $height = $m->$#*;
    for my $col ( reverse 0 .. $width )
    {
        my $d = "";
        for (my $c = $col, my $r = 0; $r <= $height && $c <= $width ; $c++, $r++ )
        {
            $d .= substr($m->[$r], $c, 1);
        }
        push @diag, $d;
    }
    for my $row ( 1 .. $height )
    {
        my $d = "";
        for ( my $c = 0, my $r = $row; $r <= $height &&  $c <= $width ; $c++, $r++ )
        {
            $d .= substr($m->[$r], $c, 1);
        }
        push @diag, $d;
    }
    return \@diag;
}

1;
