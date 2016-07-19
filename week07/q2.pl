#! /usr/bin/perl

use strict;
use warnings;

#(a) declares scalar variable as reference to the sub routine 
my $functionRef = \hashRef();

#(b) calls the sub routine via the reference and places the result (a reference to a hash) into the hash variable
my $hash = $$functionRef;

#(c) Calls the hash reference and prints the contents
foreach( keys %$hash ) {

  print "$_ --> ${$hash}{$_}\n"

}

#The sub routine that creates a hash and then returns the reference to it
sub hashRef {
	my %hash = ( 1=>'one', 2=>'two' );
	return( \%hash );
}
