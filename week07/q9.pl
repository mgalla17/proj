#! /usr/bin/perl
#  
use strict;
use warnings;

use lib '.';        
use q8;
use Test::Simple tests => 7;

my $dna = "aaatgatcaacccgcagcgcagcaccgtgtggtattaatagaaaa";
my $result = dna_translate( $dna );
print "$result\n";

#Tests that $dna had a sequence of atcg's in it
ok( $dna =~ m/^(a|A|t|T|c|C|g|G)*$/ , "Input DNA sequence does contain only ATCG's");
ok( $dna =~ m/(atg|ATG)/ , "Input DNA sequence does have a start codon (ATG)");
ok( $dna =~ m/(TAA|taa|TAG|tag|TGA|tga)/ , "Input DNA sequence does have a stop codon (TAA, TAG, TGA)");
ok( length($dna) > 0 , "Input DNA sequence was filled out");
ok( $result =~ m/^(A|R|N|D|C|Q|E|G|H|I|L|K|M|F|P|S|T|W|Y|V)*$/ , "dna_translate returned an AA sequence with no issues");
ok( !($result =~ m/\n/) , "dna_translate did not return an error message");
ok( length($result) > 0 , "dna_translate did return something");
