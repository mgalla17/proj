#! /usr/bin/perl
#  
use strict;
use warnings;

use lib '.';        
use DNA_GEN;
      
my $length = 20;
my $rand = "Y";

my $gen = DNA_SEQ_GEN( $length, $rand );
print "$gen\n";
