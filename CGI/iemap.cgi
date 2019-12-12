#!/usr/bin/env perl

use strict;
use warnings;

use File::Spec;
my ($iemap_volume,$iemap_directory,$iemap_file) = File::Spec->splitpath(__FILE__);
use lib File::Spec->catpath($iemap_volume,$iemap_directory,'../PerlLibs');
use lib File::Spec->catpath($iemap_volume,$iemap_directory,'extlib/lib/perl5');
use lib File::Spec->catpath($iemap_volume,$iemap_directory,'perl5/lib/perl5');

use CGI qw(:standard);
use Data::Dumper;
use DBI;
use SWN2WIKI;
use SWNGen;
use SWNUtil;

my $q     = CGI->new;
my $token = $q->param('token');

# Use the token to seed the random number generator
my $seed = untokenize_seed($token);
srand($seed);

# Open a DBH
my $dbpath = File::Spec->catpath($iemap_volume,$iemap_directory,'../swn.sqlite');
my $dbh    = DBI->connect("dbi:SQLite:dbname=$dbpath",'','',
  { RaiseError => 1,
    ReadOnly   => 1 })
  or die "Could not connect to DB: $!";

my ($sector_name, $star_map, $worlds) = gen_sector( dbh => $dbh, reset => 0 );

my ($map) = render_map( sector_name => $sector_name,
                        star_map    => $star_map,
                        for_ie      => 1,
                      );

print header('image/png');
print $map;

exit;
