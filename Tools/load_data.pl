#!/usr/bin/env perl

use strict;
use warnings;

use DBI;

my @data =
    ([2, 'Armory: locked gun cabinets, armor racks'],
     [4, 'Art studio: half-finished pieces, tools'],
     [6, 'Balcony: flowers, climbing vines'],
     [8, 'Ballroom: musical instruments, decorations'],
     [10,'Barracks: footlockers, stacked bunks'],
     [12,'Bath chamber: large bathing pool, steam rooms'],
     [14,'Bedroom: locked cabinets, personal mementos'],
     [16,'Biotech lab: unfinished experiments, toxins'],
     [18,'Broadcasting stage: holocams, props'],
     [20,'Cellar: mold, dampness, spiderwebs on shelves'],
     [22,'Cold storage: haunches of alien meat'],
     [24,'Computer room: flickering servers, vent fans'],
     [26,'Council chamber: large table, mapboard, records'],
     [28,'Crypt: sarcophagi, bones, grave goods'],
     [30,'Dining room: long tables, epergnes, portraits'],
     [32,'Dormitory: bunks, dividers, common baths'],
     [34,'Engineering workshop: parts, electricity, scrap'],
     [36,'Game room: Table games, nets, flashing baubles'],
     [38,'Garden: benches, fountains, exotic foliage'],
     [40,'Great hall: large hearth, tables, raised dais'],
     [42,'Greenhouse: vegetables, irrigation systems, insects'],
     [44,'Icon room: religious paintings, statues, kneelers'],
     [46,'Kennel: stink, fur, bones, feeding bowls'],
     [48,'Kitchen: boiling pots, ovens, numerous knives'],
     [50,'Lavatory: sonic showers, nonhuman facilities'],
     [52,'Lecture hall: podium, seats, holoboard'],
     [54,'Library: scrolls, dataslabs, codices, massive folios'],
     [56,'Lumber room: spare furniture, dropcloths, dust'],
     [58,'Maintenance closet: mops, cleaning solvents, sinks'],
     [60,'Medical clinic: empty sprayhypos, antiseptic smell'],
     [62,'Monitoring center: banks of screens, darkness'],
     [64,'Mortuary: embalming tools, canopic jars'],
     [66,'Museum: display cases, plaques, audio explanations'],
     [68,'Nursery: toys, brightly-painted walls, cribs'],
     [70,'Operating theater: overhead lights, tables, scalpels'],
     [72,'Pantry: dusty cannisters, sacks of grain'],
     [74,'Prayer room: icons, kneelers, washbasins'],
     [76,'Prison cell: mold, vermin, peeling paint'],
     [78,'Quarantine room: cot, bedpan, handwritten will'],
     [80,'Solarium: transparent aluminum ceiling, plants'],
     [82,'Sparring room: floor mats, practice weapons'],
     [84,'Storeroom: crates, bales, cabinets, chests'],
     [86,'Theater: costumes, stage, secret machinery'],
     [88,'Torture chamber: straps, chemicals, recording gear'],
     [90,'Trophy room: xenolife body parts, plaques, chairs'],
     [92,'Unfinished room: bare wiring, stacked paneling'],
     [94,'Vault: Cameras, thick doors, timed locks'],
     [96,'Vestibule: coat racks, shoe rests, matting'],
     [98,'Wardrobe: out-of-date clothing, mirrors, shoes'],
     [100,'Wellhouse: water filters, tanks, heaters'],
    );

# Set up the DB handle
my $dbh = DBI->connect('dbi:SQLite:dbname=swn.sqlite','','',
		       { RaiseError => 1, AutoCommit => 0 })
    or die "Could not connect to DB: $!";

my $sth = $dbh->prepare(qq(INSERT INTO QUICK_ROOM (id, room)
                           VALUES (?, ?)
			  ));

my $idx = 1;
foreach my $row (@data) {
    my ($maxid, $room) = @$row;
    while ($idx <= $maxid) {
	$sth->execute($idx++, $room);
    }
}
$sth->finish();

$dbh->commit();

$dbh->disconnect();

exit;
