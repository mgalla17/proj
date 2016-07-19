#! /usr/bin/perl
#
use strict;
use warnings;

MULT_TABLE( 10 );

sub MULT_TABLE {
	my( $lim ) = ( @_ );
	$lim = $lim + 1;
	for (my $i = 1; $i < $lim; $i++){
		for (my $j = 1; $j < $lim; $j++){
			my $result = $j * $i;
			print "$result ";
		}
		print "\n";
	}
}
