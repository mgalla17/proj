#! /usr/bin/perl

use warnings;
use strict;

#Declares variables for input 
our $INPUTscale;
our $INPUTinitTemp;

#Asks user for input and then stores it in variables
print "What is Your Starting Scale (F or C)?  ";
chomp($INPUTscale = <STDIN>);       
print "Temperature? ";
chomp($INPUTinitTemp = <STDIN>);

#Declares output variable
our $OUTPUTconvTemp = 0;
#If user input C as their init it does this conversion and prints
if($INPUTscale eq "C"){
	$OUTPUTconvTemp =  1.8 * $INPUTinitTemp + 32;
	print "$INPUTinitTemp C converted to F is: $OUTPUTconvTemp\n";
#If user input F then it does this
}elsif($INPUTscale eq "F"){
	$OUTPUTconvTemp = .5556 * ($INPUTinitTemp - 32);
	print "$INPUTinitTemp F converted to C is: $OUTPUTconvTemp\n";
}

