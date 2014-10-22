#!/usr/bin/perl -w
use Test::More tests => 47;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Math::Vec3');
}

my ( $v, $v1, $v2 );

is( $v = new Math::Vec3(), "0 0 0", "$v new Math::Vec3()" );
is( $v = new Math::Vec3( 1, 2, 3 ), "1 2 3", "$v new Math::Vec3()" );
is( $v = new Math::Vec3( [ 1, 2, 3 ] ), "1 2 3", "$v new Math::Vec3()" );
is( $v = new Math::Vec3($v), "1 2 3", "$v new Math::Vec3()" );
is( "$v", "1 2 3", "$v ''" );

is( $v = Math::Vec3->new( 1, 2, 3 )->getX, "1", "$v getX" );
is( $v = Math::Vec3->new( 1, 2, 3 )->getY, "2", "$v getY" );
is( $v = Math::Vec3->new( 1, 2, 3 )->getZ, "3", "$v getZ" );

is( $v = Math::Vec3->new( 1, 2, 3 )->x, "1", "$v x" );
is( $v = Math::Vec3->new( 1, 2, 3 )->y, "2", "$v y" );
is( $v = Math::Vec3->new( 1, 2, 3 )->z, "3", "$v z" );

is( $v = new Math::Vec3( 1, 2, 3 ), "1 2 3", "$v new Math::Vec3()" );
is( $v->x = 2, "2", "$v x" );
is( $v->y = 3, "3", "$v y" );
is( $v->z = 4, "4", "$v z" );

is( $v->[0], "2", "$v [0]" );
is( $v->[1], "3", "$v [1]" );
is( $v->[2], "4", "$v [2]" );

ok( Math::Vec3->new( 1, 2, 3 ) eq "1 2 3", "$v eq" );

is( $v = new Math::Vec3( 1, 2, 3 ), "1 2 3", "$v new Math::Vec3()" );

is( $v->copy, "1 2 3", "$v copy" );

ok( $v eq new Math::Vec3( 1, 2, 3 ), "$v eq" );
ok( $v == new Math::Vec3( 1, 2, 3 ), "$v ==" );
ok( $v ne new Math::Vec3( 0, 2, 3 ), "$v ne" );
ok( $v != new Math::Vec3( 0, 2, 3 ), "$v !=" );

is( $v1 = new Math::Vec3( 1, 2, 3 ), "1 2 3", "$v1 v1" );
is( $v2 = new Math::Vec3( 2, 3, 4 ), "2 3 4", "$v2 v2" );

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

is( $v2 = $v1 * $v1,   "1 4 9",     "$v2 **" );
is( $v2 = $v2 / $v1,   "1 2 3",     "$v2 **" );

use_ok('Math::Rotation');
my $r = new Math::Rotation(2,3,4,5);
ok( $v = $r * $v1, "$v x ");

__END__
