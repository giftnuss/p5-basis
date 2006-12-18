#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'basis' );
}

diag( "Testing basis $basis::VERSION, Perl $], $^X" );
