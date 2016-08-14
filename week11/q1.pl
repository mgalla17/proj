#! /usr/bin/perl

use LWP::Simple;

#Sets up eutils URL 
my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";

#Gets the user's query
print "Type in Query: ";
chomp($INPUTquery = <STDIN>);

#Sets the list of Entrez Databases
my @db  = ("Pubmed", "protein", "nucleotide", "nuccore", "nucgss", "nucest", "structure", "genome",
          	"biosystems", "books", "cancerchromosomes", "cdd", "gap",
                "domains", "gene", "genomeprj", "gensat", "geo", "gds",
                "homologene", "journals", "mesh", "ncbisearch", "nlmcatalog",
                "omia", "omim", "pepdome", "pmc", "popset", "probe",
                "proteinclusters", "pcassay", "pccompound", "pcsubstance",
                "seqannot", "snp", "sra", "taxonomy", "toolkit", "toolkitall",
                "unigene", "unists");

print "RESULT COUNTS:\n";
#Loops through the databases and prints out the count of hits
foreach my $db (@db){
	my $esearch = "$utils/esearch.fcgi?". "db=$db&retmax=1&usehistory=y&term=";
	my $esearch_result = get($esearch . $INPUTquery);
	my ($count)=($esearch_result =~ m|<Count>(.*)</Count>|);
	if($count eq ""){$count = 0};
	print "$db - $count\n";
}
