#!/usr/bin/perl -w

use strict;

use lib qw(/home/grinnz/perl5/lib/perl5/POE/Test/Loops);
use Test::More;
use POSIX qw(_exit);

sub skip_tests {
    $ENV{LIBEV_FLAGS} = 8;
    return "EV module or kqueue backend could not be loaded" if (
        do { eval "use EV"; $@ }
    );
    return "EV was not built with a kqueue backend" if EV::backend() != 8;
}


BEGIN {
  if (my $why = skip_tests('wheel_run')) {
    plan skip_all => $why
  }
}

# Run the tests themselves.
require 'wheel_run.pm';

_exit 0 if $^O eq 'MSWin32';
CORE::exit 0;