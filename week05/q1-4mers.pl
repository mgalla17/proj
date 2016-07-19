#! /usr/bin/perl
#
use strict;
use warnings;

use Storable;
use Data::Dumper;

for (my $i = 1; $i <= 10; $i++){
	my $gen = retrieve("seq_$i");
	
	$gen = Dumper $gen;
	if ($gen =~ m/AAAA/){
		print "A run found in ./seq$i\n";
	}
	if ($gen =~ m/TTTT/){
                print "T run found in ./seq$i\n";
        }
	if ($gen =~ m/CCCC/){
                print "C run found in ./seq$i\n";
        }
	if ($gen =~ m/GGGG/){
                print "G run found in ./seq$i\n";
        }
}
