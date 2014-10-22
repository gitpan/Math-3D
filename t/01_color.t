#!/usr/bin/perl -w
use Test::More tests => 72;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Math::Color');
}

my ( $v, $v1, $v2 );

is( $v = new Math::Color(), "0 0 0", "$v new Math::Color()" );
is( $v = new Math::Color( 1, 2, 3 ), "1 2 3", "$v new Math::Color()" );
is( $v = new Math::Color( [ 1, 2, 3 ] ), "1 2 3", "$v new Math::Color()" );
is( $v = new Math::Color($v), "1 2 3", "$v new Math::Color()" );
is( "$v", "1 2 3", "$v ''" );

is( $v = Math::Color->new( 1, 2, 3 )->getX, "1", "$v getX" );
is( $v = Math::Color->new( 1, 2, 3 )->getY, "2", "$v getY" );
is( $v = Math::Color->new( 1, 2, 3 )->getZ, "3", "$v getZ" );

is( $v = Math::Color->new( 1, 2, 3 )->x, "1", "$v x" );
is( $v = Math::Color->new( 1, 2, 3 )->y, "2", "$v y" );
is( $v = Math::Color->new( 1, 2, 3 )->z, "3", "$v z" );

is( $v = new Math::Color( 1, 2, 3 ), "1 2 3", "$v new Math::Color()" );
is( $v->r = 2, "2", "$v x" );
is( $v->g = 3, "3", "$v y" );
is( $v->b = 4, "4", "$v z" );

ok( $v->x == $v->getRed, "$v x" );
ok( $v->x == $v->red,    "$v x" );
ok( $v->x == $v->r,      "$v x" );

ok( $v->y == $v->getGreen, "$v y" );
ok( $v->y == $v->green,    "$v y" );
ok( $v->y == $v->g,        "$v y" );

ok( $v->z == $v->getBlue, "$v z" );
ok( $v->z == $v->blue,    "$v z" );
ok( $v->z == $v->b,       "$v z" );

is( $v->[0], "2", "$v [0]" );
is( $v->[1], "3", "$v [1]" );
is( $v->[2], "4", "$v [2]" );

ok( Math::Color->new( 1, 2, 3 ) eq "1 2 3", "$v eq" );

is( $v = new Math::Color( 1, 2, 3 ), "1 2 3", "$v new Math::Color()" );

is( $v->copy, "1 2 3", "$v copy" );

ok( $v eq new Math::Color( 1, 2, 3 ), "$v eq" );
ok( $v == new Math::Color( 1, 2, 3 ), "$v ==" );
ok( $v ne new Math::Color( 0, 2, 3 ), "$v ne" );
ok( $v != new Math::Color( 0, 2, 3 ), "$v !=" );

is( $v1 = new Math::Color( 1, 2, 3 ), "1 2 3", "$v1 v1" );
is( $v2 = new Math::Color( 2, 3, 4 ), "2 3 4", "$v2 v2" );

is( $v = -$v1,      "-1 -2 -3",  "$v -" );
is( $v = $v1 + $v2, "3 5 7",     "$v +" );
is( $v = $v1 - $v2, "-1 -1 -1",  "$v -" );
is( $v = $v1 * 2,   "2 4 6",     "$v *" );
is( $v = $v1 / 2,   "0.5 1 1.5", "$v /" );
is( $v = $v1 . $v2, "20",        "$v ." );
is( $v = $v1 x $v2, "-1 2 -1",   "$v x" );
is( $v = $v1 . [ 2, 3, 4 ], "20",      "$v ." );
is( $v = $v1 x [ 2, 3, 4 ], "-1 2 -1", "$v x" );
is( $v = $v1 x 2, "1 2 31 2 3", "$v x" );


is( sprintf( "%0.0f", $v = $v1->length ), "4", "$v length" );

is( $v1 += $v2, "3 5 7", "$v1 +=" );
is( $v1 -= $v2, "1 2 3", "$v1 -=" );
is( $v1 *= 2, "2 4 6", "$v1 *=" );
is( $v1 /= 2, "1 2 3", "$v1 /=" );

$v1->setHSV(0/6,1,1);
is( $v1, "1 0 0", "$v1 setHSV" );

$v1->setHSV(1/6,1,1);
is( $v1, "1 1 0", "$v1 setHSV" );

$v1->setHSV(2/6,1,1);
is( $v1, "0 1 0", "$v1 setHSV" );

$v1->setHSV(3/6,1,1);
is( $v1, "0 1 1", "$v1 setHSV" );

$v1->setHSV(4/6,1,1);
is( $v1, "0 0 1", "$v1 setHSV" );

$v1->setHSV(5/6,1,1);
is( $v1, "1 0 1", "$v1 setHSV" );

$v1->setHSV(6/6,1,1);
is( $v1, "1 0 0", "$v1 setHSV" );



is( $v = new Math::Color( 1, 2, 3 ), "1 2 3", "$v new Math::Color()" );
is( $v, "1 2 3", "$v new Math::Color()" );

$v1->setHSV(1/12,1,1); $v->setHSV($v1->getHSV);
is( $v1, "1 0.5 0", "$v1 setHSV" );

$v1->setHSV(3/12,1,1); $v->setHSV($v1->getHSV);
is( $v1, "0.5 1 0", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV(5/12,1,1); $v->setHSV($v1->getHSV);
is( $v1, "0 1 0.5", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV(7/12,1,1); $v->setHSV($v1->getHSV);
is( $v1, "0 0.5 1", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV(9/12,1,1); $v->setHSV($v1->getHSV);
is( $v1, "0.5 0 1", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );

$v1->setHSV(11/12,1,1); $v->setHSV($v1->getHSV);
is( $v1, "1 0 0.5", "$v1 setHSV" );
ok( $v eq $v1, "$v getHSV" );


#use Math::Rotation;
#my $r = new Math::Rotation(2,3,4,5);
#ok( $v = $r * $v1, "$v x ");

__END__
