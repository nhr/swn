#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../PerlLibs";

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
