#! /usr/bin/perl
#
use strict;
use warnings;

my @Michael = ( 200 , 205 , 201 , 206 );
my @Jennie = ( 130 , 125 , 126 , 123 );
my @John = ( 180 , 182 , 185 , 185 );

my %weightLog = ( Michael => \@Michael , Jennie => \@Jennie , John => \@John );


foreach my $hash ( keys %weightLog){
	print "$hash -> ";
	foreach my $test ( $weightLog{$hash} ){
		print "@$test";
	}
	print "\n";
	#print "$hash -> $weightLog{$hash}[0]\n";
}
