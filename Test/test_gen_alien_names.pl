#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../PerlLibs";

use Data::Dumper;
use SWNGen;

my $names = gen_alien_names();

print Dumper($names);

exit;
