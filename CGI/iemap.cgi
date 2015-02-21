#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../PerlLibs";

use CGI qw(:standard);
use Data::Dumper;
use DBI;
use Env qw(OPENSHIFT_DATA_DIR);
use SWN2WIKI;
use SWNGen;
use SWNUtil;

my $q     = CGI->new;
my $token = $q->param('token');

# Use the token to seed the random number generator
my $seed = untokenize_seed($token);
srand($seed);

# Open a DBH
my $dbh = DBI->connect("dbi:SQLite:dbname=${OPENSHIFT_DATA_DIR}swn.sqlite",'','',
  { RaiseError => 1,
    ReadOnly   => 1,
    AutoCommit => 0 })
  or die "Could not connect to DB: $!";

my ($sector_name, $star_map, $worlds) = gen_sector( dbh => $dbh, reset => 0 );

my ($map) = render_map( sector_name => $sector_name,
                        star_map    => $star_map,
                        for_ie      => 1,
                      );

print header('image/png');
print $map;

exit;
