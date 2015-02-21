package SWNPrompt;
use strict;

BEGIN {
    our $VERSION   = 1.00;
    our @ISA       = qw(Exporter);
    our @EXPORT    = qw(prompt_user);
    our @EXPORT_OK = qw();
    require Exporter;
}

use SWNGen;
use SWNUtil;
use Term::Prompt;

my %CMD_MAP = ( 1 => 'PT',
		2 => 'PO',
		3 => 'TO',
		5 => 'Q',
              );

sub prompt_user {
    my %args = @_;
    my $dbh  = $args{dbh};

    my $rerolling = 0;
    my $token     = undef;
    while (1) {
	$token = uc(prompt('x', 'Enter a seed or hit [enter] to generate one:', '', ' generate'))
	    unless $rerolling;

	my $seed;
	if ($token ne ' GENERATE') {
	    my $ok_go = 0;
	    while (not $ok_go) {
		if ($token !~ /^[0-9A-Z]+$/ or untokenize_seed($token) > 2**32) {
		    $token = uc(prompt('x', "Seed value '$token' is invalid. Please re-enter:", '', ''));
		}
		$ok_go = prompt('y', "You entered '$token'. Is this correct?", '', 'y');
		$token = uc(prompt('x', 'Re-enter the seed:', '', ''))
		    unless $ok_go;
	    }
	
	    $seed = untokenize_seed($token);
	}
	else {
	    $seed  = random_seed();
	    $token = tokenize_seed($seed);
	}

	# Seed our random number generator.
	srand($seed);

	# Generate the sector.
	print STDOUT "Generating sector.\n";
	my ($sector_name, $star_map, $worlds) =
	    gen_sector( dbh => $dbh, reset => $rerolling );
	my $npcs                              =
	    gen_npcs( dbh => $dbh );
	my $corps                             =
	    gen_corps( dbh => $dbh );
	my $rels                              =
	    gen_religions( dbh => $dbh );
	my $pols                              =
	    gen_pol_parties( dbh => $dbh );
	my $aliens                            =
	    gen_aliens( dbh => $dbh );

	my %SECTOR = ( name   => $sector_name,
		       token  => $token,
		       map    => $star_map,
		       worlds => $worlds,
		       npcs   => $npcs,
		       corps  => $corps,
		       rels   => $rels,
		       pols   => $pols,
		       aliens => $aliens,
	             );

	# Prepare terminal-based sector summary.
	my $star_count  = int @$star_map;
	my $world_count = int @$worlds;

	my @list_data   = (["STARS ($star_count):","WORLDS ($world_count):"]);
	my @star_names  = map { $_->{name} } sort { $a->{name} cmp $b->{name} } @$star_map;
	my @world_names = map { $_->{name} } sort { $a->{name} cmp $b->{name} } @$worlds;
	for (my $i = 0; $i < @world_names; $i++) {
	    my $sval = defined $star_names[$i] ? $star_names[$i] : '';
	    my $l    = [$sval,$world_names[$i]];
	    push @list_data, $l;
	}

	# Display the sector summary.
	print STDOUT "\nSECTOR: $sector_name\n\n";
	foreach my $row (@list_data) {
	    my $count = length $row->[0];
	    my $pad   = 30 - $count;
	    my $str   = $row->[0].(' ' x $pad).$row->[1];
	    print STDOUT $str."\n";
	}
	print STDOUT "\n";

	# Find out what the user wants to do.
	my $cmd = prompt('m',
			 { prompt => 'How would you like to continue?',
			   title  => 'Generator Options',
			   items  => [ 'PDF & TiddlyWiki', 'PDF Only', 'TiddlyWiki Only', 'Reroll', 'Quit'],
			   order  => 'down',
			   rows   => 3,
			   cols   => 2,
			   return_base            => 1,
			   accept_empty_selection => 0,
			 },
			 '',
			 2
	                );

	if ($cmd == 4) {
	    $rerolling = 1;
	    $token     = ' GENERATE';
	}
	else {
	    return ($CMD_MAP{$cmd}, \%SECTOR);
	}
    }
}

1;
