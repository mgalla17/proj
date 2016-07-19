#! /usr/bin/perl

use strict;
use warnings;

use DBI;

#Sets DB connection
################################################
#### !! SQL for Schema Located in q1.sql !! ####
################################################
my $dbh = DBI->connect( "DBI:SQLite:dbname=mRNA", "", "",
			{ PrintError => 0 , RaiseError => 1 } );

#Reads File and Parses
open(my $file, '<', "data.fasta");
while ( my $line = <$file> ) {
    	my ($GENE_NAME, $ORGANISM, $TISSUE, $START, $STOP, $EXPRESSION_LEVEL, $SEQUENCE) = split('\|', $line);
	
	#Inserts Organism Info
	my $sth = $dbh->prepare( "insert or replace INTO Organism (ID, Organism_Name) VALUES ((select ID from Organism where Organism_Name = '$ORGANISM'), '$ORGANISM');" );
	$sth->execute();
	$sth->finish();

	#Inserts Tissue Info
	$sth = $dbh->prepare( "insert or replace INTO Tissue (ID, Tissue_Name) VALUES ((select ID from Tissue where Tissue_Name = '$TISSUE'), '$TISSUE');" );
	$sth->execute();
	$sth->finish();

	#Inserts Gene Info
	$sth = $dbh->prepare( "insert or replace INTO Gene (ID, Organism_ID, Tissue_ID, Gene_Name) VALUES ((select ID from Gene where Gene_Name = '$GENE_NAME'), (select ID from Organism where Organism_Name = '$ORGANISM'), (select ID from Tissue where Tissue_Name = '$TISSUE'), '$GENE_NAME');" );
	$sth->execute();
	$sth->finish();

	#Inserts Sequence Info
	$sth = $dbh->prepare( "insert or replace INTO Sequence (ID, Gene_ID, Sequence, Expression_Level, Start, Stop) VALUES ((select ID from Sequence where Sequence = '$SEQUENCE'), (select ID from Gene where Gene_Name = '$GENE_NAME'), '$SEQUENCE', '$EXPRESSION_LEVEL', '$START', '$STOP');" );
	$sth->execute();
	$sth->finish();
}

#Close File and DB Connection
close $file;
$dbh->disconnect();



