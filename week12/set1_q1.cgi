#! /usr/bin/perl

use strict;
use warnings;

use DBI;
use CGI (':standard');
use Bio::Perl;
use Bio::DB::GenBank;
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;

#Sets DB connection
#####################################################
#### !! SQL for Schema Located in set1_q1.sql !! ####
#####################################################
my $dbh = DBI->connect( "DBI:SQLite:dbname=seq", "", "",
			{ PrintError => 0 , RaiseError => 1 } );
#Sets up GenBank
my $gb = Bio::DB::GenBank->new();

#Makes SQL call to get initial list of stored seqs
my @SEQS;
my $sth = $dbh->prepare( "select accession from seq;" );
$sth->execute();
#Places that list into the SEQS Variable
while ( my @row = $sth->fetchrow_array() ) {
        push(@SEQS, @row);
}
$sth->finish();
  
#CGI Title
my $title = 'Gene Searching!';
print header,
start_html( $title ),
	h1( $title );
#Search seq Form Submission
if( param( 'search_submit' )) {
	#Sets accession into variable
	my $ACCESSION = param( 'search_accession' );
	
	#Gets Seq obj from user's acc
	my $seq = $gb->get_Seq_by_acc($ACCESSION);
	
	#Gets GenBank seq info
	my $accession           = $seq->accession_number;
	my $display_id          = $seq->display_id;
	my $desc                = $seq->desc;
	my $display_name        = $seq->display_name;
	my $length              = $seq->length;
	my $sequence            = $seq->seq;
	my $primary_id          = $seq->primary_id;
	my $namespace           = $seq->namespace;
	my $species             = $seq->species->common_name();

	#Prints info to user
	print "
		ACC:	$accession
		DISP_ID:$display_id
		DESC:	$desc
		DISP:	$display_name
		LENGTH:	$length
		SEQ:	$sequence
		PRIM_ID:$primary_id
		NS:	$namespace
		SPEC:	$species
	";

	#Makes SQL call to store seq info
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
	
	#Updates stored seq list
	$sth = $dbh->prepare( "select accession from seq;" );
	$sth->execute();
	while ( my @row = $sth->fetchrow_array() ) {
		push(@SEQS, @row);
	}
	$sth->finish();                                                                                
}

#Retrieve seq info Form Submission
if( param( 'retrieve_submit' )) {
	#Sets accession into variable
	my $ACCESSION = param( 'stored_accession' ); 
	
	#Makes SQL call
	$sth = $dbh->prepare( "select
        	                accession, display_id, desc, display_name, length, seq, primary_id, namespace, species
                	        from seq
                        	where seq.accession = '$ACCESSION';");
	$sth->execute();
	#Prints Out Results
	while ( my @row = $sth->fetchrow_array() ) {
		print p("@row");
	}
	$sth->finish();
}

#Search blast Form Submission
if( param( 'blast_submit' )) {
	#Sets values into variables
	my $ACCESSION = param( 'stored_accession' );
	my $DATABASE = param( 'blast_db' );
	
	#Creates BLAST factory for selected database
	my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp'   ,
                                                 	-data       => $DATABASE   ,
                                                 	-expect     => '1e-10'    ,
                                                 	-readmethod => 'SearchIO' );
	#Gets Seq obj from acc
	my $seq = $gb->get_Seq_by_acc($ACCESSION);

	#Submits BLAST
	$factory->submit_blast($seq);
	
	our $hit_acc;
	#Retrieves Results from BLAST
	while(my @rids = $factory->each_rid){
	        foreach my $rid (@rids){
        	        my $results = $factory->retrieve_blast($rid);
                	if( ref( $results )) {
                        	#Loops through each hit
				my $result = $results->next_result;
                        	do{
                                	my $hit   = $result->next_hit;
                                	$hit_acc = $hit->accession;
					my $hit_evalue = $hit->expect;
					#Loads hit seq's info into variables
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
					#Stores the hit seq's info into database
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
					#Stores the connection of the blast results
                                	$sth = $dbh->prepare( "insert or replace INTO blast
                                        	                        (search_seq_id
                                                	                ,result_seq_id
									,e_value)
                                                        	VALUES ((select id from seq where seq.accession = '$ACCESSION'),(select id from seq where seq.accession = '$hit_accession'), $hit_evalue);");
                                	$sth->execute();
                                	$sth->finish();
					#Prints out to user the hit's accession
                                	print "$hit_acc\n";
                        	}while($hit_acc ne '');
                        	$factory->remove_rid( $rid );
                	}elsif( $results < 0 ) {
                        	$factory->remove_rid( $rid );
                	}else {
                        	sleep 5;
                	}
 	       }
	}
	
	#Updates stored seq list
	$sth = $dbh->prepare( "select accession from seq;" );
        $sth->execute();
        while ( my @row = $sth->fetchrow_array() ) {
                push(@SEQS, @row);
        }
        $sth->finish();

}
                                
#Sets up form
my $url = url();
print start_form( -method => 'GET' , action => $url ),

p( "Accession Number: " . textfield( -name => 'search_accession' )),
p( submit( -name => 'search_submit' , value => 'Search Accession' )),
p( "Stored Accession Numbers: " . popup_menu( -name => 'stored_accession' ,
        -values => @SEQS )),
p( submit( -name => 'retrieve_submit' , value => 'Retrieve Stored Accession' )),
p( "Database: " . popup_menu( -name => 'blast_db' ,
        -values => ('swissprot', 'nr', 'refseq_protein', 'landmark', 'pat', 'env_nr', 'tsa_nr', 'pdb') )),
p( submit( -name => 'blast_submit' , value => 'BLAST Accession' )),

end_form(),
end_html();

#Close DB Connection
$dbh->disconnect();
