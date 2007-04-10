package Math::Vec3;

use strict;
use warnings;

use Carp;
use Scalar::Util;

#use Exporter;

use overload
  '='    => \&copy,
  'bool' => sub { 1 },     # So we can do if ($foo=Math::Vec3->new) { .. }
  'neg'  => \&negate,
  '+='   => \&_add,
  '-='   => \&_subtract,
  '*='   => \&_multiply,
  '/='   => \&_divide,
  '+'    => \&add,
  '-'    => \&subtract,
  '*'    => \&multiply,
  '/'    => \&divide,
  '.'    => \&dot,
  'x'    => \&cross,
  'eq'   => \&eq,
  '=='   => \&eq,
  'ne'   => \&ne,
  '!='   => \&ne,
  '""'   => \&stringify,
  ;

our $VERSION = '0.01';

=head1 NAME

Math::Vec3 - Perl class to represent rotations

=head1 HIERARCHY

-+- L<Math::Vec3>

=head1 SEE ALSO

L<Math::Color>, L<Math::Image>, L<Math::Vec2>, L<Math::Vec3>, L<Math::Rotation>
L<Math::Quaternion>

=head1 SYNOPSIS
	
	use Math::Vec3;
	my $v = new Math::Vec3;  # Make a new vec3

	my $v1 = new Math::Vec3(0,1,0);

=head1 DESCRIPTION

=head1 METHODS

=over 1

=item B<new>

	my $v = new Math::Vec3; 					  
	my $v1 = new Math::Vec3($v);   
	my $v2 = new Math::Vec3(1,2,3);   
	my $v3 = new Math::Vec3([1,2,3]); 

=cut

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = bless [], $class;

	if ( 0 == @_ ) {
		# No arguments, default to standard
		$this->setValue( 0, 0, 0 );
	} elsif ( 1 == @_ ) {

		my $arg1    = shift;
		my $reftype = Scalar::Util::reftype($arg1);

		if ( "ARRAY" eq $reftype ) {
			$this->setValue(@$arg1);
		} else {
			croak("Don't understand arguments passed to new()");
		}
	} elsif ( @_ > 2  ) {    # x,y,z,angle
		$this->setValue(@_);
	} else {
		croak("Don't understand arguments passed to new()");
	}

	return $this;
}

=item B<copy>

Makes a copy of the rotation
	
	$v2 = $v1->copy;
	$v2 = new Math::Vec3($v1);
=cut

sub copy {
	my $this = shift;
	return $this->new($this);
}

=item B<setValue(x,y,z)>

Sets the value of the vector

	$v1->setValue(1,2,3);
=cut

sub setValue { @{ $_[0] } = @_[ 1, 2, 3 ] }

=item B<setX(x)>

Sets the first value of the vector

	$v1->setX(1);

	$v1->x   = 1;
	$v1->[0] = 1;
=cut

sub setX { $_[0]->[0] = $_[1] }

=item B<setY(y)>

Sets the second value of the vector

	$v1->setY(2);

	$v1->y   = 2;
	$v1->[1] = 2;
=cut

sub setY { $_[0]->[1] = $_[1] }

=item B<setZ(z)>

Sets the third value of the vector

	$v1->setZ(3);

	$v1->z   = 3;
	$v1->[2] = 3;
=cut

sub setZ { $_[0]->[2] = $_[1] }

=item B<getValue>

Returns the @value of the vector

	@v = $v1->getValue;
=cut

sub getValue { @{ $_[0] } }

=item B<x>
=cut

=item B<getX>

Returns the first value of the vector.

	$x = $v1->getX;
	$x = $v1->x;
	$x = $v1->[0];
=cut

sub getX       { $_[0]->[0] }
sub x : lvalue { $_[0]->[0] }

=item B<y>
=cut

=item B<getY>

Returns the second value of the vector.

	$y = $v1->getY;
	$y = $v1->y;
	$y = $v1->[1];
=cut

sub getY       { $_[0]->[1] }
sub y : lvalue { $_[0]->[1] }

=item B<z>
=cut

=item B<getZ>

Returns the third value of the vector

	$z = $v1->getZ;
	$z = $v1->z;
	$z = $v1->[2];
=cut

sub getZ       { $_[0]->[2] }
sub z : lvalue { $_[0]->[2] }

=item B<negate>

	$v = $v1->negate;
	$v = -$v1;
=cut

sub negate {
	my ($a) = @_;
	return $a->new(
		-$a->[0],
		-$a->[1],
		-$a->[2]
	);
}

=item B<add(vec3)>

	$v = $v1->add($v2);
	$v = $v1 + $v2;
	$v1 += $v2;
=cut

sub add {
	my ( $a, $b ) = @_;
	return $a->new(
		$a->[0] + $b->[0],
		$a->[1] + $b->[1],
		$a->[2] + $b->[2]
	);
}

sub _add {
	my ( $a, $b ) = @_;
	$a->[0] += $b->[0];
	$a->[1] += $b->[1];
	$a->[2] += $b->[2];
	return $a;
}

=item B<subtract(vec3)>

	$v = $v1->subtract($v2);
	$v = $v1 - $v2;
	$v1 -= $v2;
=cut

sub subtract {
	my ( $a, $b ) = @_;
	return $a->new(
		$a->[0] - $b->[0],
		$a->[1] - $b->[1],
		$a->[2] - $b->[2]
	);
}

sub _subtract {
	my ( $a, $b ) = @_;
	$a->[0] -= $b->[0];
	$a->[1] -= $b->[1];
	$a->[2] -= $b->[2];
	return $a;
}

=item B<multiply(scalar)>

	$v = $v1->multiply($v2);

	$v = $v1->multiply(2);
	$v = $v1 * 2;
	$v1 *= 2;
=cut

sub multiply {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new(
		$a->[0] * $b->[0],
		$a->[1] * $b->[1],
		$a->[2] * $b->[2]
	  )
	  :
	  $a->new(
		$a->[0] * $b,
		$a->[1] * $b,
		$a->[2] * $b
	  );
}

sub _multiply {
	my ( $a, $b ) = @_;
	$a->[0] *= $b;
	$a->[1] *= $b;
	$a->[2] *= $b;
	return $a;
}

=item B<divide(scalar)>

	$v = $v1->divide($v2);

	$v = $v1->divide(2);
	$v = $v1 / 2;
	$v1 /= 2;
=cut

sub divide {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new(
		$a->[0] / $b->[0],
		$a->[1] / $b->[1],
		$a->[2] / $b->[2]
	  )
	  : $a->new(
		$a->[0] / $b,
		$a->[1] / $b,
		$a->[2] / $b
	  );
}

sub _divide {
	my ( $a, $b ) = @_;
	$a->[0] /= $b;
	$a->[1] /= $b;
	$a->[2] /= $b;
	return $a;
}

=item B<dot(vec3)>

	$s = $v1->dot($v2);
	$s = $v1 . $v2;
	$s = $v1 . [ 2, 3, 4 ];
=cut

sub dot {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->[0] * $b->[0] +
	  $a->[1] * $b->[1] +
	  $a->[2] * $b->[2]
	  : $a->stringify . $b
	  ;
}

=item B<cross(vec3)>

	$v = $v1->cross($v2);
	$v = $v1 x $v2;
	$v = $v1 x [ 2, 3, 4 ];
=cut

sub cross {
	my ( $a, $b ) = @_;
	return ref $b ?
	  $a->new(
		$a->[1] * $b->[2] - $a->[2] * $b->[1],
		$a->[2] * $b->[0] - $a->[0] * $b->[2],
		$a->[0] * $b->[1] - $a->[1] * $b->[0]
	  )
	  : $a->stringify x $b
	  ;
}

=item B<length>

Returns the length of the vector

	$l = $v1->length;
=cut

sub length {
	my ($a) = @_;
	return sqrt(
		$a->[0] * $a->[0] +
		  $a->[1] * $a->[1] +
		  $a->[2] * $a->[2]
	);
}

=item B<normalize>

	$v = $v1->normalize;
=cut

sub normalize {
	my ($a) = @_;
	return $a->divide( $a->length );
}

=item B<eq(vec3)>

	my $bool = $v1->eq($v2);
	my $bool = $v1 eq $v2;
	my $bool = $v1 == $v2;
=cut

sub eq {
	my ( $a, $b ) = @_;
	return "$a" eq $b;
}

=item B<ne(vec3)>

	my $bool = $v1->ne($v2);
	my $bool = $v1 ne $v2;
	my $bool = $v1 != $v2;
=cut

sub ne {
	my ( $a, $b ) = @_;
	return "$a" ne $b;
}

=item B<stringify>

Returns a string representation of the vector. This is used
to overload the '""' operator, so that vector may be
freely interpolated in strings.

	my $v = new Math::Vec3(1,2,3,4);
	print $v->stringify;                # "1 2 3"
	print "$v";                         # "1 2 3"

=cut

sub stringify {
	my $this = shift;
	return join " ", map { $_ || 0 } $this->getValue;
}

1;
__END__
