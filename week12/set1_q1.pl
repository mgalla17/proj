#! /usr/bin/perl

use strict;
use warnings;

use DBI;
use Bio::Perl;
use Bio::DB::GenBank;
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;

#Sets DB connection
################################################
#### !! SQL for Schema Located in set1_q1.sql !! ####
################################################
my $dbh = DBI->connect( "DBI:SQLite:dbname=seq", "", "",
			{ PrintError => 0 , RaiseError => 1 } );
#Sets up GenBank
my $gb = Bio::DB::GenBank->new();

#############################################################################################################
#############################################################################################################
#############################################################################################################
#Gets an Accession Number to start with from user
our $INPUTacc;
print "Type in an Accession Number (XP_641993): ";
chomp($INPUTacc = <STDIN>);

#Gets Seq obj from user's acc
my $seq = $gb->get_Seq_by_acc($INPUTacc);

#Gets seq info
my $accession  		= $seq->accession_number;
my $display_id  	= $seq->display_id;
my $desc		= $seq->desc;
my $display_name	= $seq->display_name;
my $length		= $seq->length;
my $sequence		= $seq->seq;
my $primary_id		= $seq->primary_id;
my $namespace		= $seq->namespace;
my $species		= $seq->species->common_name(); 

	my $sth = $dbh->prepare( "insert or replace INTO seq 
				(accession
        			,display_id
        			,desc
        			,display_name
        			,length
        			,seq
        			,primary_id
        			,namespace
        			,species) 
			VALUES ('$accession'
                                ,'$display_id'
                                ,'$desc'
                                ,'$display_name'
                                ,'$length'
                                ,'$sequence'
                                ,'$primary_id'
                                ,'$namespace'
                                ,'$species');" );
	$sth->execute();
	$sth->finish();

##############################################################################################################
##############################################################################################################
##############################################################################################################

#Makes SQL call to get list of stored acc's
my @seqs;
$sth = $dbh->prepare( "select accession from seq;" );
$sth->execute();
#Places that list into the seqs Variable
while ( my @row = $sth->fetchrow_array() ) {
        push(@seqs, @row);
}
$sth->finish();

our $INPUTaccRet;
print "@seqs";
chomp($INPUTaccRet = <STDIN>);

#Makes SQL call
$sth = $dbh->prepare( "select
			accession, display_id, desc, display_name, length, seq, primary_id, namespace, species
			from seq
			where seq.accession = '$INPUTaccRet';");
$sth->execute();

#Prints Out Results
while ( my @row = $sth->fetchrow_array() ) {
	print p("@row");
}
$sth->finish();


##############################################################################################################
##############################################################################################################
##############################################################################################################
our $INPUTdb;
print "Type in database (swissprot, nr, refseq_protein, landmark, pat, env_nr, tsa_nr, pdb): ";
chomp($INPUTdb = <STDIN>);


my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp'   ,
                                                 -data       => $INPUTdb   ,
                                                 -expect     => '1e-10'    ,
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
				my $hit_e_value = $hit->expect;
				my $hit_seq = $gb->get_Seq_by_acc($hit_acc);
				my $hit_accession           = $hit_seq->accession_number;
				my $hit_display_id          = $hit_seq->display_id;
				my $hit_desc                = $hit_seq->desc;
				my $hit_display_name        = $hit_seq->display_name;
				my $hit_length              = $hit_seq->length;
				my $hit_sequence            = $hit_seq->seq;
				my $hit_primary_id          = $hit_seq->primary_id;
				my $hit_namespace           = $hit_seq->namespace;
				my $hit_species             = $hit_seq->species->common_name();				
				
				my $sth = $dbh->prepare( "insert or replace INTO seq
				                                (accession
                                				,display_id
                                				,desc
                                				,display_name
                                				,length
                                				,seq
                                				,primary_id
                                				,namespace
                                				,species)
                        				VALUES ('$hit_accession'
                                				,'$hit_display_id'
                                				,'$hit_desc'
                                				,'$hit_display_name'
                                				,'$hit_length'
                                				,'$hit_sequence'
                                				,'$hit_primary_id'
                                				,'$hit_namespace'
                                				,'$hit_species');" );
        			$sth->execute();
        			$sth->finish();
				$sth = $dbh->prepare( "insert or replace INTO blast
								(search_seq_id
								,result_seq_id
								,e_value)
							VALUES ((select id from seq where seq.accession = '$accession'),(select id from seq where seq.accession = '$hit_accession'),$hit_e_value);");
				$sth->execute();
                                $sth->finish();

				print "$hit_acc";
                        }while($hit_acc ne '');
                        $factory->remove_rid( $rid );
                }elsif( $results < 0 ) {
                        $factory->remove_rid( $rid );
                }else {
                        sleep 5;
                }
        }
}
##########################################################################################################
##########################################################################################################
##########################################################################################################

#Close DB Connection
$dbh->disconnect();



