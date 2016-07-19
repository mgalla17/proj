#! /usr/bin/perl

use warnings;
use strict;
 
#Match an Integer Number

if ("1" =~ m/^[0-9]*$/){ 
       	print "Match!\n";
}else{
	print "No match!\n";
}

#Match an Integer or Decimal
if ("5.5" =~ m/^[0-9]*\.?[0-9]*$/){
        print "Match!\n";
}else{
        print "No match!\n";
}

#Match a + or - Integer or Decimal
if ("-55" =~ m/^-?[0-9]*\.?[0-9]*$/){
        print "Match!\n";
}else{
        print "No match!\n";
}

#Match a + or - Scientific Notation Number
if ("-5.5e6" =~ m/^-?[0-9]?\.?[0-9]*e-?[0-9]*$/){
        print "Match!\n";
}else{
        print "No match!\n";
}
#
#
