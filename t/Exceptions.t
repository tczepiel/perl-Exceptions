use strict;
use warnings;

use Scalar::Util qw(blessed);
use Test::More tests => 4;
use Exceptions;

local $@;
eval { die "wtf!" };
my $error = $@;

ok(blessed $error, "the error is a blessed object");
warn "error is $error";
ok($error->isa("Exceptions::Basic"), "the error object is a basic exception class");

is($error->{error}, "wtf!", "the error string is correct");

my $stringified = $error->stringify();
warn "stringified: $stringified";

like($error, qr/wtf/, "stringification works as expected");


