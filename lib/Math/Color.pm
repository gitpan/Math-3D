package Math::Color;

use strict;
use warnings;

our $VERSION = '0.01';

use POSIX ();

use Math::Vec3;
use base qw(Math::Vec3);

=head1 NAME

Math::Color - Perl class to represent rotations

=head1 HIERARCHY

-+- L<Math::Vec3> -+- L<Math::Color>

=head1 SEE ALSO

L<Math::Color>, L<Math::Image>, L<Math::Vec2>, L<Math::Vec3>, L<Math::Rotation>
L<Math::Quaternion>

=head1 SYNOPSIS
	
	use Math::Color;
	my $c = new Math::Color;  # Make a new Color

	my $c1 = new Math::Color(0,1,0);

=head1 DESCRIPTION

=head1 METHODS

=over 1

=item B<new(r,g,b)>

r, g, b are given on [0, 1].

	my $c = new Math::Color; 					  
	my $c1 = new Math::Color($v);   
	my $c2 = new Math::Color(0, 0.5, 1);   
	my $c3 = new Math::Color([0, 0.5, 1]); 

=cut

=item B<copy>

Makes a copy of the rotation
	
	$c2 = $c1->copy;
	$c2 = new Math::Color($c1);
=cut

=item B<setValue(r,g,b)>

Sets the value of the color.
r, g, b are given on [0, 1].

	$c1->setValue(0, 0.2, 1);
=cut

=item B<setRed(r)>

Sets the first value of the color
r is given on [0, 1].

	$c1->setRed(1);

	$c1->red = 1;
	$c1->r   = 1;
	$c1->[0] = 1;
=cut

*setRed = \&Math::Vec3::setX;
*getRed = \&Math::Vec3::getX;
*red    = \&Math::Vec3::x;
*r      = \&Math::Vec3::x;

=item B<setGreen(g)>

Sets the second value of the color.
g is given on [0, 1].

	$c1->setGreen(0.2);

	$c1->green = 0.2;
	$c1->g   = 0.2;
	$c1->[1] = 0.2;
=cut

*setGreen = \&Math::Vec3::setY;
*getGreen = \&Math::Vec3::getY;
*green    = \&Math::Vec3::y;
*g        = \&Math::Vec3::y;

=item B<setBlue(b)>

Sets the third value of the color.
b is given on [0, 1].

	$c1->setZ(0.3);

	$c1->z   = 0.3;
	$c1->[2] = 0.3;
=cut

*setBlue = \&Math::Vec3::setZ;
*getBlue = \&Math::Vec3::getZ;
*blue    = \&Math::Vec3::z;
*b       = \&Math::Vec3::z;

=item B<getValue>

Returns the @value of the color.

	@v = $c1->getValue;
=cut

=item B<getRed>

Returns the first value of the color.

	$r = $c1->getRed;
	$r = $c1->red;
	$r = $c1->r;
	$r = $c1->[0];
=cut

=item B<getGreen>

Returns the second value of the color.

	$g = $c1->getGreen;
	$g = $c1->green;
	$g = $c1->g;
	$g = $c1->[1];
=cut

=item B<getBlue>

Returns the third value of the color.

	$b = $c1->getBlue;
	$b = $c1->blue;
	$b = $c1->b;
	$b = $c1->[2];
=cut

=item B<setHSV(h,s,v)>

h, s, v are given on [0, 1].
RGB are each returned on [0, 1].

	$c->setHSV(1/12,1,1);  # 1 0.5 0
=cut

sub setHSV {
	my ( $this, $h, $s, $v ) = @_;

	# H is given on [0, 1]. S and V are given on [0, 1].
	# RGB are each returned on [0, 1].

	# achromatic (grey)
	return $this->setValue( $v, $v, $v ) if $s == 0;

	my ( $i, $f, $p, $q, $t );

	$h *= 6;

	$i = POSIX::floor($h);
	$f = $h - $i;                        # factorial part of h
	$p = $v * ( 1 - $s );
	$q = $v * ( 1 - $s * $f );
	$t = $v * ( 1 - $s * ( 1 - $f ) );

	return $this->setValue( $v, $t, $p ) if $i == 0;
	return $this->setValue( $q, $v, $p ) if $i == 1;
	return $this->setValue( $p, $v, $t ) if $i == 2;
	return $this->setValue( $p, $q, $v ) if $i == 3;
	return $this->setValue( $t, $p, $v ) if $i == 4;
	return $this->setValue( $v, $p, $q ) if $i == 5;

	return $this->setValue( $v, $t, $p );
}

sub _min { $_[0] < $_[1] ? $_[0] : $_[1] }
sub _max { $_[0] > $_[1] ? $_[0] : $_[1] }

=item B<getHSV>

h, s, v are each returned on [0, 1].

	@hsv = $c->getHSV;
=cut

sub getHSV {
	my ($this) = @_;

	my ( $h, $s, $v );
	my ( $r, $g, $b ) = $this->getValue;

	my $min = _min( $r, _min( $g, $b ) );
	my $max = _max( $r, _max( $g, $b ) );
	$v = $max;    # v

	my $delta = $max - $min;

	if ( $max != 0 && $delta != 0 ) {
		$s = $delta / $max;    # s
	} else {
		# r = g = b = 0                            # s = 0, h is undefined
		$s = 0;
		$h = 0;
		return ( $h, $s, $v );
	}

	if ( $r == $max ) {
		$h = ( $g - $b ) / $delta;    # between yellow & magenta
	} elsif ( $g == $max ) {
		$h = 2 + ( $b - $r ) / $delta;    # between cyan & yellow
	} else {
		$h = 4 + ( $r - $g ) / $delta;    # between magenta & cyan
	}

	$h /= 6;                              # radiants
	if ( $h < 0 ) {
		$h += 1;
	}

	return ( $h, $s, $v );
}

=item B<stringify>

Returns a string representation of the color. This is used
to overload the '""' operator, so that color may be
freely interpolated in strings.

	my $c = new Math::Color(0.1, 0.2, 0.3);
	print $c->stringify; # "0.1, 0.2, 0.3"
	print "$c";          # "0.1, 0.2, 0.3"

=cut

1;
__END__
