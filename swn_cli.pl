#!/usr/bin/env perl

use strict;
use warnings;

use File::Spec;
my ($cli_volume,$cli_directory,$cli_file) = File::Spec->splitpath(__FILE__);
use lib File::Spec->catpath($cli_volume,$cli_directory,'PerlLibs');
use lib File::Spec->catpath($cli_volume,$cli_directory,'extlib/lib/perl5');
use lib File::Spec->catpath($cli_volume,$cli_directory,'perl5/lib/perl5');

use DBI;
use FindBin;
use SWNPrompt;
use SWNUtil;
use SWN2PDF;
use SWN2WIKI;

my $time = time;

print STDOUT "STARS WITHOUT NUMBER\nSector Generator\n\n";

# Set up the DB handle
my $dbh = DBI->connect("dbi:SQLite:dbname=$FindBin::Bin/swn.sqlite",'','',
		       { RaiseError => 1,
			 ReadOnly   => 1 })
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
