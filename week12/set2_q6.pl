#! /usr/bin/perl

use strict;
use warnings;

use Bio::Perl;
use Bio::DB::GenBank;
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;
use Storable;

#Sets up GenBank
my $gb = Bio::DB::GenBank->new();

#############################################################################################################
#############################################################################################################
#############################################################################################################
#Gets an Accession Number to start with from user
our $INPUTacc;
print "Type in an Accession Number (XP_641993): ";
chomp($INPUTacc = <STDIN>);
#Gets database from user
our $INPUTdb;
print "Type in a database to BLAST against (swissprot): ";
chomp($INPUTdb = <STDIN>);
#Gets an evalue from user
our $INPUTevalue;
print "Type in an e-value cutoff (1.0e-12): ";
chomp($INPUTevalue = <STDIN>);

#Gets Seq obj from user's acc
my $seq = $gb->get_Seq_by_acc($INPUTacc);

##############################################################################################################
##############################################################################################################
##############################################################################################################

#Sets up blast factory
my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp'   ,
                                                 -data       => $INPUTdb   ,
                                                 -expect     => $INPUTevalue    ,
                                                 -readmethod => 'SearchIO' );
$factory->submit_blast($seq);
our $hit_acc;
while(my @rids = $factory->each_rid){
        foreach my $rid (@rids){
                my $results = $factory->retrieve_blast($rid);
                if( ref( $results )) {
                        my $result = $results->next_result;
                        do{
                                my $hit   = $result->next_hit;
				$hit_acc = $hit->accession;
				my $hit_seq = $gb->get_Seq_by_acc($hit_acc);
				my $hit_evalue = $hit->expect;
				my $hit_sequence = $hit_seq->seq;
				store \$hit_sequence , "$hit_acc.seq";
				print "HIT: $hit_acc ($hit_evalue) written to file '$hit_acc.seq'\n";
                        }while($hit_acc ne '');
                        $factory->remove_rid( $rid );
                }elsif( $results < 0 ) {
                        $factory->remove_rid( $rid );
			print "No hits found within cut-off e-value";
                }else {
                        sleep 5;
                }
        }
}
##########################################################################################################
##########################################################################################################
##########################################################################################################
