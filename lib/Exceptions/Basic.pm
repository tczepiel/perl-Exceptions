package Exceptions::Basic;

use strict;
use warnings;

use Data::Dumper qw(Dumper);
use overload '""' => \&stringify, 'eq' => \&stringify;

sub throw {
    my $self = shift;
    CORE::die $self;
}

sub stringify {
    my $self = shift;
    local $Data::Dumper::Indent = 0; # don't want new lines right here
    my $string;
    for my $key ( keys %$self ) {
       my $value = $self->{$key} unless ref $self->{$key};
       $value ||= Dumper($self->{$key});
       $string .= "[$key : ". $value."],";
    }
    return $string;
}

1;
