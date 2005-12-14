# Makefile.PL -- Makefile for srep
# $Id: Makefile.PL,v 1.1 2005/12/14 15:49:53 jv Exp $
# Author          : Johan Vromans
# Created On      : Wed Dec 14 15:01:44 2005
# Last Modified By: Johan Vromans
# Last Modified On: Wed Dec 14 15:04:31 2005
# Update Count    : 3
# Status          : Stable

# Verify perl version.
require 5.6.0;

use ExtUtils::MakeMaker;

my @scripts = map { "script/$_" } qw(srep);

my $x =
WriteMakefile
  (
   NAME         => 'srep',
   AUTHOR	=> 'Johan Vromans (jvromans@squirrel.nl)',
   ABSTRACT	=> 'link identical files in source trees',
   VERSION_FROM => $scripts[0],
   PREREQ_PM	=> { 'Getopt::Long' => 2.00,
		     'File::Find' => 0 },
   EXE_FILES    => \@scripts,
   # *.pm files will be picked up automatically from ./lib
 );

sub WriteSpecfile {
    my $name    = shift;
    my $version = shift;

    my $fh;
    if ( open ($fh, "$name.spec.in") ) {
	print "Writing RPM spec file...\n";
	my $newfh;
	open ($newfh, ">$name.spec");
	while ( <$fh> ) {
	    s/%define modname \w+/%define modname $name/;
	    s/%define modversion \d+\.\d+/%define modversion $version/;
	    print $newfh $_;
	}
	close($newfh);
    }
}

WriteSpecfile($x->{NAME}, $x->{VERSION});
