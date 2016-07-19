#! /usr/bin/perl
#
use strict;
use warnings;

DNA_SEQ_GEN( 20 , "Y" );

sub DNA_SEQ_GEN {
	my( $size, $randSize ) = ( @_ );
	$randSize //= "N";
	if ( $randSize eq "Y" ){
		$size = int( rand $size ) + 1;
	}
	for (my $i = 0; $i <= $size; $i++){
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
}
