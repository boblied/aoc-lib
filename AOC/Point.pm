# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Point.pm
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Description:
# my $p = AOC::Point->new(r=>1, c=>3);
# my $q = AOC::Point->new(r=>4, c=>5);
# say $p->add($q)->show;
#=============================================================================

use v5.40;

use Feature::Compat::Class;

class AOC::Point;

field $r :param :reader //= 0;
field $c :param :reader //= 0;

method show() { "[$r $c]" }
use overload '""' => sub { $_[0]->show() };

method add($other) { return AOC::Point->new(r=>$r + $other->r, c=>$c + $other->c) }
use overload '+' => sub { $_[0]->add($_[1]) };

method inc($other) { $r += $other->r; $c += $other->c; return $self; }
use overload '+=' => sub { $_[0]->inc($_[1]) };

method north() { return AOC::Point->new(r => $self->r-1, c => $self->c  ) }
method south() { return AOC::Point->new(r => $self->r+1, c => $self->c  ) }
method  east() { return AOC::Point->new(r => $self->r  , c => $self->c+1) }
method  west() { return AOC::Point->new(r => $self->r  , c => $self->c-1) }

