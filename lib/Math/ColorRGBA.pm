package Math::ColorRGBA;

use strict;
use warnings;

our $VERSION = '0.01';

use Math::Color;
use base qw(Math::Color);

=head1 NAME

Math::ColorRGBA - Perl class to represent rotations

=head1 HIERARCHY

-+- L<Math::Vec3> -+- L<Math::Color> -+- L<Math::ColorRGBA>

=head1 SEE ALSO

L<Math::Color>, L<Math::Image>, L<Math::Vec2>, L<Math::Vec3>, L<Math::Rotation>
L<Math::Quaternion>

=head1 SYNOPSIS
	
	use Math::ColorRGBA;
	my $c = new Math::ColorRGBA;  # Make a new Color

	my $c1 = new Math::ColorRGBA(0,1,0,0);

=head1 DESCRIPTION
=head1 METHODS

=over 1

=item B<new(r,g,b,a)>

r, g, b,a are given on [0, 1].

	my $c = new Math::ColorRGBA; 					  
	my $c1 = new Math::ColorRGBA($v);   
	my $c2 = new Math::ColorRGBA(0, 0.5, 1, 0);   
	my $c3 = new Math::ColorRGBA([0, 0.5, 1, 1]); 

=cut

=item B<copy>

Makes a copy of the rotation
	
	$c2 = $c1->copy;
	$c2 = new Math::ColorRGBA($c1);
=cut

=item B<setValue(r,g,b,a)>

Sets the value of the color.
r, g, b, a are given on [0, 1].

	$c1->setValue(0, 0.2, 1, 0);
=cut

sub setValue { @{ $_[0] } = @_[ 1, 2, 3, 4 ] }

=item B<setRed(r)>

Sets the first value of the color
r is given on [0, 1].

	$c1->setRed(1);

	$c1->red = 1;
	$c1->r   = 1;
	$c1->[0] = 1;
=cut

=item B<setGreen(g)>

Sets the second value of the color.
g is given on [0, 1].

	$c1->setGreen(0.2);

	$c1->green = 0.2;
	$c1->g   = 0.2;
	$c1->[1] = 0.2;
=cut

=item B<setBlue(b)>

Sets the third value of the color.
b is given on [0, 1].

	$c1->setZ(0.3);

	$c1->z   = 0.3;
	$c1->[2] = 0.3;
=cut

=item B<setAlpha(alpha)>

Sets the first value of the vector

	$v1->setAlpha(1);

	$v1->alpha = 1;
	$v1->[3] = 1;
=cut

sub setAlpha { $_[0]->[3] = $_[1] }

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

=item B<alpha>
=cut

=item B<getBlue>

Returns the third value of the color.

	$b = $c1->getBlue;
	$b = $c1->blue;
	$b = $c1->b;
	$b = $c1->[2];
=cut

=item B<getAlpha>

Returns the first value of the vector.

	$x = $v1->getAlpha;
	$x = $v1->alpha;
	$x = $v1->[3];
=cut

sub getAlpha       { $_[0]->[3] }
sub alpha : lvalue { $_[0]->[3] }

=item B<setHSV(h,s,v)>

h, s, v are given on [0, 1].
RGB are each returned on [0, 1].

	$c->setHSV(1/12,1,1);  # 1 0.5 0
=cut

=item B<getHSV>

h, s, v are each returned on [0, 1].

	@hsv = $c->getHSV;
=cut

=item B<stringify>

Returns a string representation of the color. This is used
to overload the '""' operator, so that color may be
freely interpolated in strings.

	my $c = new Math::ColorRGBA(0.1, 0.2, 0.3);
	print $c->stringify; # "0.1, 0.2, 0.3"
	print "$c";          # "0.1, 0.2, 0.3"

=cut

1;
__END__
