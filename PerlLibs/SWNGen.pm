package SWNGen;
use strict;

BEGIN {
    our $VERSION   = 1.00;
    our @ISA       = qw(Exporter);
    our @EXPORT    = qw(gen_sector gen_npcs gen_corps gen_religions gen_pol_parties gen_rooms gen_architectures
                        gen_aliens gen_alien_names);
    our @EXPORT_OK = qw();
    require Exporter;
}

use LC;
use SWNUtil;

use Data::Dumper;

use Data::RandomPerson::Names::AncientGreekFemale;
use Data::RandomPerson::Names::AncientGreekMale;
use Data::RandomPerson::Names::ArabicFemale;
use Data::RandomPerson::Names::ArabicLast;
use Data::RandomPerson::Names::ArabicMale;
use Data::RandomPerson::Names::BasqueFemale;
use Data::RandomPerson::Names::BasqueMale;
use Data::RandomPerson::Names::CelticFemale;
use Data::RandomPerson::Names::CelticMale;
use Data::RandomPerson::Names::EnglishFemale;
use Data::RandomPerson::Names::EnglishLast;
use Data::RandomPerson::Names::EnglishMale;
use Data::RandomPerson::Names::Female;
use Data::RandomPerson::Names::HindiFemale;
use Data::RandomPerson::Names::HindiMale;
use Data::RandomPerson::Names::JapaneseFemale;
use Data::RandomPerson::Names::JapaneseMale;
use Data::RandomPerson::Names::Last;
use Data::RandomPerson::Names::LatvianFemale;
use Data::RandomPerson::Names::LatvianMale;
use Data::RandomPerson::Names::Male;
use Data::RandomPerson::Names::ModernGreekFemale;
use Data::RandomPerson::Names::ModernGreekLast;
use Data::RandomPerson::Names::ModernGreekMale;
use Data::RandomPerson::Names::SpanishFemale;
use Data::RandomPerson::Names::SpanishLast;
use Data::RandomPerson::Names::SpanishMale;
use Data::RandomPerson::Names::ThaiFemale;
use Data::RandomPerson::Names::ThaiMale;
use Data::RandomPerson::Names::VikingFemale;
use Data::RandomPerson::Names::VikingMale;

use constant MAX_WORLDS => 36;

# gen_sector
# Does all of the up-front dice rolling.
# Returns a star map and a world list.
sub gen_sector {
    my %args  = @_;
    my $dbh   = $args{dbh};
    my $reset = $args{reset};

    # Clear out our tracking structures if this
    # is a respin.
    if ($reset) {
	_check_name( reset => 1 );
	_gen_world_tag( reset => 1 );
	gen_religions( reset => 1);
	_gen_heresy( reset => 1 );
	_gen_pol_party( reset => 1 );
	_gen_arch( reset => 1 );
    }

    # First figure out how many stars.
    my $star_count = _d(10) + 20;

    # Pick a sector name.
    my $sector_name = _pick_sector_name();

    # Set up the star map and world list.
    my @star_map   = ();
    my %seen_cells = ();
    my @worlds     = ();

    my $current_stars = 0;

    # Place each star and generate one or more
    # worlds to go around each,
    for (my $i = 0; $i < $star_count; $i++) {
	my ($row, $col, $cell);

      STAR_ROLL:
	while (1) {
	    # Roll up a hex grid location.
	    $row  = _d(10) - 1;
	    $col  = _d(8)  - 1;
	    $cell = cell_id( col => $col, row => $row );

	    # Try again if there is already a star here.
	    next STAR_ROLL
		if exists $seen_cells{$cell};

	    # We're good. Move along.
	    last STAR_ROLL;
	}

	$seen_cells{$cell} = 1;

	# Good star location. Pick a name.
	$current_stars  += 1;
	my $star_name    = _pick_name();

	# Now roll for 1-3 worlds
	my $world_count = _d_world_count();

	# Prevent the number of worlds from exceeding MAX_WORLDS
	my $remaining_stars  = $star_count - $current_stars;
	my $remaining_worlds = MAX_WORLDS  - int @worlds;
	$world_count = 1
	    if $remaining_worlds - $world_count < $remaining_stars;

	push @star_map, { name  => $star_name,
			  count => $world_count,
			  cell  => $cell,
			  id    => $i,
	                };

	# Pick some Roman numerals to imply
	# world position within the system.
	my @world_nums  = _world_nums($world_count);
	
	# Now generate the worlds.
	for (my $j = 0; $j < $world_count; $j++) {
	    my $world           = _gen_world( dbh => $dbh );
	    my $pos             = $j + 1;
	    $world->{sys_count} = $world_count;
	    $world->{sys_pos}   = $pos;
	    $world->{sys_name}  = $star_name.' '.$world_nums[$j];
	    $world->{sys_num}   = $world_nums[$j];
            $world->{star_id}   = $i;
	    push @worlds, $world;
	}
    }

    return ($sector_name, \@star_map, \@worlds);
}

# Make up the NPCs
BEGIN {
    my $gstmt = 'SELECT gender  FROM NPC_GENDER     where id = ?';
    my $astmt = 'SELECT age     FROM NPC_AGE        where id = ?';
    my $hstmt = 'SELECT height  FROM NPC_HEIGHT     where id = ?';
    my $pstmt = 'SELECT problem FROM NPC_PROBLEMS   where id = ?';
    my $mstmt = 'SELECT motive  FROM NPC_MOTIVATION where id = ?';
    my $qstmt = 'SELECT quirk   FROM NPC_QUIRKS     where id = ?';
sub gen_npcs {
    my %args = @_;
    my $dbh  = $args{dbh};
    my $max  = $args{max} || 100;

    my $gsth = $dbh->prepare($gstmt);
    my $asth = $dbh->prepare($astmt);
    my $hsth = $dbh->prepare($hstmt);
    my $psth = $dbh->prepare($pstmt);
    my $msth = $dbh->prepare($mstmt);
    my $qsth = $dbh->prepare($qstmt);

    my @npcs = ();
    for (my $i = 0; $i < $max; $i++) {
	# Roll the dice
	my $gr = _d(4);
	my $ar = _d(6);
	my $hr = _d(8);
	my $pr = _d(10);
	my $mr = _d(12);
	my $qr = _d(20);

	# Get the info
	$gsth->execute($gr);
	my ($gender)  = $gsth->fetchrow_array();
	$gsth->finish();
	$asth->execute($ar);
	my ($age)     = $asth->fetchrow_array();
	$asth->finish();
	$hsth->execute($hr);
	my ($height)  = $hsth->fetchrow_array();
	$hsth->finish();
	$psth->execute($pr);
	my ($problem) = $psth->fetchrow_array();
	$psth->finish();
	$msth->execute($mr);
	my ($motive)  = $msth->fetchrow_array();
	$msth->finish();
	$qsth->execute($qr);
	my ($quirk)   = $qsth->fetchrow_array();
	$qsth->finish();

	if ($quirk =~ /^male:(.+),female:(.+)$/) {
	    $quirk = ($gender eq 'male') ? $1 : $2;
	}

	# Cook up a name
	my $name = _pick_name( type => $gender );

	my ($fn, $ln) = split ' ', $name;

	# Store the NPC
	push @npcs, { name    => $name,
		      sort    => $ln.' '.$fn,
		      gender  => ucfirst($gender),
		      age     => $age,
		      height  => $height,
		      problem => $problem,
		      motive  => $motive,
		      quirk   => $quirk,
	            };
    }
    return \@npcs;
}
}

BEGIN {
    my $nstmt = 'SELECT name         FROM QUICK_CORP_NAME       where id = ?';
    my $ostmt = 'SELECT organization FROM QUICK_CORP_NAME       where id = ?';
    my $bstmt = 'SELECT business     FROM QUICK_CORP_BUSINESS   where id = ?';
    my $rstmt = 'SELECT reputation   FROM QUICK_CORP_REPUTATION where id = ?';
sub gen_corps {
    my %args = @_;
    my $dbh  = $args{dbh};
    my $max  = $args{max} || 50;

    my $nsth = $dbh->prepare($nstmt);
    my $osth = $dbh->prepare($ostmt);    
    my $bsth = $dbh->prepare($bstmt);
    my $rsth = $dbh->prepare($rstmt);

    my @corps = ();

    for (my $i = 0; $i < $max; $i++) {
	# 1/3 of the time, use a DB-provided name.
	my $name_source = _d(3);
	my $name = '';

	if ($name_source == 1) {
	    do {
		my $roll = _d(25);
		$nsth->execute($roll);
		($name) = $nsth->fetchrow_array();
	    }
	    while (_check_name( name => $name, type => 'corp' ) == 0);
	}
	else {
	    $name = _pick_name( type => 'corp' );
	}

	$osth->execute(_d(25));
	my ($org) = $osth->fetchrow_array();

	$bsth->execute(_d(100));
	my ($biz) = $bsth->fetchrow_array();

	$rsth->execute(_d(100));
	my ($rep) = $rsth->fetchrow_array();

	push @corps, { name       => $name.' '.$org,
		       business   => $biz,
		       reputation => $rep,
	             };
    }
    return \@corps;
}
}

BEGIN {
    my $ostmt = 'SELECT origin, name, adj    FROM QUICK_RELIGION_ORIGIN     where id = ?';
    my $lstmt = 'SELECT leadership           FROM QUICK_RELIGION_LEADERSHIP where id = ?';
    my $estmt = 'SELECT evolution, adjective FROM QUICK_RELIGION_EVOLUTION  where id = ?';

    my %REL_COMBOS = ();
sub gen_religions {
    my %args  = @_;
    my $dbh   = $args{dbh};
    my $max   = $args{max} || 24;
    my $reset = $args{reset};

    if ($reset) {
	%REL_COMBOS = ();
	return;
    }

    my $osth = $dbh->prepare($ostmt);
    my $lsth = $dbh->prepare($lstmt);
    my $esth = $dbh->prepare($estmt);
    
    my @rels = ();
    for (my $i = 0; $i < $max; $i++) {
	my ($oroll1, $oroll2, $lroll, $eroll);
	my $token = '';
	do {
	    $oroll1 = _d(12);
	    $lroll  = _d(6);
	    $eroll  = _d(8);
	    $token  = join ':', $oroll1, $eroll;
	}
	while (exists $REL_COMBOS{$token});

	$REL_COMBOS{$token} = 1;

	$osth->execute($oroll1);
	my ($origin, $oname, $oadj) = $osth->fetchrow_array();
	$lsth->execute($lroll);
	my ($leadership) = $lsth->fetchrow_array();
	$esth->execute($eroll);
	my ($evolution, $adjective) = $esth->fetchrow_array();

	# Build up the name.
	my $rname = $adjective;

	# Handle Syncretism
	if ($eroll == 3) {
	    do {
		$oroll2 = _d(12);
	    }
	    while ($oroll2 == $oroll1);

	    $osth->execute($oroll2);
	    my ($origin2, $oname2, $oadj2) = $osth->fetchrow_array();

	    $rname .= ' '.$oadj2.' '.$oname;
	}
	else {
	    $rname .= ' '.$oname;
	}

	# Handle Leadership
	if ($lroll == 6) {
	    my $lroll2 = _d(6);
	    if ($lroll2 == 6) {
		$leadership = 'No universal leadership. This faith has no hierarchy.';
	    }
	    else {
		$leadership = 'No universal leadership. Each region governs itself differently.';
	    }
	}

	# 1 to 3 heretical offshoots
	my $hroll = _d(6);
	my $hmax  = 1;
	if ($hroll == 6) {
	    $hmax = 3;
	}
	elsif ($hroll == 5) {
	    $hmax = 2;
	}

	my $heresies = _gen_heresies( dbh => $dbh, max => $hmax, origin => $oroll1 );

	push @rels, { name       => $rname,
		      origin     => $origin,
		      leadership => $leadership,
		      evolution  => $evolution,
		      offshoots  => $heresies,
	            };
    }

    return \@rels;
}
}

sub _gen_heresies {
    my %args   = @_;
    my $dbh    = $args{dbh};
    my $max    = $args{max} || 12;
    my $origin = $args{origin};

    my @heresies = ();
    for (my $i = 0; $i < $max; $i++) {
	push @heresies, _gen_heresy( dbh => $dbh, origin => $origin );
    }
    return \@heresies;
}

BEGIN {
    my $astmt = 'SELECT attitude, adjective FROM QUICK_HERESY_ATTITUDE where id = ?';
    my $fstmt = 'SELECT founder             FROM QUICK_HERESY_FOUNDER  where id = ?';
    my $hstmt = 'SELECT heresy, name        FROM QUICK_HERESY_HERESY   where id = ?';
    my $qstmt = 'SELECT quirk               FROM QUICK_HERESY_QUIRK    where id = ?';
    my $ostmt = 'SELECT origin              FROM QUICK_RELIGION_ORIGIN where id = ?';

    my %HERESY_COMBOS = ();
sub _gen_heresy {
    my %args   = @_;
    my $dbh    = $args{dbh};
    my $origin = $args{origin};
    my $reset  = $args{reset};

    if ($reset) {
	%HERESY_COMBOS = ();
	return;
    }

    my $asth = $dbh->prepare($astmt);
    my $fsth = $dbh->prepare($fstmt);
    my $hsth = $dbh->prepare($hstmt);
    my $qsth = $dbh->prepare($qstmt);
    my $osth = $dbh->prepare($ostmt);

    my ($aroll, $froll, $hroll, $qroll, $token);
    do {
	$aroll = _d(10);
	$froll = _d(8);
	$hroll = _d(12);
	$qroll = _d(20);
	$token = join ':', $aroll, $hroll;
    }
    while (exists $HERESY_COMBOS{$token});

    # Handle syncretic heresies
    my $sorigin = '';
    if ($hroll == 10) {
	my $sroll;
	do {
	    $sroll = _d(12);
	}
	while ($sroll == $origin);

	$osth->execute($sroll);
	($sorigin) = $osth->fetchrow_array();
    }

    $HERESY_COMBOS{$token} = 1;

    $asth->execute($aroll);
    my ($attitude, $adjective) = $asth->fetchrow_array();
    $fsth->execute($aroll);
    my ($founder)  = $fsth->fetchrow_array();
    $hsth->execute($hroll);
    my ($heresy, $name)   = $hsth->fetchrow_array();
    $qsth->execute($qroll);
    my ($quirk)    = $qsth->fetchrow_array();

    $heresy =~ s/\$\$RELIGION/$sorigin/
	if $hroll == 10;

    return { name     => $adjective.' '.$name,
	     attitude => $attitude,
	     founder  => $founder,
	     heresy   => $heresy,
	     quirk    => $quirk,
           };
}
}

sub gen_pol_parties {
    my %args   = @_;
    my $dbh    = $args{dbh};
    my $max    = $args{max} || 24;

    my @parties = ();
    for (my $i = 0; $i < $max; $i++) {
	push @parties, _gen_pol_party( dbh => $dbh );
    }
    return \@parties;
}

BEGIN {
    my $istmt  = 'SELECT issue, tag   FROM QUICK_POLITICAL_ISSUES     where id = ?';
    my $lstmt  = 'SELECT leadership   FROM QUICK_POLITICAL_LEADERSHIP where id = ?';
    my $nstmt1 = 'SELECT element1     FROM QUICK_POLITICAL_NAME       where id = ?';
    my $nstmt2 = 'SELECT element2     FROM QUICK_POLITICAL_NAME       where id = ?';
    my $ostmt  = 'SELECT relationship FROM QUICK_POLITICAL_OUTSIDERS  where id = ?';
    my $pstmt  = 'SELECT policy       FROM QUICK_POLITICAL_POLICY     where id = ?';

    my @COLOR     = qw(Black Yellow Red Blue White Green Charteuse Violet Brown Crimson
                       Amber Indigo Azure Carnelian Cerulean Emerald Lavender Ivory
                       Jade Onyx Tyrian Vermilion Viridian);
    my @ANIMAL    = qw(Alligator Fire-Ant Bison Armadillo Badger Barracuda Bear Boar
                       Buffalo Caribou Stag Cheetah Rooster Cobra Cormorant Coyote
                       Crab Crane Crow Deer Dolphin Dove Dragonfly Eagle Wapiti Falcon
                       Ferret Finch Fox Gazelle Panda Giraffe Goat Gorilla Gull Hawk
                       Heron Hornet Thoroughbred Human Iguana Jackal Jaguar Kangaroo
                       Koala Komodo Leopard Lion Locust Mallard Manatee Meerkat Moose
                       Nightingale Ostrich Otter Owl Ox Oyster Panther Pelican Penguin
                       Pigeon Platypus Porcupine Ram Raven Salamander Sea-Lion Seahorse
                       Shark Snake Spider Swan Tiger Tortoise Walrus Wasp Wolf);
    my @DIRECTION = qw(North South East West Turnwise Widdershins Northeast Northwest
                       Southeast Southwest Outer Inner Higher Lower);
    my @METAL     = qw(Lithium Magnesium Aluminum Titanium Chromium Iron Cobalt Copper
                       Palladium Silver Iridium Platinum Gold Mercury Cerium Neodymium
                       Uranium Plutonium Steel Bronze);

    my %lists   = ( direction => \@DIRECTION,
		    animal    => \@ANIMAL,
		    color     => \@COLOR,
		    metal     => \@METAL,
                  );

    my %managed = ( 11 => 'color',
		    14 => 'animal',
		    17 => 'direction',
		    20 => 'metal',
                  );

    my %POL_COMBOS = ();
    my %ISS_COMBOS = ();
    my %SEEN_ELEMS = ( animal    => {},
		       color     => {},
		       direction => {},
		       metal     => {},
                     );
sub _gen_pol_party {
    my %args  = @_;
    my $dbh   = $args{dbh};
    my $reset = $args{reset};

    if ($reset) {
	%POL_COMBOS = ();
	%ISS_COMBOS = ();
	foreach my $key (keys %SEEN_ELEMS) {
	    $SEEN_ELEMS{$key} = {};
	}
	return;
    }

    my $isth  = $dbh->prepare($istmt);
    my $lsth  = $dbh->prepare($lstmt);
    my $nsth1 = $dbh->prepare($nstmt1);
    my $nsth2 = $dbh->prepare($nstmt2);
    my $osth  = $dbh->prepare($ostmt);
    my $psth  = $dbh->prepare($pstmt);

    my ($iroll1, $iroll2, $lroll, $nroll1, $nroll2, $oroll, $proll, $token);
    my $idx = 0;
    do {
	$lroll  = _d(8);
	$nroll1 = _d(20);
	$nroll2 = _d(20);
	$oroll  = _d(4);
	$proll  = _d(6);
	# Colors, animals, directions and metals are managed
	# differently. Add an idx number to those results so they
	# are always unique.
	$token = $nroll1;
	$token .= $idx++
	    if exists $managed{$nroll1};
    }
    while (exists $POL_COMBOS{$token});

    $POL_COMBOS{$token} = 1;

    my $itok;
    do {
 	$iroll1 = _d(12);
	do {
	    $iroll2 = _d(12);
	}
	while $iroll2 == $iroll1;

	if ($iroll1 > $iroll2) {
	    $itok = $iroll2.':'.$iroll1;
	}
	else {
	    $itok = $iroll1.':'.$iroll2;
	}
    }
    while (exists $ISS_COMBOS{$itok});

    $ISS_COMBOS{$itok} = 1;

    my $name = '';
    if (exists $managed{$nroll1}) {
	my $lkey = $managed{$nroll1};
	my $list = $lists{$lkey};
	my $llen = int @$list;
	my $roll;
	do {
	    $roll = _d($llen);
	}
	while (exists $SEEN_ELEMS{$lkey}{$roll});

	$SEEN_ELEMS{$lkey}{$roll} = 1;

	$name = $list->[($roll - 1)];
    }
    else {
	$nsth1->execute($nroll1);
	($name) = $nsth1->fetchrow_array();
    }

    $nsth2->execute($nroll2);
    my ($name2) = $nsth2->fetchrow_array();

    $name .= ' '.$name2;

    $isth->execute($iroll1);
    my ($issue1, $itag1) = $isth->fetchrow_array();

    $isth->execute($iroll2);
    my ($issue2, $itag2) = $isth->fetchrow_array();

    $lsth->execute($lroll);
    my ($leadership) = $lsth->fetchrow_array();

    $osth->execute($oroll);
    my ($relationship) = $osth->fetchrow_array();

    $psth->execute($proll);
    my ($policy) = $psth->fetchrow_array();

    return { name         => $name,
	     issues       => [{ issue => $issue1,
				tag   => $itag1,
			      },
			      { issue => $issue2,
				tag   => $itag2,
			      },
		             ],
	     leadership   => $leadership,
	     relationship => $relationship,
	     policy       => $policy,
           };
}
}

sub gen_rooms {
    my %args = @_;
    my $dbh  = $args{dbh};
}

sub gen_architectures {
    my %args   = @_;
    my $dbh    = $args{dbh};
    my $max    = $args{max} || 24;

    my @arches = ();
    for (my $i = 0; $i < $max; $i++) {
	push @arches, _gen_arch( dbh => $dbh, arch_idx => $i + 1 );
    }
    return \@arches;
}

BEGIN {
    my $estmt     = 'SELECT element FROM QUICK_ARCHITECTURE WHERE id = ?';
    my %SEEN_ARCH = ();
sub _gen_arch {
    my %args  = @_;
    my $dbh   = $args{dbh};
    my $idx   = $args{arch_idx};
    my $reset = $args{reset};

    if ($reset) {
	%SEEN_ARCH = ();
	return;
    }

    my $esth = $dbh->prepare($estmt);

    my ($troll, $froll, $wroll, $sroll, $aroll, $eroll, $token);
    do {
	$troll = _arch_id(1, _d(10));
	$froll = _arch_id(2, _d(10));
	$wroll = _arch_id(3, _d(10));
	$sroll = _arch_id(4, _d(10));
	$aroll = _arch_id(5, _d(10));
	$eroll = _arch_id(6, _d(10));
	$token = join ':', $troll, $froll, $wroll, $sroll, $aroll, $eroll;
    }
    while (exists $SEEN_ARCH{$token});

    $SEEN_ARCH{$token} = 1;

    $esth->execute($troll);
    my ($towers)      = $esth->fetchrow_array();
    $esth->execute($froll);
    my ($foundations) = $esth->fetchrow_array();
    $esth->execute($wroll);
    my ($wall_decor)  = $esth->fetchrow_array();
    $esth->execute($sroll);
    my ($supports)    = $esth->fetchrow_array();
    $esth->execute($aroll);
    my ($arches)      = $esth->fetchrow_array();
    $esth->execute($eroll);
    my ($extras)      = $esth->fetchrow_array();

    return { name        => "Architecture $idx",
	     towers      => $towers,
	     foundations => $foundations,
	     wall_decor  => $wall_decor,
	     supports    => $supports,
	     arches      => $arches,
	     extras      => $extras,
           };
}
}

sub _arch_id {
    my ($idx, $roll) = @_;

    return $idx.($roll < 10 ? '0'.$roll : $roll);
}

sub gen_aliens {
    my %args   = @_;
    my $dbh    = $args{dbh};
    my $max    = $args{max} || 10;

    my @aliens = ();
    for (my $i = 0; $i < $max; $i++) {
	push @aliens, _gen_alien( dbh => $dbh );
    }
    return \@aliens;
}

BEGIN {
    my $bstmt = 'SELECT name, desc FROM ALIEN_BODY_TYPE WHERE id = ?';
    my $lstmt = 'SELECT name, desc FROM ALIEN_LENSES    WHERE id = ?';
    my $sstmt = 'SELECT name, desc FROM ALIEN_STRUCTURE WHERE id = ?';

    my %VARS = ( 'Humanlike' => 'ALIEN_VAR_MAMMAL',
		 'Avian'     => 'ALIEN_VAR_AVIAN',
		 'Reptilian' => 'ALIEN_VAR_REPTILE',
		 'Insectile' => 'ALIEN_VAR_INSECT',
		 'Exotic'    => 'ALIEN_VAR_EXOTIC',
	       );

    my %SEEN_ALIENS = ();
sub _gen_alien {
    my %args  = @_;
    my $dbh   = $args{dbh};
    my $reset = $args{reset};

    if ($reset) {
	%SEEN_ALIENS = ();
	return;
    }
    
    my $bsth = $dbh->prepare($bstmt);
    my $lsth = $dbh->prepare($lstmt);
    my $ssth = $dbh->prepare($sstmt);

    my ($broll1, $broll2, $lroll1, $lroll2, $sroll, $token);
    my $hybrid = 0;
    do {
	$broll1 = _d(6);
	if ($broll1 == 6) {
	    $hybrid = 1;
	    $broll1 = _d(5);
	    do {
		$broll2 = _d(5)
	    }
	    while ($broll2 == $broll1);
	}
	else {
	    $broll2 = 0;
	}

	$lroll1 = _d(20);
	do {
	    $lroll2 = _d(20);
	}
	while $lroll2 == $lroll1;
	$sroll = _d(6);
	my $stok = ($sroll == 6) ? 5 : $sroll;
	$token = join ':', $broll1, $broll2, $lroll1, $lroll2, $stok;
    }
    while (exists $SEEN_ALIENS{$token});
    
    $SEEN_ALIENS{$token} = 1;

    my @social  = ();
    my $tot_soc = ($sroll > 4) ? (1 + _d(3)) : 1;
    for (my $i = 0; $i < $tot_soc; $i++) {
	my $roll = ($sroll > 4) ? _d(4) : $sroll;
	$ssth->execute($roll);
	my ($ts, $td) = $ssth->fetchrow_array();
	push @social, [$ts, $td];
    }

    my @body = ();
    my @vars = ();
    $bsth->execute($broll1);
    my ($body1, $bdesc1) = $bsth->fetchrow_array();
    push @body, [ $body1, $bdesc1 ];

    my $vroll1 = _d(20);
    my $vroll2;
    my $vsth   = $dbh->prepare('SELECT variation FROM '.$VARS{$body1}.' WHERE id = ?');
    $vsth->execute($vroll1);
    my ($var1) = $vsth->fetchrow_array();
    push @vars, _roll_var($var1);

    if ($hybrid) {
	$bsth->execute($broll2);
	my ($body2, $bdesc2) = $bsth->fetchrow_array();
	push @body, [ $body2, $bdesc2 ];

	$vroll2 = _d(20);
	$vsth = $dbh->prepare('SELECT variation FROM '.$VARS{$body2}.' WHERE id = ?');
	$vsth->execute($vroll2);
	my ($var2) = $vsth->fetchrow_array();
	push @vars, _roll_var($var2);
    }
    else {
	do {
	    $vroll2 = _d(20)
	}
	while ($vroll2 == $vroll1);
	$vsth->execute($vroll2);
	my ($var2) = $vsth->fetchrow_array();
	push @vars, _roll_var($var2);
    }

    $lsth->execute($lroll1);
    my ($lens1, $ldesc1) = $lsth->fetchrow_array();
    $lsth->execute($lroll2);
    my ($lens2, $ldesc2) = $lsth->fetchrow_array();

    my $name = _gen_alien_name();

    return { name   => $name,
	     body   => \@body,
	     lens   => [ [ $lens1, $ldesc1 ],
			 [ $lens2, $ldesc2 ],
		       ],
	     vars   => \@vars,
	     social => \@social,
	     arch   => _gen_arch( dbh => $dbh, arch_idx => 1 ),
           };
}
}

sub _roll_var {
    my $txt   = shift;
    my $d3    = _d(3);
    my $d4    = _d(4);
    my $d4x2  = _d('4x2');
    my $d10x2 = _d('10x2');
    my $d6p1  = _d('6p1');
    $txt =~ s/\$\$1D3/$d3/;
    $txt =~ s/\$\$1D4/$d4/;
    $txt =~ s/\$\$2D4/$d4x2/;
    $txt =~ s/\$\$2D10/$d10x2/;
    $txt =~ s/\$\$1D6P1/$d6p1/;
    return $txt;
}

sub gen_alien_names {
    my %args = @_;
    my $max  = $args{max} | 100;

    my @names = ();
    for (my $i = 0; $i < $max; $i++) {
	push @names, _gen_alien_name();
    }
    return \@names;
}

BEGIN {
    my @LISTS = qw(barsoomian glorantha jorune klingon lovecraftian sindarin tsolyani);
    my %NAMES = ();
    my %SEEN  = ();
sub _gen_alien_name {
    my $count = int @LISTS;
    my $list  = $LISTS[int(rand($count))];

    unless (exists $NAMES{$list}) {
	my $nl = conflux( file => $list, number => 100 );
	$NAMES{$list} = $nl;
	$SEEN{$list}  = {}
	    unless exists $SEEN{$list};
    }

    my $this_list = $NAMES{$list};
    my $list_len  = int @$this_list;
    my $this_idx;
    do {
	$this_idx = int(rand($list_len));
    }
    while exists $SEEN{$list}{$this_idx};

    $SEEN{$list}{$this_idx} = 1;

    return ucfirst $this_list->[$this_idx];
}
}

sub _gen_world {
    my %args = @_;
    my $dbh  = $args{dbh};

    # Roll up a world.
    my $world = { name        => _pick_name(),
	          atmosphere  => _gen_world_component( dbh => $dbh, type => 'atmosphere'  ),
		  biosphere   => _gen_world_component( dbh => $dbh, type => 'biosphere'   ),
		  population  => _gen_world_component( dbh => $dbh, type => 'population'  ),
		  tech_level  => _gen_world_component( dbh => $dbh, type => 'tech_level'  ),
		  temperature => _gen_world_component( dbh => $dbh, type => 'temperature' ),
		  tags        => [],
                };

    my $tag1 = _gen_world_tag( dbh => $dbh );
    my $tag2 = _gen_world_tag( dbh => $dbh, skip => $tag1->{roll} );
    push @{$world->{tags}}, $tag1, $tag2;

    return $world;
}

BEGIN {
    my %WORLD_TABLE = ( atmosphere  => 'WORLD_ATMOSPHERE',
			biosphere   => 'WORLD_BIOSPHERE',
			population  => 'WORLD_POPULATION',
			tech_level  => 'WORLD_TECH_LEVEL',
			temperature => 'WORLD_TEMPERATURE',
	              );
sub _gen_world_component {
    my %args = @_;
    my $dbh  = $args{dbh};
    my $type = $args{type};
    
    my $roll = _d('6x2');
    my $sth  = $dbh->prepare(qq(SELECT name, desc, short
                                  FROM $WORLD_TABLE{$type}
                                 WHERE id = ?
                               ));

    $sth->execute($roll);
    my ($name, $desc, $short) = $sth->fetchrow_array();
    $sth->finish;

    return { roll => $roll, name => $name, desc => $desc, short => $short };
}
}

BEGIN {
    my @TAG_IDS = ();
    my @USED    = ();
    for (my $d6 = 1; $d6 < 7; $d6++) {
	for (my $d10 = 1; $d10 < 11; $d10++) {
	    push @TAG_IDS, $d6.(length $d10 == 1 ? '0' : '').$d10;
	    push @USED, 0;
	}
    }
    my $TOT_TAGS = int @TAG_IDS;
    my $TOT_USED = 0;

sub _gen_world_tag {
    my %args  = @_;
    my $dbh   = $args{dbh};
    my $skip  = $args{skip};
    my $reset = $args{reset};

    # We've used up all of the tags. Reset everything.
    if ($reset or $TOT_USED >= $TOT_TAGS) {
	for (my $i = 0; $i < $TOT_TAGS; $i++) {
	    $USED[$i] = 0;
	}
	$TOT_USED  = 0;
	
	return
	    if $reset;
    }

    # We want to use up all unique tags before repeating.
    my $idx      = int(rand($TOT_TAGS));
    my $skip_idx = undef;

    # We don't want the second world tag to match the first
    if (defined $skip) {
      TAG:
	for (my $i = 0; $i < @TAG_IDS; $i++) {
	    next TAG
		unless $TAG_IDS[$i] == $skip;

	    $skip_idx = $i;

	    last TAG;
	}
    }

  POS:
    while ($USED[$idx] or (defined $skip_idx and $idx == $skip_idx)) {
	if ($idx < $TOT_TAGS - 1) {
	    $idx++;
	}
	else {
	    $idx = 0;
	}
    }

    # Mark off this tag.
    $USED[$idx] = 1;
    $TOT_USED  += 1;

    my $id = $TAG_IDS[$idx];

    my $sth = $dbh->prepare(qq(SELECT name, desc, enemies, friends, complications, things, places, short
                                 FROM WORLD_TAG
                                WHERE id = ?
                              ));

    $sth->execute($id);
    my ($name, $desc, $enemies, $friends, $complications, $things, $places, $short) = $sth->fetchrow_array();
    $sth->finish;

    return { roll          => $id,
	     name          => $name,
	     desc          => $desc,
	     enemies       => $enemies,
	     friends       => $friends,
	     complications => $complications,
	     things        => $things,
	     places        => $places,
	     short         => (defined $short ? $short : $name),
           };
}
}

BEGIN {
    my @COSMIC = ( Data::RandomPerson::Names::AncientGreekFemale->new(),
		   Data::RandomPerson::Names::AncientGreekMale->new(),
		   Data::RandomPerson::Names::ArabicFemale->new(),
		   Data::RandomPerson::Names::ArabicLast->new(),
		   Data::RandomPerson::Names::BasqueFemale->new(),
		   Data::RandomPerson::Names::HindiFemale->new(),
		   Data::RandomPerson::Names::ModernGreekLast->new(),
		   Data::RandomPerson::Names::SpanishLast->new(),
		   Data::RandomPerson::Names::VikingFemale->new(),
                 );
    my @MALE   = ( Data::RandomPerson::Names::AncientGreekMale->new(),
		   Data::RandomPerson::Names::ArabicMale->new(),
		   Data::RandomPerson::Names::BasqueMale->new(),
		   Data::RandomPerson::Names::CelticMale->new(),
		   Data::RandomPerson::Names::EnglishMale->new(),
		   Data::RandomPerson::Names::HindiMale->new(),
		   Data::RandomPerson::Names::JapaneseMale->new(),
		   Data::RandomPerson::Names::LatvianMale->new(),
		   Data::RandomPerson::Names::Male->new(),
		   Data::RandomPerson::Names::ModernGreekMale->new(),
		   Data::RandomPerson::Names::SpanishMale->new(),
		   Data::RandomPerson::Names::ThaiMale->new(),
		   Data::RandomPerson::Names::VikingMale->new(),
                 );
    my @FEMALE = ( Data::RandomPerson::Names::AncientGreekFemale->new(),
		   Data::RandomPerson::Names::ArabicFemale->new(),
		   Data::RandomPerson::Names::BasqueFemale->new(),
		   Data::RandomPerson::Names::CelticFemale->new(),
		   Data::RandomPerson::Names::EnglishFemale->new(),
		   Data::RandomPerson::Names::Female->new(),
		   Data::RandomPerson::Names::HindiFemale->new(),
		   Data::RandomPerson::Names::JapaneseFemale->new(),
		   Data::RandomPerson::Names::LatvianFemale->new(),
		   Data::RandomPerson::Names::ModernGreekFemale->new(),
		   Data::RandomPerson::Names::SpanishFemale->new(),
		   Data::RandomPerson::Names::ThaiFemale->new(),
		   Data::RandomPerson::Names::VikingFemale->new(),
                 );
    my @LAST   = ( Data::RandomPerson::Names::ArabicLast->new(),
		   Data::RandomPerson::Names::EnglishLast->new(),
		   Data::RandomPerson::Names::Last->new(),
		   Data::RandomPerson::Names::Last->new(),
		   Data::RandomPerson::Names::ModernGreekLast->new(),
		   Data::RandomPerson::Names::SpanishLast->new(),
                 );
sub _pick_name {
    my %args = @_;
    my $type = $args{type}  || 'cosmic';


    my $flist = [];
    if ($type eq 'cosmic') {
	$flist = \@COSMIC;
    }
    elsif ($type eq 'corp') {
	$flist = \@LAST;
    }
    elsif ($type eq 'male') {
	$flist = \@MALE;
    }
    elsif ($type eq 'female') {
	$flist = \@FEMALE;
    }
    else {
	die "Unknown name type '$type'";
    }

    my $name = '';
    do {
	$name  = $flist->[int(rand(@$flist))]->get();
	$name .= ' '.$LAST[int(rand(@LAST))]->get()
	    if $type eq 'male' or $type eq 'female';
    }
    while (_check_name( name => $name, type => $type ) == 0);

    return $name;
}
}

BEGIN {
    my %SEEN_NAMES = ();
sub _check_name {
    my %args  = @_;
    my $name  = $args{name};
    my $type  = $args{type};
    my $reset = $args{reset};

    if ($reset) {
	%SEEN_NAMES = ();
	return;
    }

    my $token = join ':', uc($type), uc($name);

    return 0
	if exists $SEEN_NAMES{$token};

    $SEEN_NAMES{$token} = 1;
    return 1;
}
}

BEGIN {
    my @GREEK = qw(Beta Gamma Delta Zeta Theta Kappa Lambda Rho Sigma Tau Psi Omega);
    my @PLACE = qw(Hades Amber Annwyn Asgard Avalon Dinas Elysian Reynes Saguenay Kvenland Lyonesse Meropis Olympus Shangra Tartarus Themis Valhallan);
sub _pick_sector_name {
    # No args
    my $pname = $PLACE[int(rand(@PLACE))];
    my $gname = $GREEK[int(rand(@GREEK))];

    return $pname.' '.$gname;
}
}

# Produce $count number of roman numeral
# planet numbers.
BEGIN {
    my %NUMS = ( 3  => 'III',
		 4  => 'IV',
		 5  => 'V',
		 6  => 'VI',
		 7  => 'VII',
		 8  => 'VIII',
		 9  => 'IX',
		 10 => 'X',
               );
sub _world_nums {
    my $count = shift;

    my %use_nums  = ();
    my $good_nums = 0;

  NUM:
    while ($good_nums < $count) {
	my $num = _d(8) + 2;

	next NUM
	    if exists $use_nums{$num};

	$use_nums{$num} = 1;
	$good_nums++;
    }

    my @rom_nums = map{ $NUMS{$_} } sort { $a <=> $b } keys %use_nums;

    return @rom_nums;
}
}

sub _d {
    my $sides = shift;
    my $times = 1;
    my $plus  = 0;
    if ($sides =~ /x/) {
	($sides, $times) = split /x/, $sides;
    }
    elsif ($sides =~ /p/) {
	($sides, $plus) = split /p/, $sides;
    }

    my $total = 0;
    for (my $roll = 0; $roll < $times; $roll++) {
	$total += int(rand($sides)) + 1;
    }
    $total += $plus;
    return $total;
}

sub _d_world_count {
    my $first_roll = _d(10);
    return 1
	if $first_roll < 6;
    return 2
	if $first_roll < 9;
    return 3;
}

1;
