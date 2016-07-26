#! /usr/bin/perl

package RestrictionEnzyme;
use Moose;
use Moose::Util::TypeConstraints;

#### Attributes ####
#Name Attribute
has name => (
	is => 'rw',
	required => 1,
	isa => 'str',
);
#Manufacturer Attribute
has manufacturer => (
        is => 'rw',
	isa => 'Str',
);
#Recognition Sequence Attribute
has recognition_sequence => (
        is => 'rw',
	isa => 'DNA',
);
#Size Attribute
has cut_position => (
	is => 'rw',
	isa => 'Int',
);
#Source Attribute
has source => (
        is => 'rw',
        isa => 'Str',
);

#### Subtypes ####
subtype 'DNA'
	=> as 'Str'
	=> where {$_ =~ /^(A|T|C|G)*$/};

#### Methods ####
sub cut_dna {
	my($self, $dna) = @_;
	#my $dna_comp =
	my $rec_seq = $self->recognition_sequence;
	my @fragments = split(/$rec_seq/, $dna);
	return(@fragments);
}


=pod

=head1 DESCRIPTION:
This OO class of Restriction Enzyme is to store the information about such enzymes. It also serves to provide the functionality of processing a given dna sequence and then apply a restriction enzyme to it to show the cuts that that enzyme would make and your resulting DNA fragments.

=head2 How to Use:
To use this package place "use NucleicAcid;" in the beginning of your program.
To create a new object of this class use "my $var = RestrictionEnzyme->new( name => 'name', manufacturer => 'Company', recognition_sequence => 'Sequence (ATCG)', cut_position => #, source => 'source' );"

=head2 Name:
The 'name' Attribute is the restriction enzyme's name. An example of this is "EcoRI". To change the name of your ob
ject use "$var->name() = 'new name';" or to get the name of your object use "$var->name()".

=head2 Manufacturer:
The 'manufacturer' Attribute is who made the restriction enzyme. An example of this is "Thermo". To change the manufacturer of your object use "$var->manufacturer() = 'new manufacturer';" or to get the manufacturer of your object use "$var->manufacturer()".

=head2 Recognition Sequence:
The 'recognition_sequence' Attribute is the restriction enzyme's recognition sequence that it cuts at. An example of this is "ACCTT". It has to be a combination of ATCG's. To change the recognition_sequence of your object use "$var->recognition_sequence() = 'new recognition sequence';" or to get the recognition_sequence of your object use "$var->recognition_sequence()".

=head2 Cut Position:
The 'cut_position' Attribute is the restriction enzyme's cut position in the given recognition site. It is a count of how far down in teh sequence it makes the cut. An example of this is "3". To change the cut position of your object use "$var->cut_position() = #;" or to get the cut position of your object use "$var->cut_position()".

=head2 Source:
The 'source' Attribute is the restriction enzyme's source organisms. An example of this is "E. Coli". To change thesource of your object use "$var->source() = 'new source';" or to get the source of your object use "$var->source()".

=head2 Cut Into Fragments:
The "cut_dna" method is provided so you can pass into it your restriction enzyme object and a given dna sequence an
d it will return an array that consists of your fragments after it is cut. To use this use the function "cut_dna($RestrictionEnzymeObject, $dna_seq)".

=cut












