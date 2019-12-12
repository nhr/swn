#!/usr/bin/env perl

use strict;
use warnings;

use File::Spec;
my ($sg_volume,$sg_directory,$sg_file) = File::Spec->splitpath(__FILE__);
use lib File::Spec->catpath($sg_volume,$sg_directory,'../PerlLibs');
use lib File::Spec->catpath($sg_volume,$sg_directory,'extlib/lib/perl5');
use lib File::Spec->catpath($sg_volume,$sg_directory,'perl5/lib/perl5');

use CGI qw(:standard);
use Data::Dumper;
use DBI;
use JSON;
use SWN2WIKI;
use SWNGen;
use SWNUtil;

my $q       = CGI->new;
my $action  = $q->param('action');
my $token   = $q->param('token');
my $isie    = $q->param('isie');
my $instars = $q->param('stars');
my $to_pdf  = $q->param('pdf') || 0;

my $usemap = (defined $instars) ? from_json($instars) : [];

die "Token '$token' is invalid"
    unless defined $token and $token ne '';

# Use the token to seed the random number generator
my $seed = untokenize_seed($token);
srand($seed);

# Open a DBH
my $dbpath = File::Spec->catpath($sg_volume,$sg_directory,'../swn.sqlite');
my $dbh    = DBI->connect("dbi:SQLite:dbname=$dbpath",'','',
  { RaiseError => 1,
    ReadOnly   => 1 })
  or die "Could not connect to DB: $!";

my ($sector_name, $star_map, $worlds) = gen_sector( dbh => $dbh, reset => 0 );
my $npcs                              = gen_npcs( dbh => $dbh );
my $corps                             = gen_corps( dbh => $dbh );
my $rels                              = gen_religions( dbh => $dbh );
my $pols                              = gen_pol_parties( dbh => $dbh );
my $aliens                            = gen_aliens( dbh => $dbh, cgi => 1 );

# Use the customized star map if one was passed through.
$star_map = $usemap
    if @$usemap;

# For IE, the data URI doesn't work; don't bother sending it over the wire.
my $map;
($map) = render_map( sector_name => $sector_name,
		     star_map    => $star_map,
                    )
    unless $isie;

# Prepare some data for easier transmission.

my $sector = { name    => [$sector_name],
	       token   => $token,
	       map     => $map,
               stars   => $star_map,
             };

if ($action eq 'display') {
    my @ntbl = (['Name','M/F','Age','Height']);
    foreach my $npc (sort { $a->{sort} cmp $b->{sort} } @$npcs) {
	my $row = [ $npc->{name},
		    substr($npc->{gender}, 0, 1),
		    $npc->{age},
		    $npc->{height},
	          ];
	push @ntbl, $row;
    }

    my @ctbl = (['Company','Business']);
    foreach my $c (sort { $a->{name} cmp $b->{name} } @$corps) {
	push @ctbl, [ $c->{name}, $c->{business} ];
    }

    my @rtbl = (['Name','Leadership']);
    foreach my $r (sort { $a->{name} cmp $b->{name} } @$rels) {
	my ($l) = split '\.', $r->{leadership};
	push @rtbl, [$r->{name}, $l];
    }

    my @ptbl = (['Organization','Leadership','Policy','Outsiders','Issues']);
    foreach my $p (sort { $a->{name} cmp $b->{name} } @$pols) {
        my ($le) = split ':', $p->{leadership};
        my ($pl) = split ':', $p->{policy};
	my ($re) = split ':', $p->{relationship};
	my $row = [ $p->{name},
		    $le,
		    $pl,
		    $re,
		    $p->{issues}[0]{tag}.', '.$p->{issues}[1]{tag},
	          ];
	push @ptbl, $row;
		    
    }

    my @wtbl = (['Name','Atmo.','Temp.','Biosphere','Population','TL','Tags']);
    foreach my $w (sort { $a->{name} cmp $b->{name} } @$worlds) {
	my $row = [ $w->{name},
		    $w->{atmosphere}{short},
		    $w->{temperature}{short},
		    $w->{biosphere}{short},
		    $w->{population}{short},
		    $w->{tech_level}{short},
		    $w->{tags}[0]{short}.', '.$w->{tags}[1]{short},
	          ];
	push @wtbl, $row;
    }

    my @atbl = (['Name','Body Type','Lenses','Structure']);
    foreach my $a (sort { $a->{name} cmp $b->{name} } @$aliens) {
	my $btxt = (int @{$a->{body}} > 1) ? $a->{body}[0][0].', '.$a->{body}[1][0]
	    : $a->{body}[0][0];
	my $ltxt = $a->{lens}[0][0].', '.$a->{lens}[1][0];
	my $stxt = (int @{$a->{social}} > 1) ? 'Multiple' : $a->{social}[0][0];
	push @atbl, [$a->{name}, $btxt, $ltxt, $stxt];
    }

    $sector->{worlds} = \@wtbl;
    $sector->{npcs}   = \@ntbl;
    $sector->{corps}  = \@ctbl;
    $sector->{rels}   = \@rtbl;
    $sector->{pols}   = \@ptbl;
    $sector->{aliens} = \@atbl;

    my $jtxt = to_json($sector);
    print header('application/json');
    print $jtxt;
}
elsif ($action eq 'create') {
    $sector->{npcs}   = $npcs;
    $sector->{name}   = $sector_name;
    $sector->{map}    = $star_map;
    $sector->{worlds} = $worlds;
    $sector->{corps}  = $corps;
    $sector->{rels}   = $rels;
    $sector->{pols}   = $pols;
    $sector->{aliens} = $aliens;

    my $zipfile = generate_wiki( sector => $sector,
				 time   => time,
				 for_ie => $isie,
				 cgi    => 1,
	                       );

    print header( -type                => 'application/zip',
	          -Content_Disposition => 'attachment;filename=SWN_Generator_'.$token.'.zip',
	        );
    print $zipfile;
}

exit;
