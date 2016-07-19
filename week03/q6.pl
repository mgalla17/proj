#! /usr/bin/perl

use warnings;
use strict;
 
our $INPUTregexp;
our $INPUTstring;
print "Enter regexp:";
chomp($INPUTregexp = <STDIN>);       
 
do { 
	print "Enter string or 'exit' to exit;";
	chomp($INPUTstring = <STDIN>); 
	if ($INPUTstring eq "exit"){
		print "bye!\n"
	}
	elsif ($INPUTstring =~ $INPUTregexp){ 
        	print "Match!\n";
	}else{
		print "No match!\n";
	}
}while($INPUTstring ne "exit");
