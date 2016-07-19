#! /usr/bin/perl
#  
use strict;
use warnings;

use lib '.';        
use DNA_GEN;
use Test::Simple tests => 1;
      
my $length = 20;
my $rand = "Y";

my $gen = DNA_SEQ_GEN( $length, $rand );
print "$gen\n";
ok( length($gen) > 10 , "Generated a Sequence Longer than 10bp" );
