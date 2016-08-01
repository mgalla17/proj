#! /usr/bin/perl

use warnings;
use strict;

use Bio::Perl;

our $INPUTfile;
print "Enter your fasta file name: ";
chomp($INPUTfile = <STDIN>);

my @bio_seq_objects = read_all_sequences( $INPUTfile , 'fasta' );

foreach my $seq( @bio_seq_objects ) {
	my $name      = $seq->display_id;
    	my $accession = $seq->accession_number;
    	my $sequence  = $seq->seq;
    	my $first_ten = $seq->subseq( 1 , 10 );

    	print "
		NAME: $name
 		ACC: $accession
 		TEN: $first_ten

	";
}

our $INPUTseqs;
print "Input the name(s) of the sequence(s) you want to run a BLAST against (ex: seq1,seq2,seq3): ";
chomp($INPUTseqs = <STDIN>);

our @seqNames = split(',', $INPUTseqs);
foreach my $seq (@seqNames){
	chomp($seq);
	foreach my $obj( @bio_seq_objects ) {
		if ($obj->display_id eq $seq) {
			$obj = $obj->translate();
			my $blast = blast_sequence($obj);
			my $file  = "./blast_output_$seq";
			write_blast( ">$file" , $blast );
		}
	}
}

