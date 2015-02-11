package Exceptions::Basic;

use strict;
use warnings;

use Data::Dumper qw(Dumper);
use overload '""' => \&stringify;

sub throw {
    my $self = shift;
    CORE::die $self;
}

sub stringify {
    my $self = shift;
    local $Data::Dumper::Indent = 0; # don't want new lines right here
    return join ",", map { "$_ :".Dumper($self->{$_}) } keys %$self;
}

1;
