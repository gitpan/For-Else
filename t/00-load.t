#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'For::Else' );
}

diag( "Testing For::Else $For::Else::VERSION, Perl $], $^X" );
