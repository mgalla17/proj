#! /usr/bin/perl
#
use strict;
use warnings;

use Storable;

for (my $i = 1; $i <= 10; $i++){
	my $gen = DNA_SEQ_GEN( 50 , "N" );
	#print "$gen";
	store \$gen , "seq_$i"; 
}

sub DNA_SEQ_GEN {
	my( $size, $randSize ) = ( @_ );
	if ( $randSize eq "Y" ){
		$size = int( rand $size ) + 1;
	}
	our $gen = "";
	for (my $i = 0; $i <= $size; $i++){
		my $num = rand;
		if ($num < 0.25){
			$gen .= "A";
		}
		elsif (($num > 0.25) && ($num < 0.5) ){
			$gen .= "T";
		}
		elsif (($num > 0.5) && ($num < 0.75) ){
                        $gen .= "C";
                }
		elsif ($num > 0.75){
                        $gen .= "G";
                }
	}
	return ( "$gen" );
}
