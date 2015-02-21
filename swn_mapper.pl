#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/PerlLibs";

use DBI;
use SWNGen;
use SWNUtil;
use SWN2WIKI;

my $seed  = shift;

srand($seed);

my $token = tokenize_seed($seed);
my $fn    = '/Users/harrison/tmp/map_'.$token.'.png';

# Set up the DB handle
my $dbh = DBI->connect('dbi:SQLite:dbname=swn.sqlite','','',
		       { RaiseError => 1,
			 ReadOnly   => 1,
			 AutoCommit => 0 })
    or die "Could not connect to DB: $!";

# Generate the sector
my ($sector_name, $star_map, $worlds) = gen_sector( dbh => $dbh );
my ($img, $areas) = render_map( sector_name => $sector_name, star_map => $star_map, for_ie => 1 );

open my $fh, '>', $fn
    or die "Could not open $fn: $!";
print $fh $img;
close $fh;

exit;
