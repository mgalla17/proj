#! /usr/bin/perl

use warnings;
use strict;

use Bio::Perl;
use Bio::DB::GenBank;
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;

#Sets up GenBank
my $gb = Bio::DB::GenBank->new();

#Gets an Accession Number to start with from user
our $INPUTacc;
print "Type in an Accession Number: ";
chomp($INPUTacc = <STDIN>);

#Gets Seq obj from user's acc
my $seq = $gb->get_Seq_by_acc($INPUTacc);

#Sets up factory to do blast searches
my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp'   ,
                                                 -data       => 'nr'       ,
                                                 -expect     => '1e-10'    ,
                                                 -readmethod => 'SearchIO' );
#Blast searches user's seq
$factory->submit_blast($seq);

#Loops through initial blast search
our $hit_acc;
while(my @rids = $factory->each_rid){
	foreach my $rid (@rids){
    		#Checks status of submitted blast
		my $results = $factory->retrieve_blast($rid);
    		if( ref( $results )) {
			#Gets list of results
			my $result = $results->next_result;
			#Loops through hits until it get the non-self hit
			do{
				my $hit   = $result->next_hit;
				$hit_acc = $hit->accession;

			}while($hit_acc eq $seq->accession_number);
			$factory->remove_rid( $rid );
		}elsif( $results < 0 ) {
			#No results
			$factory->remove_rid( $rid );
		}else {
			#Results not ready yet, check again later
			sleep 5;
		}
	}
}
print "First Blast Search Done. Now Doing Second...\n";

#Gets Seq obj from top hit
my $hit_seq = $gb->get_Seq_by_acc($hit_acc);

#Blast searches top hit
$factory->submit_blast($hit_seq);

#Loops through final blast search
our $final_acc;
while(my @rids = $factory->each_rid){
	foreach my $rid (@rids){
		#Checks status of submitted blast
		my $results = $factory->retrieve_blast($rid);
		if( ref( $results )) {
			#Gets list of results
			my $result = $results->next_result;
			#Loops through hits until it get the non-self hit
			do{
				my $hit   = $result->next_hit;
				$final_acc = $hit->accession;
			}while($final_acc eq $hit_seq->accession_number);
			$factory->remove_rid( $rid );
		}elsif( $results < 0 ) {
			#No results
			$factory->remove_rid( $rid );
		}else {
			#Results not ready yet, check again later
			sleep 5;
		}
	}
}
print "Second Blast Search Done.\n";

#check if final seq is same as input seq
if($INPUTacc eq $final_acc){
	print "Your initial Accession Number Matches the Final Accession Number\n";
}

#Gets seq from final hit
my $final_seq = $gb->get_Seq_by_acc($final_acc);

#Prints out final seq info
my $name = $final_seq->display_id;
my $acc = $final_seq->accession_number;
my $gi = $final_seq->primary_id();
my $desc = $final_seq->desc();
my $species = $final_seq->species();
my $ten = $final_seq->subseq( 1 , 10 );

print "
	NAME: $name
	ACC: $acc
	GI: $gi
	DESC: $desc
	SPECIES: $species
	TEN: $ten

";
