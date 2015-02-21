#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../PerlLibs";

use Data::Dumper;
use DBI;
use SWNGen;

# Set up the DB handle
my $dbh = DBI->connect("dbi:SQLite:dbname=$FindBin::Bin/../swn.sqlite",'','',
		       { RaiseError => 1, AutoCommit => 0 })
    or die "Could not connect to DB: $!";

my $npcs = gen_npcs( dbh => $dbh );

print Dumper($npcs);

$dbh->disconnect();

exit;
