#! /usr/bin/perl

use strict;
use warnings;

my @a1 = ("one", "two", "three");
my @a2 = ("four", "five", "six");
my @a3 = ("seven", "eight", "nine");
my @table = (\@a1, \@a2, \@a3);


my @transpose = transpose( @table );

print "@table\n";
print ${@table->[1]};
#print "@$row";

sub transpose {
	my( @array ) = ( @_ );
	for ( my $i = 0 ; $i < (scalar @array)  ; $i++ ) {
    		for ( my $j = 0 ; $j < (scalar @array)  ; $j++ ) {
			print "$i\n";
		}
  	}		
	@transpose = @array;
	return( @transpose );
}
