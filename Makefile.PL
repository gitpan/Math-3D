use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	'NAME' => 'Math::3D',
	#'VERSION_FROM' => 'lib/Math/Color.pm',    # finds $VERSION
	'VERSION'   => 0.1,
	'PREREQ_PM' => {
		Test::More       => 0,
		Carp             => 0,
		POSIX            => 0,
		Math::Quaternion => 0,
		Scalar::Util     => 0,
	},    # e.g., Module::Name => 1.1

	#ABSTRACT_FROM => 'lib/Math/Color.pm',
	AUTHOR   => 'Holger Seelig <holger.seelig@yahoo.de>',
	ABSTRACT => 'Contains some vector math',

);

__END__

#mk install
perl Makefile.PL
sudo make clean
sudo cpan .
sudo make clean
sudo rm Makefile.old

#mk dist
perl Makefile.PL
make test
make manifest
make dist
mv *.gz ../
make clean
