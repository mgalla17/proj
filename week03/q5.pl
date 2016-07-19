#! /usr/bin/perl
#
use strict;
use warnings;

for (my $i = 1; $i <= 10; $i++){
	my $gen = DNA_SEQ_GEN( 50 , "N" );
	open( my $OUT , '>', "seq$i" );
	print $OUT "$gen";
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
