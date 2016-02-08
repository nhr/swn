#!/usr/bin/env perl

use strict;
use warnings;

use File::Spec;
my ($test_volume,$test_directory,$test_file) = File::Spec->splitpath(__FILE__);
use lib File::Spec->catpath($test_volume,$test_directory,'../PerlLibs');
use lib File::Spec->catpath($test_volume,$test_directory,'../extlib/lib/perl5');
use lib File::Spec->catpath($test_volume,$test_directory,'../perl5/lib/perl5');

use Data::Dumper;
use DBI;
use SWNGen;

# Set up the DB handle
my $dbpath = File::Spec->catpath($test_volume,$test_directory,'../swn.sqlite');
my $dbh    = DBI->connect(
  "dbi:SQLite:dbname=$dbpath",'','',
  { RaiseError => 1, AutoCommit => 0 })
  or die "Could not connect to DB: $!";

my $parties = gen_pol_parties( dbh => $dbh );

print Dumper($parties);

$dbh->disconnect();

exit;
