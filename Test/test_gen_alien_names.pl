#!/usr/bin/env perl

use strict;
use warnings;

use File::Spec;
my ($test_volume,$test_directory,$test_file) = File::Spec->splitpath(__FILE__);
use lib File::Spec->catpath($test_volume,$test_directory,'../PerlLibs');
use lib File::Spec->catpath($test_volume,$test_directory,'../extlib/lib/perl5');
use lib File::Spec->catpath($test_volume,$test_directory,'../perl5/lib/perl5');

use Data::Dumper;
use SWNGen;

my $names = gen_alien_names();

print Dumper($names);

exit;
