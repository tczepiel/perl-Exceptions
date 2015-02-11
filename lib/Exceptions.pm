package Exceptions;

use strict;
use warnings;

our $VERSION = '0.01';

use Scalar::Util qw(blessed);

sub raise_exception;
sub exception_class { 'Exceptions::Basic' }

BEGIN {
    *CORE::GLOBAL::die = \&raise_exception;
}

sub raise_exception {
    my ($error) = @_;

    CORE::die $error if blessed $error;

    my $exception;
    if ( ref ($error||'') eq 'HASH' ) {
        $exception = bless $error => __PACKAGE__->exception_class();
    }
    elsif ( ref $error ) {
        $exception = bless {
            is_exception_class_error => "unknown data structure: " . ref($error),
            data                     => $error,
        } => __PACKAGE__->exception_class();
    }
    else {
        $exception = bless {
            error => $error,
        } => __PACKAGE__->exception_class();
    }

    CORE::die $exception;
}

1;
