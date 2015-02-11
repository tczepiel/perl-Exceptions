package Exceptions;

use strict;
use warnings;

our $VERSION = '0.01';

use Scalar::Util qw(blessed);
use Module::Load qw(load);

sub raise_exception;
sub exception_class { 'Exceptions::Basic' }

BEGIN {
    *CORE::GLOBAL::die = \&raise_exception;
}

my $exception_class_loaded;

sub raise_exception {
    my ($error) = @_;

    if ( not $exception_class_loaded ) {
        my $exception_class = __PACKAGE__->exception_class();
        load $exception_class;
        $exception_class_loaded++;
    }

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
