#! /usr/bin/perl

package RestrictionEnzyme;

#Declare new instance of class
sub new {
	my($class, %attribs) = (@_);
	my $obj = {
		_name => $attribs{name} || die("need 'name'"),
		_manufacturer => $attribs{manufacturer},
		_recognition_sequence => $attribs{recognition_sequence} || die("need 'recognition_sequence'"),
		_cut_position => $attribs{cut_position},
		_source => $attribs{source},
	};
	return bless $obj, $class;
}

1;

#Retrieve each attribute
sub get_name {
  my( $self ) = ( @_ );
  return $self->{_name};
}
sub get_manufacturer {
  my( $self ) = ( @_ );
  return $self->{_manufacturer};
}
sub get_recognition_sequence {
  my( $self ) = ( @_ );
  return $self->{_recognition_sequence};
}
sub get_cut_position {
  my( $self ) = ( @_ );
  return $self->{_cut_position};
}
sub get_source {
  my( $self ) = ( @_ );
  return $self->{_source};
}
#Set each attribute
sub set_name {
  my( $self , $new_name ) = ( @_ );
  $self->{_name} = $new_name;
  return $self->{_name};
}
sub set_manufacturer {
  my( $self , $new_manufacturer ) = ( @_ );
  $self->{_manufacturer} = $new_manufacturer;
  return $self->{_manufacturer};
}
sub set_recognition_sequence {
  my( $self , $new_recognition_sequence ) = ( @_ );
  if ($new_recognition_sequence =~ m/^(A|T|C|G)*$/){
    $self->{_recognition_sequence} = $new_recognition_sequence;
  }
  return $self->{_recognition_sequence};
}
sub set_cut_position {
  my( $self , $new_cut_position ) = ( @_ );
  $self->{_cut_position} = $new_cut_position;
  return $self->{_cut_position};
}
sub set_source {
  my( $self , $new_source ) = ( @_ );
  $self->{_source} = $new_source;
  return $self->{_source};
}

#### Methods ####
sub cut_dna {
	my ($self, $dna) = @_;
	#my $dna_comp =
	my $rec_seq = $self->{_recognition_sequence};
	my @fragments = split(/$rec_seq/, $dna);
	return(@fragments);
}














