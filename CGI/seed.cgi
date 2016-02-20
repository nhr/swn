#!/usr/bin/env perl

use strict;
use warnings;

use File::Spec;
my ($seed_volume,$seed_directory,$seed_file) = File::Spec->splitpath(__FILE__);
use lib File::Spec->catpath($seed_volume,$seed_directory,'PerlLibs');
use lib File::Spec->catpath($seed_volume,$seed_directory,'extlib/lib/perl5');
use lib File::Spec->catpath($seed_volume,$seed_directory,'perl5/lib/perl5');

use CGI qw(:standard);
use Data::Dumper;
use JSON;
use SWNUtil;

my $token = tokenize_seed(random_seed());

my $json = { entries => [$token] };
my $jtxt = to_json($json);

print header('application/json');
print $jtxt;

exit;
