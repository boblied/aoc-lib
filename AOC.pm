#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# AOC -- Advent of Code boilerplate and conveniences
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================

package AOC;
use v5.38;

use Exporter;
our @ISA = qw/Exporter/;
our @EXPORT = qw/$logger showGrid $DoTest/;

our $logger;

our $DoTest  = 0;
my $DoDebug = 0;

my %stdOptions = ( "test" => \$DoTest,
                   "debug:s" => \$DoDebug );

sub setup($otherArgs = {})
{
    use Log::Log4perl qw(:easy);
    use Getopt::Long;

    $logger = Log::Log4perl->get_logger();
    Log::Log4perl->easy_init({
            level => $WARN,
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n"
        });

    my %DBLEVEL = ( 1 => $INFO, 2 => $DEBUG, 3 => $TRACE,
        i => $INFO, d => $DEBUG, t => $TRACE, );

    GetOptions(%stdOptions, %$otherArgs);
    $logger->level($DBLEVEL{$DoDebug}) if $DoDebug;
}

sub showGrid($grid)
{
    #my $grid = $_[0];
    my $height = $grid->$#*;
    my $width  = $grid->[0]->$#*;
    my $colFormat = " %3s" x ($width+1);
    my $s = "\n";

    $s .= sprintf("       $colFormat\n", 0 .. $width);
    $s .=         "     + " . (" ---" x ($width+1)) . "+\n";
    for my $row ( 0 .. $height )
    {
        $s .= sprintf(" %3s |$colFormat | %-3s\n", $row, $grid->[$row]->@*, $row);
    }
    $s .=          "     + " . (" ---" x ($width+1)) . "+\n";
    $s .= sprintf( "       $colFormat\n", 0 .. $width);
}

sub doTest()
{
    exit(!runTest()) if $DoTest;
}

1;
