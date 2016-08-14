#! /usr/bin/perl

sub ask_user {
    print "$_[0] [$_[1]]: ";
    my $rc = <>;
    chomp $rc;
    if($rc eq "") { $rc = $_[1]; }
    return $rc;
  }

use LWP::Simple;
  
  my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";
  
  my $db     = ask_user("Database", "Pubmed");
  my $query  = ask_user("Query",    "zanzibar");
  my $report = ask_user("Report",   "abstract");

my $esearch = "$utils/esearch.fcgi?" .
                "db=$db&retmax=1&usehistory=y&term=";
  
  my $esearch_result = get($esearch . $query);
  
  print "\nESEARCH RESULT: $esearch_result\n";
  
  $esearch_result =~
    m|<count>(\d+)</count>.*<querykey>(\d+)</querykey>.*<webenv>(\S+)</webenv>|s;
  
  my $Count    = $1;
  my $QueryKey = $2;
  my $WebEnv   = $3;
  
  print "Count = $Count; QueryKey = $QueryKey; WebEnv = $WebEnv\n";

my $retstart;
  my $retmax=3;
  
  for($retstart = 0; $retstart < $Count; $retstart += $retmax) {
    my $efetch = "$utils/efetch.fcgi?" .
                 "rettype=$report&retmode=text&retstart=$retstart&retmax=$retmax&" .
                 "db=$db&query_key=$QueryKey&WebEnv=$WebEnv";
  
    print "\nEF_QUERY=$efetch\n";
  
    my $efetch_result = get($efetch);
  
    print "---------\nEFETCH RESULT(".
           ($retstart + 1) . ".." . ($retstart + $retmax) . "): ".
          "[$efetch_result]\n-----PRESS ENTER!!!-------\n";
    <>;
  }
