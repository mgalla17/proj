#! /usr/bin/perl

use warnings;
use strict;

#Sets Oligo Sequence and parses each oligo into a list
my $oligoSeq = "ATCGGCGATCGTTGGACCTCAGGTAC";
my @oligoSeq = split('', $oligoSeq);
#Setting counting vars to 0
my $Temp = 0;
my $GC = 0;

#Loops through and adds to annealing temp as well as keep track of # of GCs
foreach my $oligo (@oligoSeq){
	if($oligo eq "A" | $oligo eq "T"){
		$Temp = $Temp + 2;	
	}elsif($oligo eq "G" | $oligo eq "C"){
		$Temp = $Temp + 4;
		$GC = $GC + 1;
	}
}

#Calulates GC percentage
$GC = ($GC / length($oligoSeq)) * 100;

#Prints out results
print "The Annealing Temperature is $Temp C\n";
print "The GC content is $GC %\n"; 
