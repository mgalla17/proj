#! /usr/bin/perl

use strict;
use warnings;

#Sets list of numbers in array
my @nums = (-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
#Runs functions for min and max
my $maxNum = max_num( @nums );
my $minNum = min_num( @nums );
#Prints results
print "Max: $maxNum\n";
print "Min: $minNum\n";

#Max function
sub max_num {
	my( @array ) = ( @_ );
	#Starts with first number in array
	my $maxNum = $array[0];
	#Loops through and replaces with number is larger
	foreach my $num (@array){
		if($num > $maxNum){
			$maxNum = $num
		}
	}
	#Returns largest number
	return( $maxNum );
}

#Min Function
#Works like max function
sub min_num {
        my( @array ) = ( @_ );
        my $minNum = $array[0];
        foreach my $num (@array){
                if($num < $minNum){
                        $minNum = $num
                }
        }
        return( $minNum );
}

