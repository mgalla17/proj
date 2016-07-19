#! /usr/bin/perl
#
use strict;
use warnings;

for (my $i = 1; $i < 13; $i++){
	for (my $j = 1; $j < 13; $j++){
		my $result = $j * $i;
		print "$result ";
	}
	print "\n";
}
