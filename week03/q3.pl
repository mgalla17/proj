#! /usr/bin/perl
#
use strict;
use warnings;

for (my $i = 0; $i <= 20; $i++){
	my $num = rand;
	if ($num < 0.25){
		print "A";
	}
	elsif (($num > 0.25) && ($num < 0.5) ){
		print "T";
	}
	elsif (($num > 0.5) && ($num < 0.75) ){
                print "C";
        }
	elsif ($num > 0.75){
                print "G";
        }
}
