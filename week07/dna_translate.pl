#! /usr/bin/perl

use strict;
use warnings;

my $dna = "aaatgatcaacccgcagcgcagcaccgtgtggtattaatagaaaa";
my $result = dna_translate( $dna );
print "$result\n";

sub dna_translate {
	#Defines hash for DNA to AA translation
	our %dna2aa = (TTT=>'F', TTC=>'F', TTA=>'L', TTG=>'L', CTT=>'L', CTC=>'L', CTA=>'L', CTG=>'L', ATT=>'I', ATC=>'I', ATA=>'I', GTT=>'V', GTC=>'V', GTA=>'V', GTG=>'V', TCT=>'S', TCC=>'S', TCA=>'S', TCG=>'S', CCT=>'P', CCC=>'P', CCA=>'P', CCG=>'P', ACT=>'T', ACC=>'T', ACA=>'T', ACG=>'T', GCT=>'A', GCC=>'A', GCA=>'A', GCG=>'A', TAT=>'Y', TAC=>'Y', CAT=>'H', CAC=>'H', CAA=>'Q', CAG=>'Q', AAT=>'N', AAC=>'N', AAA=>'K', AAG=>'K', GAT=>'D', GAC=>'D', GAA=>'E', GAG=>'E', TGT=>'C', TGC=>'C', TGG=>'W', CGT=>'R', CGC=>'R', CGA=>'R', CGG=>'R', AGT=>'S', AGC=>'S', AGA=>'R', AGG=>'R', GGT=>'G', GGC=>'G', GGA=>'G', GGG=>'G');
	#Takes in DNA seq as string
	my( $dna ) = ( @_ );
	#Trims front of dna seq to the Start codon
	$dna =~ s/.*atg//;
	#Splits string into array of 3 characters
	my @AAarray = ( $dna =~ m/.../g );
	#Declares the AA seq
	my $AA = "";
	#Loops through each 3 characters and looks it up in dna2aa
	foreach my $aa (@AAarray){
		#Casts as Upper case for case handling
		$aa = uc $aa;
		#If stop codon is detected then it ends translation
		if ($aa eq "TAA" | $aa eq "TAG" | $aa eq "TGA"){
			last;
		}
		#Appends on the AA found from the dna
		$AA .= $dna2aa{$aa};
	}
	#Returns final AA seq	
	return( $AA );
}
