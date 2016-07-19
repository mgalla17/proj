#! /usr/bin/perl
#
use strict;
use warnings;

use CGI (':standard');

my $type = param('type');

my $gen = DNA_SEQ_GEN( 50 , $type );
print "$gen";

sub DNA_SEQ_GEN {
	my( $size , $type ) = ( @_ );
	
	my @bases = qw/ A C G T /;
	my @AAs = qw/ A R N D C E Q G H I L K M F P S T W Y V U O /;
 
	my $gen = ""; 
  	foreach ( 1 .. $size ) {
    		if ( $type eq "DNA" ){
			$gen .= $bases[int(rand(4))];
		}
		elsif ( $type eq "AA" ){
			$gen .= $AAs[int(rand(22))];
		}
  	}
  	return ($gen);
}
