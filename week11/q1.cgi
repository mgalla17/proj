#! /usr/bin/perl

use strict;
use warnings;

use CGI (':standard');
use LWP::Simple;

#Sets up list of all Entrez DBs
my @db  = ("Pubmed", "protein", "nucleotide", "nuccore", "nucgss", "nucest", "structure", "genome",
                "biosystems", "books", "cancerchromosomes", "cdd", "gap",
                "domains", "gene", "genomeprj", "gensat", "geo", "gds",
                "homologene", "journals", "mesh", "ncbisearch", "nlmcatalog",
                "omia", "omim", "pepdome", "pmc", "popset", "probe",
                "proteinclusters", "pcassay", "pccompound", "pcsubstance",
                "seqannot", "snp", "sra", "taxonomy", "toolkit", "toolkitall",
                "unigene", "unists");
#Sets up eutils URL
my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";

#CGI Title
my $title = 'Query the Entrez Databases!';
print header,
start_html( $title ),
	h1( $title );
#Form Submission
if( param( 'submit' )) {
	#Takes in input
	my $INPUTquery = param( 'query' );
	#Does a search in each Entrez DB and returns the record count	
	print "RESULT COUNTS:\n";
	foreach my $db (@db){
        	my $esearch = "$utils/esearch.fcgi?". "db=$db&retmax=1&usehistory=y&term=";
        	my $esearch_result = get($esearch . $INPUTquery);
        	my ($count)=($esearch_result =~ m|<Count>(.*)</Count>|);
        	if($count eq ""){$count = 0};
        	print "$db - $count\n";
	}

}
                                
#Sets up form
my $url = url();
print start_form( -method => 'GET' , action => $url ),
p( "Query: " . textfield( -name => 'query' )),
p( submit( -name => 'submit' , value => 'Submit' )),
end_form(),
end_html();

