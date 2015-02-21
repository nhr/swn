#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/PerlLibs";

use DBI;
use SWNPrompt;
use SWNUtil;
use SWN2PDF;
use SWN2WIKI;

my $time = time;

print STDOUT "STARS WITHOUT NUMBER\nSector Generator\n\n";

# Set up the DB handle
my $dbh = DBI->connect("dbi:SQLite:dbname=$FindBin::Bin/swn.sqlite",'','',
		       { RaiseError => 1,
			 ReadOnly   => 1,
			 AutoCommit => 0 })
    or die "Could not connect to DB: $!";

# Get the user input.
my ($command, $sector) = prompt_user( dbh => $dbh );

# Close the DBH before we do anything awkward with it.
$dbh->disconnect();

# Handle the 'exit' case
if (not defined $command or $command eq 'Q') {
    print STDOUT "Exiting.\n";
    exit;
}

# Handle the non-'exit' cases
if ($command eq 'PT' or $command eq 'PO') {
    generate_pdf( sector => $sector,
		  time   => $time,
	        );
}
if ($command eq 'PT' or $command eq 'TO') {
    generate_wiki( sector => $sector,
		   time   => $time,
	         );
}

exit;
