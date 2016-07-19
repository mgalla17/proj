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

=pod
 
=head1 DESCRIPTION
 
Adjust the length variable to set the size of the DNA sequence you want to generate. Set the rand variable to "Y" or "N" to randomly cut the DNA sequence length to a shorter sequence.
 
=cut
