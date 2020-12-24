

CREATE TABLE "ALIEN_BODY_TYPE" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"name" VARCHAR(32) NOT NULL,
"desc" CLOB NOT NULL
);
INSERT INTO "ALIEN_BODY_TYPE" VALUES (1, 'Humanlike', 'Humanlike aliens are just that; extremely close to humans in outward appearance. They might have unusual skin or hair coloration, different hair growth distributions, an odd number of fingers, cranial ridges, a novel skin texture, variant ear shapes, or different average body builds or sizes, but they largely appear like humans. Xenobiologists postulate that the human shape is simply a very successful evolutionary route on Earth-like planets, and other worlds with similar conditions are likely to produce similar sapients. Crank scientists tend to favor theories of pan-galactic Creators that spread humanlike shapes throughout space; these theories conspicuously fail to take into account the dramatically different DNA and internal organ makeup of many humanlike aliens.');
INSERT INTO "ALIEN_BODY_TYPE" VALUES (2, 'Avian', 'Avian aliens favor birdlike features. Feathered tails, wings, beaks, drastic coloring differences between males and females, skin either partially or fully covered in feathers, hollow bones, and clawed feet and hands are all traits that might be present in an avian-flavored alien. Such avians might have remarkably good vision or show unusual talent as pilots thanks to an evolutionary predilection for thinking in three dimensions.');
INSERT INTO "ALIEN_BODY_TYPE" VALUES (3, 'Reptilian', 'Reptilian aliens can range from the classic "lizard man" look to a more subtle combination of pebble-scaled skin, membrane frills, broad bodies, cold-bloodedness, nictitating membranes, an exceptional sense of smell, thick claws, powerful builds, sharp teeth, and fine scales. Bodies may be broad and thick like that of a lizard, or perhaps sinuous like that of a snake. Reptilian aliens might be found especially on damp, watery worlds, and might be outright amphibious over all or part of their life spans.');
INSERT INTO "ALIEN_BODY_TYPE" VALUES (4, 'Insectile', 'Insectile aliens are usually possessed of chitinous "skin" and one or more pairs of compound eyes. Membranous wings aren’t unknown, but are probably vestigial and useless on all but the smallest or lightest aliens. Insectile aliens might have sucking mouthparts if their primary food source is plant sap- or blood- or might use chewing mandibles instead for a more solid diet. Insectile aliens that function as a hive collective are something of a classic trope, but there’s no reason that a species can’t instead take after more solitary hunting insects such as beetles or spiders.');
INSERT INTO "ALIEN_BODY_TYPE" VALUES (5, 'Exotic', 'Exotic aliens are built out of parts and materials that aren''t normally found in Terran life forms. A humanoid might be composed out of a kind of organic plastic that makes up much of their home planet''s biochemistry, or be composed of an intricate array of interlocking crystals and woody organic elements. You should pick one or more materials that aren''t normally part of an animal''s body and have them play a major role in the alien''s biology. As a consequence, this kind of alien is probably highly dependent upon their home world for food and other biological necessities. If not, they likely spend a lot of effort synthesizing vital materials out of local supplies.');
INSERT INTO "ALIEN_BODY_TYPE" VALUES (6, 'Hybrid', 'Hybrid aliens combine aspects of two or more of the types described here. You should roll two or three times and then pick a few traits from each type to mix together. You might want to take the first type rolled as the dominant flavor of the alien''s biology and then color the other components accordingly.');


CREATE TABLE "ALIEN_LENSES" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"name" VARCHAR(32) NOT NULL,
"desc" CLOB NOT NULL
);
INSERT INTO "ALIEN_LENSES" VALUES (1, 'Collectivity', 'These aliens might be hive-like in their social structure, natural communists, or simply very closely attached to the customs and interests of their social group. The importance of the individual is thought to be minimal, and members will cheerfully and readily sacrifice themselves for the good of the group. To willfully refuse to accept the consensus of the whole is an unspeakable sin, and to be separated permanently from one''s social group is a fate worse than death.');
INSERT INTO "ALIEN_LENSES" VALUES (2, 'Curiosity', 'This species is insatiably curious, constantly prying into the affairs of those around them. Spying for this race carries no opprobrium whatsoever, and while they may attempt to maintain privacy for certain doings, all assume it a given that matters will be discovered in the end. They love to explore new places and meet new sapients, and while they may be brutally indifferent to the fates or treatment of these beings, they''re always eager to observe them. Their societies tend to operate in a profoundly transparent manner, and some view the keeping of secrets as an automatic indication of malicious intent.');
INSERT INTO "ALIEN_LENSES" VALUES (3, 'Despair', 'These aliens have fallen prey to a pervasive sense of failure and loss. Perhaps they are the remnants of a once-glorious empire or the survivors of some cataclysmic disaster for their people. What they once loved has been destroyed, and their sources of comfort and courage have failed them. Superficially, they might resemble those species that crave pleasure and indulgence, but their disports only serve to numb them to the existential gloom that taints the species. Their leadership is desultory at best, and sophisticated social structures tend to degrade into loose, diffident associations as their members no longer have the hope necessary to perpetuate them.');
INSERT INTO "ALIEN_LENSES" VALUES (4, 'Domination', 'These aliens are consumed by a desire to conquer and rule, both each other and any other species unfortunate enough to share the stellar neighborhood. Some among them can be fair and thoughtful rulers, but others are nothing more than vainglorious tyrants. Among themselves, society tends to be organized in intricate and clearly- marked hierarchies, with advancement progressing along both official and illicit routes. These aliens constantly test their leaders, forcing them to maintain their position through strength and cunning.');
INSERT INTO "ALIEN_LENSES" VALUES (5, 'Faith', 'Such a species is driven by religious concerns, organizing their society around their faith and its clergy. Most such species have a single faith. Others make do with a number of different religions, all followed with a fierce devotion. Challenges to this faith are not met with outrage so much as blank incomprehension; for these beings, the truth of their religions is so self-evident that it seems irrational to ever question it. Those who most perfectly embody the teachings of their creeds tend to become rulers, their lives and will taken as an example for others.');
INSERT INTO "ALIEN_LENSES" VALUES (6, 'Fear', 'These aliens live in constant fear. They may be natives of some lethal death-world, survivors of a species-annihilating cataclysm, or simply evolved from weak and easily-devoured prey animals. The world is terrifying to them, and their societies are based around hiding or protecting themselves from these dreads. The most revered members are those who are best hidden or best protected, and who can give protection and concealment to their fellows. Most of these races are quite cowardly by human measure, but occasionally they can be driven into a frenzy of terror in which they fight with the courage of the doomed.');
INSERT INTO "ALIEN_LENSES" VALUES (7, 'Gluttony', 'These aliens devour. They are rapacious consumers, whether it is of food, living space, energy, or some other resource. They will do almost anything to increase access to this resource and are deeply indifferent to the needs of other species, and often of their own fellows as well. To consume greatly is glorious for this species, with the greatest and most respected members being those who have the greatest stockpiles of the resource to consume, or who provide the most to their followers. The purpose of existence is to eat, and all good things are understood as different modes of devouring.');
INSERT INTO "ALIEN_LENSES" VALUES (8, 'Greed', 'These aliens are enormously greedy. Status depends almost entirely upon personal wealth, and their lives are spent in accumulating the greatest stores of value possible. Some focus on production, creating the wealth for their own benefit, while others seek to make a profit on trade. Some such greedy species have intricate property laws to safeguard what is accumulated, while others are little more than bandits among their own kind, too avaricious to let law interfere with their greed.');
INSERT INTO "ALIEN_LENSES" VALUES (9, 'Hate', 'There is something these aliens hate, and it defines their culture completely by their opposition to it. It may be these aliens are rampant xenophobes, loathing all who are not of their own kind. There may be acrid religious or political divisions among them, with individuals identifying completely with their sect and despising all the others. It could be an ancient enemy among the stars, a rival race that has wounded them so greatly as to be unforgivable. These aliens may spar and maneuver for power among their own kind, but all goals and individuals are to some degree subordinated to the needs of their immortal hate.');
INSERT INTO "ALIEN_LENSES" VALUES (10, 'Honor', 'Whatever sort of society the race has, it is one obsessed with honorable behavior. Members will obey the social mores and expectations of their roles at all costs. Personal sacrifice for the sake of upholding these principles earns a member glory and esteem. Gaining advantage by means of inappropriate behavior or failing in one''s duty is shameful, and an entity that has compromised its honor too greatly may prefer death to continued existence.');
INSERT INTO "ALIEN_LENSES" VALUES (11, 'Journeying', 'This species has an incurable wanderlust. Perhaps they roam the stars in fleets of massive spike-drive ships, or they may make steady circuits of the nearby stars to connect their worlds and exchange people among them. More technologically primitive species might sail the waves of alien seas or make nomadic journeys across the continents of their world. Few of these aliens can ever be happy in remaining in one place for long, and they are forever scouting new worlds and new lands simply for the pleasure of being there a little while.');
INSERT INTO "ALIEN_LENSES" VALUES (12, 'Joy', 'These aliens are relentless bon vivants, constantly in pursuit of pleasure and enjoyable excitement. Beauty, grace, and the inspiration of passion are their highest virtues. Those who produce the most exquisite art or inspire the most extravagant delight have effective rule over their fellows, though such species tend to be loosely-organized at best. The brute necessities of life are acknowledged as a necessity, but their societies are willing to sacrifice a great deal of efficiency and practicality for the sake of immediate satisfaction.');
INSERT INTO "ALIEN_LENSES" VALUES (13, 'Pacifism', 'The race is remarkably peaceful and nonviolent in nature. Few species survive while being totally averse to violent self-defense, but this race will never choose violence against living creatures as a means of gaining advantage or retaliating to wrongs. Among their own kind, violence is abhorrent and unnatural, and it is probable that the species is either herbivorous or subsists by photosynthesis. A pacifist race may be peaceful, but there are more ways to do injury than through personal violence; the cession of trade, the destruction of property, and the incitement of divisions and confusion among their enemies are all tools this race knows well. Pacifist species can also be quite oppressive at times, with an underclass constitutionally incapable of defending their possessions or privileges with force.');
INSERT INTO "ALIEN_LENSES" VALUES (14, 'Pride', 'These aliens are suffused with an enormous pride in their own culture and species, and instinctively consider themselves to be superior to the lesser beings they may encounter. A prideful species is not necessarily a hostile one; some such races have a certain sense of noblesse oblige toward their "lessers", and some species'' pride shows in a resolute refusal to lower themselves to deceit, cruelty, or avarice. More often, however, this pride manifests in a casual contempt for the interests of their inferiors, and a single-minded focus on personal advancement and glory among their own kind.');
INSERT INTO "ALIEN_LENSES" VALUES (15, 'Sagacity', 'These aliens love intellectual pursuits above all others. Logic, wisdom, and erudition are all prized as the best and most glorious expressions of their nature, and their rulers are invariably sage-kings of remarkable depth and breadth of understanding. Such understanding does not necessarily stand in well for good judgment, and sagacious alien civilizations are notorious for overreaching in their ambitions. Stupidity and ignorance is repugnant to this race, and some of them treat very harshly those species that they do not feel to be their intellectual peers.');
INSERT INTO "ALIEN_LENSES" VALUES (16, 'Subtlety', 'Such a species is enormously cunning and patient in character, willing to endure years of suffering calmly in order to bring about some intricate plan. They shun open display of emotions or opinions, masking such things behind protocols of bland correctness. To reveal one''s true opinion about some contentious matter is a mark either of profound trust or a sign of obvious incipient treachery. The true ruler of such a species is almost never who it seems to be.');
INSERT INTO "ALIEN_LENSES" VALUES (17, 'Tradition', 'This species devoutly reveres the past and the ways of their ancestors. Social interactions are stiffly ritualized, and society is ornate with the customs, traditions, and habits of their forebears. Innovations of any kind are viewed with deep suspicion, and the most favored solutions to problems are those which have been employed before. Members of this species are intensely uncomfortable when forced to exercise their own judgment, and doing so in contravention to the past is almost impossible for them. Only when faced with a completely novel situation is any degree of personal initiative likely to be shown, and even in that case, the alien will try to reconcile it to some existing tradition.');
INSERT INTO "ALIEN_LENSES" VALUES (18, 'Treachery', 'This species is uniformly treacherous and untrustworthy. Bargains and agreements are kept only so long as they are useful to both participants, and truthfulness is simply a tool to be placed next to deceit. There is no sense of acrimony or anger among these aliens at the inevitable betrayals that make up their societies; they consider it good and laudable that an individual should seek its own best interests, and those who can most perfectly manipulate each other are naturally those most worthy to rule, for the health of the society directly influences the power of its head.');
INSERT INTO "ALIEN_LENSES" VALUES (19, 'Tribalism', 'The aliens are fiercely tribal, divided up into myriad small groups that are as often at war with each other as they are cooperating. Such tribes tend to be built along familial lines, though some tribes are volitional in nature, representing different political or philosophical groups. A given alien''s loyalty is to its tribe before its species, and it is not uncommon for their enemies to use one group against another.');
INSERT INTO "ALIEN_LENSES" VALUES (20, 'Wrath', 'The race is hot-tempered, prone to fits of personal violence. Disputes are settled by force, though rarely to the point of death among their own kind. Outsiders can expect swift and bloody retaliation for any insult or slight, and the prospect of death rarely intimidates these beings. Their chief mode of emotional expression is anger; wrath at obstacles, fury at enemies, and a slow smoldering burn when neither are available.');


CREATE TABLE "ALIEN_STRUCTURE" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"name" VARCHAR(32) NOT NULL,
"desc" CLOB NOT NULL
);
INSERT INTO "ALIEN_STRUCTURE" VALUES (1, 'Democratic', 'The species has a broadly democratic organization, with individual members having a formal say in the choice of leadership. This voting need not necessarily be based on numbers; it might be a vote with money, military power, religious influence, possession of certain biological traits, or any other metric that makes sense to the aliens. Whatever the specific currency, politics for this race tends to revolve around persuasion and diplomacy rather than use of military force to determine species-wide policies.');
INSERT INTO "ALIEN_STRUCTURE" VALUES (2, 'Monarchic', 'The species is ruled by a single being, with such rule justified by custom, biological imperative, divine mandate, personal influence, or familial ties. Such monarchic societies almost invariably have a "noble" caste of some kind to act as administrators and officials for the monarch, and they usually make up the pool from which new monarchs are chosen. The specific title for a monarch will usually depend on the justification for their rule- Chieftain, Emperor, Broodmother, High Priest, Dictator, Chief Elder, or so forth.');
INSERT INTO "ALIEN_STRUCTURE" VALUES (3, 'Tribal', 'The species is organized into multiple tribes based on lineage, philosophy, or geographical location. Tribes set their own laws and policies, and are prone to intense internal struggles over resources and status. There may exist a "paramount tribe" that inflicts its will upon the others through brute strength or traditional esteem. Tribal leaders tend to be personally distinguished, and usually have earned their position through personal accomplishments and the broad support of their tribemates.');
INSERT INTO "ALIEN_STRUCTURE" VALUES (4, 'Oligarchic', 'The species is led by a number of powerful or revered figures who work in nominal harmony. Individual oligarchs might have their own goals, but no single member has the strength to enforce its will upon the whole. These oligarchs might be the product of hereditary inheritance, or individual members of the species might one day aspire to join their numbers.');
INSERT INTO "ALIEN_STRUCTURE" VALUES (5, 'Multipolar', '');
INSERT INTO "ALIEN_STRUCTURE" VALUES (6, 'Multipolar', '');


CREATE TABLE "ALIEN_VAR_AVIAN" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"variation" VARCHAR(64) NOT NULL
);
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (1, 'Sharp feathers');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (2, '$$1D3 pairs of wings');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (3, 'Long, sinuous neck');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (4, 'Brilliant coloration');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (5, 'Membranous wings');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (6, 'Can hover');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (7, 'Beautiful song');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (8, 'Flightless');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (9, 'Fights prey on the ground');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (10, 'Launches secretions at prey');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (11, 'Lifts and drops prey');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (12, 'Exhales flame or other toxic substance');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (13, 'Always appears in groups');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (14, 'Long prehensile tail');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (15, 'Animal is cold-blooded');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (16, 'Fur instead of feathers');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (17, 'Scales instead of feathers');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (18, 'Toothed beak');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (19, 'Has valuable or delicious eggs');
INSERT INTO "ALIEN_VAR_AVIAN" VALUES (20, 'Flies by means of lighter-than-air gas');


CREATE TABLE "ALIEN_VAR_EXOTIC" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"variation" VARCHAR(64) NOT NULL
);
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (1, 'Rocklike body');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (2, '$$1D4 pairs of eyestalks');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (3, 'Rolls on wheels');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (4, 'Chainsaw-like mouthparts or claws');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (5, 'Metallic hide');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (6, 'Natural laser emitters');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (7, 'Launches chemically-powered darts');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (8, 'Amoeba-like body');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (9, 'Crystalline tissues');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (10, 'Gas-sack body');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (11, '$$2D10 tentacles');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (12, 'Gelatinous liquid body');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (13, 'Radioactive flesh');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (14, 'Uses sonic attacks to stun prey');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (15, 'Colony entity made up of numerous small animals');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (16, 'Controlled by neural symbiont');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (17, 'Absorbs electromagnetic energy');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (18, 'Precious mineral carapace or exoskeleton');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (19, 'Double damage from a particular type of injury');
INSERT INTO "ALIEN_VAR_EXOTIC" VALUES (20, 'Mobile plant life');


CREATE TABLE "ALIEN_VAR_INSECT" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"variation" VARCHAR(64) NOT NULL
);
INSERT INTO "ALIEN_VAR_INSECT" VALUES (1, 'Sucking mouthparts');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (2, 'Chewing mouthparts');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (3, 'Jewel-colored chitin');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (4, '$$2D4 pairs of limbs');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (5, 'Membranous wings');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (6, 'Deposits eggs in live prey');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (7, 'Has "silk" spinnerets');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (8, 'Has a chrysalis life stage');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (9, 'No mouth; adult form lives only to reproduce');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (10, '$$1D4 pairs of eyes or eyespots');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (11, 'Sluglike body');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (12, 'Color-changing exoskeleton');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (13, 'Always encountered in groups');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (14, 'Hums or buzzes in intricate patterns');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (15, 'Lives in hives led by a queen');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (16, 'Killing one causes others nearby to go berserk');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (17, 'Emits powerful pheromones');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (18, 'Hides itself to ambush prey');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (19, 'Prefers subterranean environments');
INSERT INTO "ALIEN_VAR_INSECT" VALUES (20, 'Emits noxious or poisonous stench when killed');


CREATE TABLE "ALIEN_VAR_MAMMAL" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"variation" VARCHAR(64) NOT NULL
);
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (1, 'Multiple mouths');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (2, 'Quill-like fur');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (3, 'Prehensile tail');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (4, 'Eyes or eyespots on body');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (5, 'Membranous wings');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (6, 'Stench glands');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (7, 'Peculiar vocalization');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (8, 'Marsupial pouch');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (9, 'Patterned fur or hide');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (10, 'Expands or inflates when threatened');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (11, 'Strictly nocturnal');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (12, '$$1D6P1 limbs, including any tail');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (13, 'Mottled or mangy fur');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (14, 'Fires darts or quills');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (15, 'Animal is cold-blooded');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (16, 'Horns or body spikes');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (17, 'Superb scent tracker');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (18, 'Burrowing creature');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (19, 'Creature lacks a sense- hearing, sight, or smell');
INSERT INTO "ALIEN_VAR_MAMMAL" VALUES (20, 'Creature is abnormally clever for an animal');


CREATE TABLE "ALIEN_VAR_REPTILE" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"variation" VARCHAR(64) NOT NULL
);
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (1, 'Sharp-edged scales');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (2, '$$1D4 pairs of eyes');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (3, 'Extremely long tail');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (4, 'Bellowing vocalization');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (5, 'Burrowing foreclaws');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (6, 'Hide is damp and slimy');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (7, 'Eyeless');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (8, 'Strong swimmer');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (9, 'Spits venom');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (10, 'Lies in ambush in bodies of water');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (11, 'Brilliantly-hued scales or hide');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (12, 'Horns or body spikes');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (13, 'Large membranous frills');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (14, 'Hibernates in caves and undisturbed nooks');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (15, 'Glowing body parts');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (16, 'Body is patterned with both scales and hide');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (17, 'Springs on prey from elevated places');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (18, 'Warm-blooded');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (19, 'Furred');
INSERT INTO "ALIEN_VAR_REPTILE" VALUES (20, 'Limbless body');


CREATE TABLE "NPC_AGE" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "age" VARCHAR NOT NULL );
INSERT INTO "NPC_AGE" VALUES (1, 'Young');
INSERT INTO "NPC_AGE" VALUES (2, 'Young');
INSERT INTO "NPC_AGE" VALUES (3, 'Middle-aged');
INSERT INTO "NPC_AGE" VALUES (4, 'Middle-aged');
INSERT INTO "NPC_AGE" VALUES (5, 'Old');
INSERT INTO "NPC_AGE" VALUES (6, 'Old');


CREATE TABLE "NPC_GENDER" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "gender" VARCHAR NOT NULL );
INSERT INTO "NPC_GENDER" VALUES (1, 'male');
INSERT INTO "NPC_GENDER" VALUES (2, 'male');
INSERT INTO "NPC_GENDER" VALUES (3, 'female');
INSERT INTO "NPC_GENDER" VALUES (4, 'female');


CREATE TABLE "NPC_HEIGHT" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "height" VARCHAR NOT NULL );
INSERT INTO "NPC_HEIGHT" VALUES (1, 'Very Short');
INSERT INTO "NPC_HEIGHT" VALUES (2, 'Short');
INSERT INTO "NPC_HEIGHT" VALUES (3, 'Short');
INSERT INTO "NPC_HEIGHT" VALUES (4, 'Average Height');
INSERT INTO "NPC_HEIGHT" VALUES (5, 'Average Height');
INSERT INTO "NPC_HEIGHT" VALUES (6, 'Tall');
INSERT INTO "NPC_HEIGHT" VALUES (7, 'Tall');
INSERT INTO "NPC_HEIGHT" VALUES (8, 'Very Tall');


CREATE TABLE "NPC_MOTIVATION" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "motive" VARCHAR NOT NULL );
INSERT INTO "NPC_MOTIVATION" VALUES (1, 'Greed, because nothing else they can do pays better');
INSERT INTO "NPC_MOTIVATION" VALUES (2, 'Idealistic about the job');
INSERT INTO "NPC_MOTIVATION" VALUES (3, 'Sense of social duty');
INSERT INTO "NPC_MOTIVATION" VALUES (4, 'Force of habit takes them through the day');
INSERT INTO "NPC_MOTIVATION" VALUES (5, 'Seeks to please another');
INSERT INTO "NPC_MOTIVATION" VALUES (6, 'Feels inadequate as anything else');
INSERT INTO "NPC_MOTIVATION" VALUES (7, 'Family tradition');
INSERT INTO "NPC_MOTIVATION" VALUES (8, 'Religious obligation or vow');
INSERT INTO "NPC_MOTIVATION" VALUES (9, 'Nothing better to do, and they need the money');
INSERT INTO "NPC_MOTIVATION" VALUES (10, 'They''re quitting at the first good opportunity');
INSERT INTO "NPC_MOTIVATION" VALUES (11, 'It''s a stepping stone to better things');
INSERT INTO "NPC_MOTIVATION" VALUES (12, 'Spite against an enemy discomfited by the work');


CREATE TABLE "NPC_PROBLEMS" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "problem" VARCHAR NOT NULL );
INSERT INTO "NPC_PROBLEMS" VALUES (1, 'Grudge against local authorities.');
INSERT INTO "NPC_PROBLEMS" VALUES (2, 'Has a secret kept from their family.');
INSERT INTO "NPC_PROBLEMS" VALUES (3, 'Chronic illness');
INSERT INTO "NPC_PROBLEMS" VALUES (4, 'Enmity of a local psychic');
INSERT INTO "NPC_PROBLEMS" VALUES (5, 'Has enemies at work');
INSERT INTO "NPC_PROBLEMS" VALUES (6, 'Owes loan sharks');
INSERT INTO "NPC_PROBLEMS" VALUES (7, 'Threatened with loss of spouse, sibling, or child');
INSERT INTO "NPC_PROBLEMS" VALUES (8, 'Close relative in trouble with the law');
INSERT INTO "NPC_PROBLEMS" VALUES (9, 'Drug or behavioral addict');
INSERT INTO "NPC_PROBLEMS" VALUES (10, 'Blackmailed by enemy');


CREATE TABLE "NPC_QUIRKS" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "quirk" VARCHAR NOT NULL );
INSERT INTO "NPC_QUIRKS" VALUES (1, 'Bald');
INSERT INTO "NPC_QUIRKS" VALUES (2, 'Terrible taste in clothing');
INSERT INTO "NPC_QUIRKS" VALUES (3, 'Very thin');
INSERT INTO "NPC_QUIRKS" VALUES (4, 'Powerful build');
INSERT INTO "NPC_QUIRKS" VALUES (5, 'Bad eyesight, wears spectacles');
INSERT INTO "NPC_QUIRKS" VALUES (6, 'Carries work tools constantly');
INSERT INTO "NPC_QUIRKS" VALUES (7, 'Long hair');
INSERT INTO "NPC_QUIRKS" VALUES (8, 'male:Bearded,female:Ankle-length hair');
INSERT INTO "NPC_QUIRKS" VALUES (9, 'Scars all over hands');
INSERT INTO "NPC_QUIRKS" VALUES (10, 'Missing digits or an ear');
INSERT INTO "NPC_QUIRKS" VALUES (11, 'Smells like their work');
INSERT INTO "NPC_QUIRKS" VALUES (12, 'Repeats themself constantly');
INSERT INTO "NPC_QUIRKS" VALUES (13, 'Talks about tabloid articles');
INSERT INTO "NPC_QUIRKS" VALUES (14, 'Booming voice');
INSERT INTO "NPC_QUIRKS" VALUES (15, 'Vocal dislike of offworlders');
INSERT INTO "NPC_QUIRKS" VALUES (16, 'Always snuffling');
INSERT INTO "NPC_QUIRKS" VALUES (17, 'Missing teeth');
INSERT INTO "NPC_QUIRKS" VALUES (18, 'Fastidiously neat');
INSERT INTO "NPC_QUIRKS" VALUES (19, 'Wears religious emblems');
INSERT INTO "NPC_QUIRKS" VALUES (20, 'Speaks as little as possible');


CREATE TABLE "QUICK_ARCHITECTURE" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"element" VARCHAR(64) NOT NULL
);
INSERT INTO "QUICK_ARCHITECTURE" VALUES (101, 'Sharply pointed towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (102, 'Squat towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (103, 'Square, hexagonal, or oval towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (104, 'Multi-branching towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (105, 'Inverted towers, stretching underground');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (106, 'Bulbous towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (107, 'Flat-topped towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (108, 'Multiple towers that merge into one');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (109, 'Skeletal towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (110, 'Twisted towers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (201, 'Square foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (202, 'Hexagonal foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (203, 'Circular foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (204, 'Raised foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (205, 'Pillared foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (206, 'Sloped foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (207, 'Entrenched foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (208, 'Elongated rectangular foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (209, 'Triangular foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (210, 'Oval foundations');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (301, 'Bas-reliefs on walls');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (302, 'Painting on walls');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (303, 'Mosaics on walls or floors');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (304, 'Statues inset in wall niches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (305, 'Tiling on surfaces');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (306, 'Carvings on walls');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (307, 'Moldings on walls');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (308, 'Paneling on walls');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (309, 'Geometric designs on surfaces');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (310, 'Featureless surfaces');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (401, 'Flying buttresses');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (402, 'Smooth pillars');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (403, 'Adorned pillars');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (404, 'Raised embankments');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (405, 'Pier buttresses');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (406, 'Scroll buttresses');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (407, 'False, decorative buttresses');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (408, 'Pyramidal support piers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (409, 'Squared support piers');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (410, 'Seeming lack of supports or buttresses');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (501, 'Round arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (502, 'Lancet arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (503, 'Oriental arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (504, 'Horseshoe arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (505, 'Multifoil arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (506, 'Monumental arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (507, 'Keyhole arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (508, 'Inflexed arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (509, 'Flat arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (510, 'Corbelled arches');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (601, 'Canals and pools');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (602, 'Balconies and overlooks');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (603, 'Subterranean structures');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (604, 'Absence or profusion of windows');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (605, 'Walled or enclosed courtyards');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (606, 'Open plazas');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (607, 'Elevated walkways');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (608, 'Monoliths or standing stones');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (609, 'Meandering pathways');
INSERT INTO "QUICK_ARCHITECTURE" VALUES (610, 'Climbing vegetation');


CREATE TABLE "QUICK_CORP_BUSINESS" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "business" VARCHAR NOT NULL );
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (1, 'Aeronautics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (2, 'Aeronautics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (3, 'Agriculture');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (4, 'Agriculture');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (5, 'Art');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (6, 'Art');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (7, 'Assassination');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (8, 'Assassination');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (9, 'Asteroid Mining');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (10, 'Asteroid Mining');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (11, 'Astrotech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (12, 'Astrotech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (13, 'Biotech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (14, 'Biotech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (15, 'Bootlegging');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (16, 'Bootlegging');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (17, 'Computer Hardware');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (18, 'Computer Hardware');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (19, 'Construction');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (20, 'Construction');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (21, 'Cybernetics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (22, 'Cybernetics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (23, 'Electronics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (24, 'Electronics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (25, 'Energy Weapons');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (26, 'Energy Weapons');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (27, 'Entertainment');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (28, 'Entertainment');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (29, 'Espionage');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (30, 'Espionage');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (31, 'Exploration');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (32, 'Exploration');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (33, 'Fishing');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (34, 'Fishing');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (35, 'Fuel Refining');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (36, 'Fuel Refining');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (37, 'Gambling');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (38, 'Gambling');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (39, 'Gemstones');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (40, 'Gemstones');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (41, 'Gengineering');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (42, 'Gengineering');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (43, 'Grav Vehicles');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (44, 'Grav Vehicles');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (45, 'Heavy Weapons');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (46, 'Heavy Weapons');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (47, 'Ideology');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (48, 'Ideology');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (49, 'Illicit Drugs');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (50, 'Illicit Drugs');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (51, 'Journalism');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (52, 'Journalism');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (53, 'Law Enforcement');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (54, 'Law Enforcement');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (55, 'Liquor');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (56, 'Liquor');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (57, 'Livestock');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (58, 'Livestock');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (59, 'Maltech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (60, 'Maltech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (61, 'Mercenary Work');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (62, 'Mercenary Work');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (63, 'Metallurgy');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (64, 'Metallurgy');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (65, 'Pharmaceuticals');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (66, 'Pharmaceuticals');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (67, 'Piracy');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (68, 'Piracy');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (69, 'Planetary Mining');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (70, 'Planetary Mining');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (71, 'Plastics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (72, 'Plastics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (73, 'Pretech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (74, 'Pretech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (75, 'Prisons');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (76, 'Prisons');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (77, 'Programming');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (78, 'Programming');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (79, 'Projectile Guns');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (80, 'Projectile Guns');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (81, 'Prostitution');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (82, 'Prostitution');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (83, 'Psionics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (84, 'Psionics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (85, 'Psitech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (86, 'Psitech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (87, 'Robotics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (88, 'Robotics');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (89, 'Security');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (90, 'Security');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (91, 'Shipyards');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (92, 'Shipyards');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (93, 'Snacks');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (94, 'Snacks');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (95, 'Telcoms');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (96, 'Telcoms');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (97, 'Transport');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (98, 'Transport');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (99, 'Xenotech');
INSERT INTO "QUICK_CORP_BUSINESS" VALUES (100, 'Xenotech');


CREATE TABLE "QUICK_CORP_NAME" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR NOT NULL , "organization" VARCHAR NOT NULL );
INSERT INTO "QUICK_CORP_NAME" VALUES (1, 'Ad Astra', 'Alliance');
INSERT INTO "QUICK_CORP_NAME" VALUES (2, 'Colonial', 'Association');
INSERT INTO "QUICK_CORP_NAME" VALUES (3, 'Compass', 'Band');
INSERT INTO "QUICK_CORP_NAME" VALUES (4, 'Daybreak', 'Circle');
INSERT INTO "QUICK_CORP_NAME" VALUES (5, 'Frontier', 'Clan');
INSERT INTO "QUICK_CORP_NAME" VALUES (6, 'Guo Yin', 'Combine');
INSERT INTO "QUICK_CORP_NAME" VALUES (7, 'Highbeam', 'Company');
INSERT INTO "QUICK_CORP_NAME" VALUES (8, 'Imani', 'Cooperative');
INSERT INTO "QUICK_CORP_NAME" VALUES (9, 'Magnus', 'Corporation');
INSERT INTO "QUICK_CORP_NAME" VALUES (10, 'Meteor', 'Enterprises');
INSERT INTO "QUICK_CORP_NAME" VALUES (11, 'Neogen', 'Faction');
INSERT INTO "QUICK_CORP_NAME" VALUES (12, 'New Dawn', 'Group');
INSERT INTO "QUICK_CORP_NAME" VALUES (13, 'Omnitech', 'Megacorp');
INSERT INTO "QUICK_CORP_NAME" VALUES (14, 'Outertech', 'Multistellar');
INSERT INTO "QUICK_CORP_NAME" VALUES (15, 'Overwatch', 'Organization');
INSERT INTO "QUICK_CORP_NAME" VALUES (16, 'Panstellar', 'Outift');
INSERT INTO "QUICK_CORP_NAME" VALUES (17, 'Shogun', 'Pact');
INSERT INTO "QUICK_CORP_NAME" VALUES (18, 'Silverlight', 'Partnership');
INSERT INTO "QUICK_CORP_NAME" VALUES (19, 'Spiker', 'Ring');
INSERT INTO "QUICK_CORP_NAME" VALUES (20, 'Stella', 'Society');
INSERT INTO "QUICK_CORP_NAME" VALUES (21, 'Striker', 'Sodality');
INSERT INTO "QUICK_CORP_NAME" VALUES (22, 'Sunbeam', 'Syndicate');
INSERT INTO "QUICK_CORP_NAME" VALUES (23, 'Terra Prime', 'Union');
INSERT INTO "QUICK_CORP_NAME" VALUES (24, 'Wayfarer', 'Unity');
INSERT INTO "QUICK_CORP_NAME" VALUES (25, 'West Wind', 'Zaibatsu');


CREATE TABLE "QUICK_CORP_REPUTATION" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "reputation" VARCHAR NOT NULL );
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (1, 'Reckless with the lives of their employees');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (2, 'Reckless with the lives of their employees');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (3, 'Reckless with the lives of their employees');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (4, 'Reckless with the lives of their employees');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (5, 'Reckless with the lives of their employees');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (6, 'Have a dark secret about their board of directors');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (7, 'Have a dark secret about their board of directors');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (8, 'Have a dark secret about their board of directors');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (9, 'Have a dark secret about their board of directors');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (10, 'Have a dark secret about their board of directors');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (11, 'Notoriously xenophobic towards aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (12, 'Notoriously xenophobic towards aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (13, 'Notoriously xenophobic towards aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (14, 'Notoriously xenophobic towards aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (15, 'Notoriously xenophobic towards aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (16, 'Lost much money to an embezzler who evaded arrest');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (17, 'Lost much money to an embezzler who evaded arrest');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (18, 'Lost much money to an embezzler who evaded arrest');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (19, 'Lost much money to an embezzler who evaded arrest');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (20, 'Lost much money to an embezzler who evaded arrest');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (21, 'Reliable and trustworthy goods');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (22, 'Reliable and trustworthy goods');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (23, 'Reliable and trustworthy goods');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (24, 'Reliable and trustworthy goods');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (25, 'Reliable and trustworthy goods');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (26, 'Reliable and trustworthy goods');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (27, 'Stole a lot of R&D from a rival corporation');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (28, 'Stole a lot of R&D from a rival corporation');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (29, 'Stole a lot of R&D from a rival corporation');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (30, 'Stole a lot of R&D from a rival corporation');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (31, 'Stole a lot of R&D from a rival corporation');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (32, 'They have high-level political connections');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (33, 'They have high-level political connections');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (34, 'They have high-level political connections');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (35, 'They have high-level political connections');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (36, 'They have high-level political connections');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (37, 'They have high-level political connections');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (38, 'Rumored cover-up of a massive industrial accident');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (39, 'Rumored cover-up of a massive industrial accident');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (40, 'Rumored cover-up of a massive industrial accident');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (41, 'Rumored cover-up of a massive industrial accident');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (42, 'Rumored cover-up of a massive industrial accident');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (43, 'Rumored cover-up of a massive industrial accident');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (44, 'Stodgy and very conservative in their business plans');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (45, 'Stodgy and very conservative in their business plans');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (46, 'Stodgy and very conservative in their business plans');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (47, 'Stodgy and very conservative in their business plans');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (48, 'Stodgy and very conservative in their business plans');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (49, 'Stodgy and very conservative in their business plans');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (50, '');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (51, '');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (52, '');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (53, '');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (54, 'The company’s owner is dangerously insane');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (55, 'The company’s owner is dangerously insane');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (56, 'The company’s owner is dangerously insane');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (57, 'The company’s owner is dangerously insane');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (58, 'The company’s owner is dangerously insane');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (59, 'The company’s owner is dangerously insane');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (60, 'Rumored ties to a eugenics cult');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (61, 'Rumored ties to a eugenics cult');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (62, 'Rumored ties to a eugenics cult');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (63, 'Rumored ties to a eugenics cult');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (64, 'Rumored ties to a eugenics cult');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (65, 'Said to have a cache of pretech equipment');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (66, 'Said to have a cache of pretech equipment');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (67, 'Said to have a cache of pretech equipment');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (68, 'Said to have a cache of pretech equipment');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (69, 'Said to have a cache of pretech equipment');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (70, 'Said to have a cache of pretech equipment');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (71, 'Possibly teetering on the edge of bankruptcy');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (72, 'Possibly teetering on the edge of bankruptcy');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (73, 'Possibly teetering on the edge of bankruptcy');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (74, 'Possibly teetering on the edge of bankruptcy');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (75, 'Possibly teetering on the edge of bankruptcy');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (76, 'Possibly teetering on the edge of bankruptcy');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (77, 'Front for a planetary government’s espionage arm');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (78, 'Front for a planetary government’s espionage arm');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (79, 'Front for a planetary government’s espionage arm');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (80, 'Front for a planetary government’s espionage arm');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (81, 'Front for a planetary government’s espionage arm');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (82, 'Secretly run by a psychic cabal');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (83, 'Secretly run by a psychic cabal');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (84, 'Secretly run by a psychic cabal');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (85, 'Secretly run by a psychic cabal');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (86, 'Secretly run by a psychic cabal');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (87, 'Secretly run by hostile aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (88, 'Secretly run by hostile aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (89, 'Secretly run by hostile aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (90, 'Secretly run by hostile aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (91, 'Secretly run by hostile aliens');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (92, 'Secretly run by an unbraked AI');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (93, 'Secretly run by an unbraked AI');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (94, 'Secretly run by an unbraked AI');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (95, 'Secretly run by an unbraked AI');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (96, 'They''ve turned over a new leaf with the new CEO');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (97, 'They''ve turned over a new leaf with the new CEO');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (98, 'They''ve turned over a new leaf with the new CEO');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (99, 'Deeply entangled with the planetary underworld');
INSERT INTO "QUICK_CORP_REPUTATION" VALUES (100, 'Deeply entangled with the planetary underworld');


CREATE TABLE "QUICK_HERESY_ATTITUDE" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"attitude" VARCHAR NOT NULL,
"adjective"
);
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (1, 'Filial: the sect honors and respects the orthodox faith, but feels it is substantially in error.', 'Filial');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (2, 'Anathematic: the orthodox are spiritually worse than infidels, and their ways must be avoided at all costs.', 'Anathematic');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (3, 'Evangelical: the sect feels compelled to teach the orthodox the better truth of their ways.', 'Evangelical');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (4, 'Contemptuous: the orthodox are spiritually lost and ignoble.', 'Contemptuous');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (5, 'Aversion: the sect wishes to shun and avoid the orthodox.', 'Aversive');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (6, 'Hatred: the sect wishes the death or conversion of the orthodox.', 'Hateful');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (7, 'Indifference: the sect has no particular animus or love for the orthodox.', 'Indifferent');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (8, 'Obedience: the sect feels obligated to obey the orthodox hierarchy in all matters not related to their specific faith.', 'Obedient');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (9, 'Legitimist: the sect views itself as the “true” orthodox faith and the present orthodox hierarchy as pretenders to their office.', 'Legitimist');
INSERT INTO "QUICK_HERESY_ATTITUDE" VALUES (10, 'Purificationist: the sect''s austerities, sufferings, and asceticisms are necessary to purify the orthodox.', 'Purificationist');


CREATE TABLE "QUICK_HERESY_FOUNDER" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "founder" VARCHAR NOT NULL );
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (1, 'Defrocked clergy: founded by a cleric outcast from the faith.');
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (2, 'Frustrated layman: founded by a layman frustrated with the faith''s decadence, rigidity, or lack of authenticity.');
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (3, 'Renegade prophet: founded by a revered holy figure who broke with the faith.');
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (4, 'High prelate: founded by an important and powerful cleric to convey his or her beliefs.');
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (5, 'Dissatisfied minor clergy: founded by a minor cleric frustrated with the faith''s current condition.');
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (6, 'Outsider: founded by a member of another faith deeply influenced by the parent religion.');
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (7, 'Academic: founded by a professor or theologian on intellectual grounds.');
INSERT INTO "QUICK_HERESY_FOUNDER" VALUES (8, 'Accidental; the founder never meant their works to be taken that way.');


CREATE TABLE "QUICK_HERESY_HERESY" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"heresy" CLOB NOT NULL,
"name" VARCHAR(32)
);
INSERT INTO "QUICK_HERESY_HERESY" VALUES (1, 'Manichaeanism: the sect believes in harsh austerities and rejection of matter as something profane and evil.', 'Manichaeanists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (2, 'Donatism: the sect believes that clergy must be personally pure and holy in order to be legitimate.', 'Donatists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (3, 'Supercessionism: the sect believes the founder or some other source supercedes former scripture or tradition.', 'Supercessionists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (4, 'Antinomianism: the sect believes that their holy persons are above any earthly law and may do as they will.', 'Antinomianists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (5, 'Universal priesthood: the sect believes that there is no distinction between clergy and layman and that all functions of the faith may be performed by all members.', 'Universalists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (6, 'Conciliarism: the sect believes that the consensus of believers may correct or command even the clerical leadership of the faith.', 'Conciliarists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (7, 'Ethnocentrism: the sect believes that only a particular ethnicity or nationality can truly belong to the faith.', 'Ethnocentrists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (8, 'Separatism: the sect believes members should shun involvement with the secular world.', 'Separatists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (9, 'Stringency: the sect believes that even minor sins should be punished, and major sins should be capital crimes.', 'Stringentists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (10, 'Syncretism: the sect has added elements of $$RELIGION to their beliefs.', 'Syncretists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (11, 'Primitivism: the sect tries to recreate what they imagine was the original community of faith.', 'Primitivists');
INSERT INTO "QUICK_HERESY_HERESY" VALUES (12, 'Conversion by the sword: unbelievers must be brought to obedience to the sect or be granted death.', 'Crusaders');


CREATE TABLE "QUICK_HERESY_QUIRK" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "quirk" VARCHAR NOT NULL );
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (1, 'Clergy of only one gender.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (2, 'Dietary prohibitions.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (3, 'Characteristic item of clothing or jewelry.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (4, 'Public prayer at set times or places.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (5, 'Forbidden to do something commonly done.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (6, 'Anti-intellectual, deploring secular learning');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (7, 'Mystical, seeking union with God through meditation.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (8, 'Lives in visibly distinct houses or districts.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (9, 'Has a language specific to the sect.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (10, 'Greatly respects learning and education.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (11, 'Favors specific colors or symbols.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (12, 'Has unique purification rituals.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (13, 'Always armed.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (14, 'Forbids marriage or romance outside the sect.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (15, 'Will not eat with people outside the sect.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (16, 'Must donate labor or tithe money to the sect.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (17, 'Special friendliness toward another faith or ethnicity.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (18, 'Favors certain professions for their membership.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (19, 'Vigorous charity work among unbelievers.');
INSERT INTO "QUICK_HERESY_QUIRK" VALUES (20, 'Forbidden the use of certain technology.');


CREATE TABLE "QUICK_POLITICAL_ISSUES" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"issue" CLOB NOT NULL,
"tag" VARCHAR(32)
);
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (1, 'Poverty among the group''s membership.', 'Poverty');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (2, 'Social hostility to the group''s membership.', 'Bigotry');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (3, 'Immigration and immigrants.', 'Immigration');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (4, 'The memberships'' important industries.', 'Industry');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (5, 'Religion in public life.', 'Religion');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (6, 'Gender roles and sexual mores.', 'Gender Roles');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (7, 'Culture of the group membership.', 'Tradition');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (8, 'Military preparedness.', 'Military');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (9, 'Governmental reform.', 'Reform');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (10, 'Secession.', 'Secession');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (11, 'Foreign relations.', 'Foreign Policy');
INSERT INTO "QUICK_POLITICAL_ISSUES" VALUES (12, 'Wealth redistribution.', 'Welfare');


CREATE TABLE "QUICK_POLITICAL_LEADERSHIP" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "leadership" CLOB NOT NULL );
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (1, 'Social elite: the group is led by members of the planet''s ruling class.');
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (2, 'Outcasts: the group''s leadership is filled out by members of a taboo, outcast, or otherwise socially marginal group.');
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (3, 'Bourgeoisie: the group is driven by a leadership drawn from the middle class and those aspiring to join the elite.');
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (4, 'Proletariat: the working class, both agricultural and industrial, provides the leadership for this group.');
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (5, 'Urban: city-dwellers compose the leadership of the group.');
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (6, 'Rural: farmers, herdsmen, small-town artisans, and other residents of the rural zones of a planet make up the leadership of the group.');
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (7, 'Pious: clergy and devout laymen of a religion form the leadership.');
INSERT INTO "QUICK_POLITICAL_LEADERSHIP" VALUES (8, 'Intellectuals: the movement is led by intellectuals.');


CREATE TABLE "QUICK_POLITICAL_NAME" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"element1" VARCHAR(32) NOT NULL UNIQUE,
"element2" VARCHAR(32) NOT NULL UNIQUE
);
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (1, 'People''s', 'Front');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (2, 'Freedom', 'Party');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (3, 'National', 'Faction');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (4, 'Unified', 'Group');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (5, 'Democratic', 'Element');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (6, 'Royal', 'Consensus');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (7, 'Social', 'Council');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (8, 'Progressive', 'Banner');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (9, 'Popular', 'Union');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (10, 'Republican', 'Combine');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (11, '$$COLOR', 'Society');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (12, 'Federal', 'Sodality');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (13, 'Liberty', 'Brotherhood');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (14, '$$ANIMAL', 'Commune');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (15, 'Homeland', 'Pact');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (16, 'Conservative', 'Foundation');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (17, '$$DIRECTION', 'Fellowship');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (18, 'Liberal', 'Guild');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (19, 'Victory', 'Federation');
INSERT INTO "QUICK_POLITICAL_NAME" VALUES (20, '$$METAL', 'Alliance');


CREATE TABLE "QUICK_POLITICAL_OUTSIDERS" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"relationship" CLOB NOT NULL
);
INSERT INTO "QUICK_POLITICAL_OUTSIDERS" VALUES (1, 'Xenophilia: the more immigrants the better, as they provide valuable labor and skills.');
INSERT INTO "QUICK_POLITICAL_OUTSIDERS" VALUES (2, 'Xenophobic: immigration is to be restricted to protect native jobs and culture.');
INSERT INTO "QUICK_POLITICAL_OUTSIDERS" VALUES (3, 'Provisional: some immigrants are to be encouraged, others to be forbidden. Which is which depends on the interests of the group.');
INSERT INTO "QUICK_POLITICAL_OUTSIDERS" VALUES (4, 'Provisional: some immigrants are to be encouraged, others to be forbidden. Which is which depends on the interests of the group.');


CREATE TABLE "QUICK_POLITICAL_POLICY" (
"id" INTEGER NOT NULL PRIMARY KEY UNIQUE,
"policy" CLOB NOT NULL
);
INSERT INTO "QUICK_POLITICAL_POLICY" VALUES (1, 'Laissez-faire: minimal or no government intervention in the market.');
INSERT INTO "QUICK_POLITICAL_POLICY" VALUES (2, 'State industry: the government should own or support specific industries important to the group.');
INSERT INTO "QUICK_POLITICAL_POLICY" VALUES (3, 'Protectionist: the government should tax imports that threaten to displace the products of local manufacturers.');
INSERT INTO "QUICK_POLITICAL_POLICY" VALUES (4, 'Autarky: the government should ensure that the world can provide all of its own goods and services and forbid the import of foreign goods.');
INSERT INTO "QUICK_POLITICAL_POLICY" VALUES (5, 'Socialist: the market should be harnessed to ensure a state-determined minimal standard of living for all.');
INSERT INTO "QUICK_POLITICAL_POLICY" VALUES (6, 'Communist: the state should control the economy, disbursing its products according to need and determined efficiency.');


CREATE TABLE "QUICK_RELIGION_EVOLUTION" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"evolution" CLOB NOT NULL,
"adjective" VARCHAR
);
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (1, 'New holy book. Someone in the faith''s past penned or discovered a text that is now taken to be holy writ and the expressed will of the divine.', 'New Book');
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (2, 'New prophet. This faith reveres the words and example of a relatively recent prophet, esteeming him or her as the final word on the will of God. The prophet may or may not still be living.', 'New Prophet');
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (3, 'Syncretism. This faith has reconciled the major elements of both of its origin beliefs into its tradition.', 'Syncretic');
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (4, 'Neofundamentalism. The faith is fiercely resistant to perceived innovations and deviations from their beliefs. Even extremely onerous traditions and restrictions will be observed to the letter.', 'Neofundamentalist');
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (5, 'Quietism. The faith shuns the outside world and involvement with the affairs of nonbelievers. They prefer to keep to their own kind and avoid positions of wealth and power.', 'Quietist');
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (6, 'Sacrifices. The faith finds it necessary to make substantial sacrifices to please God. Some faiths may go so far as to offer human sacrifices, while others insist on huge tithes offered to the building of religious edifices.', 'Sacrificial');
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (7, 'Schism. The faith''s beliefs are actually almost identical to those of the majority of its origin tradition, save for a few minor points of vital interest to theologians and no practical difference whatsoever to believers. This does not prevent a burning resentment towards the parent faith.', 'Separatist');
INSERT INTO "QUICK_RELIGION_EVOLUTION" VALUES (8, 'Holy family. God''s favor has been shown especially to members of a particular lineage. It may be that only men and women of this bloodline are permitted to become clergy, or they may serve as helpless figureheads for the real leaders of the faith.', 'Holy Family');


CREATE TABLE "QUICK_RELIGION_LEADERSHIP" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "leadership" CLOB NOT NULL );
INSERT INTO "QUICK_RELIGION_LEADERSHIP" VALUES (1, 'Patriarch/Matriarch. A single leader determines doctrine for the entire religion, possibly in consultation with other clerics.');
INSERT INTO "QUICK_RELIGION_LEADERSHIP" VALUES (2, 'Patriarch/Matriarch. A single leader determines doctrine for the entire religion, possibly in consultation with other clerics.');
INSERT INTO "QUICK_RELIGION_LEADERSHIP" VALUES (3, 'Council. A group of the oldest and most revered clergy determine the course of the faith.');
INSERT INTO "QUICK_RELIGION_LEADERSHIP" VALUES (4, 'Council. A group of the oldest and most revered clergy determine the course of the faith.');
INSERT INTO "QUICK_RELIGION_LEADERSHIP" VALUES (5, 'Democracy. Every member has an equal voice in matters of faith, with doctrine usually decided at regular church-wide councils.');
INSERT INTO "QUICK_RELIGION_LEADERSHIP" VALUES (6, 'No universal leadership. Roll again to determine how each region governs itself. If another 6 is rolled, this faith has no hierarchy.');


CREATE TABLE "QUICK_RELIGION_ORIGIN" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"origin" VARCHAR NOT NULL,
"name" VARCHAR,
"adj" VARCHAR(32)
);
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (1, 'Paganism', 'Pagans', 'Pagan');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (2, 'Roman Catholicism', 'Roman Catholics', 'Roman Catholic');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (3, 'Eastern Orthodox Christianity', 'Eastern Orthodox Christians', 'Eastern Orthodox');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (4, 'Protestant Christianity', 'Protestant Christians', 'Protestant');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (5, 'Buddhism', 'Buddhists', 'Buddhist');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (6, 'Judaism', 'Judaism', 'Jewish');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (7, 'Islam', 'Muslims', 'Muslim');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (8, 'Taoism', 'Taoists', 'Taoist');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (9, 'Hinduism', 'Hinduists', 'Hindu');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (10, 'Zoroastrianism', 'Zoroastrianists', 'Zoroastrian');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (11, 'Confucianism', 'Confucianists', 'Confucian');
INSERT INTO "QUICK_RELIGION_ORIGIN" VALUES (12, 'Ideology', 'Ideologists', 'Ideologic');


CREATE TABLE "QUICK_ROOM" (
"id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
"room" CLOB NOT NULL
);
INSERT INTO "QUICK_ROOM" VALUES (1, 'Armory: locked gun cabinets, armor racks');
INSERT INTO "QUICK_ROOM" VALUES (2, 'Armory: locked gun cabinets, armor racks');
INSERT INTO "QUICK_ROOM" VALUES (3, 'Art studio: half-finished pieces, tools');
INSERT INTO "QUICK_ROOM" VALUES (4, 'Art studio: half-finished pieces, tools');
INSERT INTO "QUICK_ROOM" VALUES (5, 'Balcony: flowers, climbing vines');
INSERT INTO "QUICK_ROOM" VALUES (6, 'Balcony: flowers, climbing vines');
INSERT INTO "QUICK_ROOM" VALUES (7, 'Ballroom: musical instruments, decorations');
INSERT INTO "QUICK_ROOM" VALUES (8, 'Ballroom: musical instruments, decorations');
INSERT INTO "QUICK_ROOM" VALUES (9, 'Barracks: footlockers, stacked bunks');
INSERT INTO "QUICK_ROOM" VALUES (10, 'Barracks: footlockers, stacked bunks');
INSERT INTO "QUICK_ROOM" VALUES (11, 'Bath chamber: large bathing pool, steam rooms');
INSERT INTO "QUICK_ROOM" VALUES (12, 'Bath chamber: large bathing pool, steam rooms');
INSERT INTO "QUICK_ROOM" VALUES (13, 'Bedroom: locked cabinets, personal mementos');
INSERT INTO "QUICK_ROOM" VALUES (14, 'Bedroom: locked cabinets, personal mementos');
INSERT INTO "QUICK_ROOM" VALUES (15, 'Biotech lab: unfinished experiments, toxins');
INSERT INTO "QUICK_ROOM" VALUES (16, 'Biotech lab: unfinished experiments, toxins');
INSERT INTO "QUICK_ROOM" VALUES (17, 'Broadcasting stage: holocams, props');
INSERT INTO "QUICK_ROOM" VALUES (18, 'Broadcasting stage: holocams, props');
INSERT INTO "QUICK_ROOM" VALUES (19, 'Cellar: mold, dampness, spiderwebs on shelves');
INSERT INTO "QUICK_ROOM" VALUES (20, 'Cellar: mold, dampness, spiderwebs on shelves');
INSERT INTO "QUICK_ROOM" VALUES (21, 'Cold storage: haunches of alien meat');
INSERT INTO "QUICK_ROOM" VALUES (22, 'Cold storage: haunches of alien meat');
INSERT INTO "QUICK_ROOM" VALUES (23, 'Computer room: flickering servers, vent fans');
INSERT INTO "QUICK_ROOM" VALUES (24, 'Computer room: flickering servers, vent fans');
INSERT INTO "QUICK_ROOM" VALUES (25, 'Council chamber: large table, mapboard, records');
INSERT INTO "QUICK_ROOM" VALUES (26, 'Council chamber: large table, mapboard, records');
INSERT INTO "QUICK_ROOM" VALUES (27, 'Crypt: sarcophagi, bones, grave goods');
INSERT INTO "QUICK_ROOM" VALUES (28, 'Crypt: sarcophagi, bones, grave goods');
INSERT INTO "QUICK_ROOM" VALUES (29, 'Dining room: long tables, epergnes, portraits');
INSERT INTO "QUICK_ROOM" VALUES (30, 'Dining room: long tables, epergnes, portraits');
INSERT INTO "QUICK_ROOM" VALUES (31, 'Dormitory: bunks, dividers, common baths');
INSERT INTO "QUICK_ROOM" VALUES (32, 'Dormitory: bunks, dividers, common baths');
INSERT INTO "QUICK_ROOM" VALUES (33, 'Engineering workshop: parts, electricity, scrap');
INSERT INTO "QUICK_ROOM" VALUES (34, 'Engineering workshop: parts, electricity, scrap');
INSERT INTO "QUICK_ROOM" VALUES (35, 'Game room: Table games, nets, flashing baubles');
INSERT INTO "QUICK_ROOM" VALUES (36, 'Game room: Table games, nets, flashing baubles');
INSERT INTO "QUICK_ROOM" VALUES (37, 'Garden: benches, fountains, exotic foliage');
INSERT INTO "QUICK_ROOM" VALUES (38, 'Garden: benches, fountains, exotic foliage');
INSERT INTO "QUICK_ROOM" VALUES (39, 'Great hall: large hearth, tables, raised dais');
INSERT INTO "QUICK_ROOM" VALUES (40, 'Great hall: large hearth, tables, raised dais');
INSERT INTO "QUICK_ROOM" VALUES (41, 'Greenhouse: vegetables, irrigation systems, insects');
INSERT INTO "QUICK_ROOM" VALUES (42, 'Greenhouse: vegetables, irrigation systems, insects');
INSERT INTO "QUICK_ROOM" VALUES (43, 'Icon room: religious paintings, statues, kneelers');
INSERT INTO "QUICK_ROOM" VALUES (44, 'Icon room: religious paintings, statues, kneelers');
INSERT INTO "QUICK_ROOM" VALUES (45, 'Kennel: stink, fur, bones, feeding bowls');
INSERT INTO "QUICK_ROOM" VALUES (46, 'Kennel: stink, fur, bones, feeding bowls');
INSERT INTO "QUICK_ROOM" VALUES (47, 'Kitchen: boiling pots, ovens, numerous knives');
INSERT INTO "QUICK_ROOM" VALUES (48, 'Kitchen: boiling pots, ovens, numerous knives');
INSERT INTO "QUICK_ROOM" VALUES (49, 'Lavatory: sonic showers, nonhuman facilities');
INSERT INTO "QUICK_ROOM" VALUES (50, 'Lavatory: sonic showers, nonhuman facilities');
INSERT INTO "QUICK_ROOM" VALUES (51, 'Lecture hall: podium, seats, holoboard');
INSERT INTO "QUICK_ROOM" VALUES (52, 'Lecture hall: podium, seats, holoboard');
INSERT INTO "QUICK_ROOM" VALUES (53, 'Library: scrolls, dataslabs, codices, massive folios');
INSERT INTO "QUICK_ROOM" VALUES (54, 'Library: scrolls, dataslabs, codices, massive folios');
INSERT INTO "QUICK_ROOM" VALUES (55, 'Lumber room: spare furniture, dropcloths, dust');
INSERT INTO "QUICK_ROOM" VALUES (56, 'Lumber room: spare furniture, dropcloths, dust');
INSERT INTO "QUICK_ROOM" VALUES (57, 'Maintenance closet: mops, cleaning solvents, sinks');
INSERT INTO "QUICK_ROOM" VALUES (58, 'Maintenance closet: mops, cleaning solvents, sinks');
INSERT INTO "QUICK_ROOM" VALUES (59, 'Medical clinic: empty sprayhypos, antiseptic smell');
INSERT INTO "QUICK_ROOM" VALUES (60, 'Medical clinic: empty sprayhypos, antiseptic smell');
INSERT INTO "QUICK_ROOM" VALUES (61, 'Monitoring center: banks of screens, darkness');
INSERT INTO "QUICK_ROOM" VALUES (62, 'Monitoring center: banks of screens, darkness');
INSERT INTO "QUICK_ROOM" VALUES (63, 'Mortuary: embalming tools, canopic jars');
INSERT INTO "QUICK_ROOM" VALUES (64, 'Mortuary: embalming tools, canopic jars');
INSERT INTO "QUICK_ROOM" VALUES (65, 'Museum: display cases, plaques, audio explanations');
INSERT INTO "QUICK_ROOM" VALUES (66, 'Museum: display cases, plaques, audio explanations');
INSERT INTO "QUICK_ROOM" VALUES (67, 'Nursery: toys, brightly-painted walls, cribs');
INSERT INTO "QUICK_ROOM" VALUES (68, 'Nursery: toys, brightly-painted walls, cribs');
INSERT INTO "QUICK_ROOM" VALUES (69, 'Operating theater: overhead lights, tables, scalpels');
INSERT INTO "QUICK_ROOM" VALUES (70, 'Operating theater: overhead lights, tables, scalpels');
INSERT INTO "QUICK_ROOM" VALUES (71, 'Pantry: dusty cannisters, sacks of grain');
INSERT INTO "QUICK_ROOM" VALUES (72, 'Pantry: dusty cannisters, sacks of grain');
INSERT INTO "QUICK_ROOM" VALUES (73, 'Prayer room: icons, kneelers, washbasins');
INSERT INTO "QUICK_ROOM" VALUES (74, 'Prayer room: icons, kneelers, washbasins');
INSERT INTO "QUICK_ROOM" VALUES (75, 'Prison cell: mold, vermin, peeling paint');
INSERT INTO "QUICK_ROOM" VALUES (76, 'Prison cell: mold, vermin, peeling paint');
INSERT INTO "QUICK_ROOM" VALUES (77, 'Quarantine room: cot, bedpan, handwritten will');
INSERT INTO "QUICK_ROOM" VALUES (78, 'Quarantine room: cot, bedpan, handwritten will');
INSERT INTO "QUICK_ROOM" VALUES (79, 'Solarium: transparent aluminum ceiling, plants');
INSERT INTO "QUICK_ROOM" VALUES (80, 'Solarium: transparent aluminum ceiling, plants');
INSERT INTO "QUICK_ROOM" VALUES (81, 'Sparring room: floor mats, practice weapons');
INSERT INTO "QUICK_ROOM" VALUES (82, 'Sparring room: floor mats, practice weapons');
INSERT INTO "QUICK_ROOM" VALUES (83, 'Storeroom: crates, bales, cabinets, chests');
INSERT INTO "QUICK_ROOM" VALUES (84, 'Storeroom: crates, bales, cabinets, chests');
INSERT INTO "QUICK_ROOM" VALUES (85, 'Theater: costumes, stage, secret machinery');
INSERT INTO "QUICK_ROOM" VALUES (86, 'Theater: costumes, stage, secret machinery');
INSERT INTO "QUICK_ROOM" VALUES (87, 'Torture chamber: straps, chemicals, recording gear');
INSERT INTO "QUICK_ROOM" VALUES (88, 'Torture chamber: straps, chemicals, recording gear');
INSERT INTO "QUICK_ROOM" VALUES (89, 'Trophy room: xenolife body parts, plaques, chairs');
INSERT INTO "QUICK_ROOM" VALUES (90, 'Trophy room: xenolife body parts, plaques, chairs');
INSERT INTO "QUICK_ROOM" VALUES (91, 'Unfinished room: bare wiring, stacked paneling');
INSERT INTO "QUICK_ROOM" VALUES (92, 'Unfinished room: bare wiring, stacked paneling');
INSERT INTO "QUICK_ROOM" VALUES (93, 'Vault: Cameras, thick doors, timed locks');
INSERT INTO "QUICK_ROOM" VALUES (94, 'Vault: Cameras, thick doors, timed locks');
INSERT INTO "QUICK_ROOM" VALUES (95, 'Vestibule: coat racks, shoe rests, matting');
INSERT INTO "QUICK_ROOM" VALUES (96, 'Vestibule: coat racks, shoe rests, matting');
INSERT INTO "QUICK_ROOM" VALUES (97, 'Wardrobe: out-of-date clothing, mirrors, shoes');
INSERT INTO "QUICK_ROOM" VALUES (98, 'Wardrobe: out-of-date clothing, mirrors, shoes');
INSERT INTO "QUICK_ROOM" VALUES (99, 'Wellhouse: water filters, tanks, heaters');
INSERT INTO "QUICK_ROOM" VALUES (100, 'Wellhouse: water filters, tanks, heaters');


CREATE TABLE "WORLD_ATMOSPHERE" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR(64) NOT NULL , "desc" CLOB NOT NULL , "short" VARCHAR(32));
INSERT INTO "WORLD_ATMOSPHERE" VALUES (2, 'Corrosive', 'Corrosive atmospheres are dangerously hostile to conventional vacc suits and other protective gear. They steadily strip away at a suit’s vent ports, wiring connections, and other weak spots until they eventually break through and flood the suit with a toxic cocktail that usually kills a victim in seconds. Weak atmospheres might require as much as a day to degrade a vacc suit, while strong ones might accomplish the job in an hour. Even forcefield-based environment suits such as a FEP suffer steady damage to their exposed elements.
Native vacc suits are usually covered with an ablative layer or spray that can be regularly renewed, and their buildings often rely on a steadily-extruded slurry or neutralizing materials that can be constantly renewed by pores in the building surface itself. This often gives the building a drippy, half-melted look that may be more than cosmetic in the case of those structures that have failing slurry pumps. Advanced tech level 5 equipment may be able to overcome the effects, but even pretech is often taxed by the relentless rigors of this world. Vehicles and shuttles are kept in pressurized garages when not in use, and starships never land for long.
Corrosive worlds have a number of intrinsic adventure complications, the largest being the way that every activity outside of a hab building comes with a built-in time limit. Whatever the party chooses to do outside of a building, it has to accomplish before their suit seals fail or the atmosphere corrodes a hole in their vehicle hull. A clever GM can use this problem to add extra tension to an otherwise simple task.', 'Corrosive');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (3, 'Inert gas', 'Inert gas atmospheres aren’t hostile or poisonous, but they’re unbreathable by humans. If the planet’s climate is otherwise tolerable, the natives might be able to live and work outdoors without anything more than an air tank and face mask. Some degree of technical sophistication is going to be necessary for humanity to survive, and large supplies of oxygen are going to have to be extracted from some local source. "Air mines" might exist to replace the oxygen lost during human use, or local power plants might need to be kept running full blast in order to crack water molecules into hydrogen and oxygen.
On worlds with an unbreathable atmosphere, control of the air supply makes it much harder for locals to rebel against their leaders. Without the equipment and power to generate their own air supplies, would-be rebels are entirely at the mercy of those who control the oxygen. Most rulers pick up on this fact rapidly, and some worlds with unbreathable atmospheres might even make it a crime to own illicit oxygen generation equipment.', 'Inert');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (4, 'Airless / thin atmosphere', 'Airless or thin atmospheres are appropriate to asteroids, rocky planetoids, ot barren worlds that have had their atmospheres burnt off by weapons or cosmic caprice. Whatever atmosphere exists is too thin to support human life, if it exists at all, and the world is largely naked to the chill of space and the blaze of stellar heat. Exposure to the planet’s surface without a vacc suit or pressurized building is as lethal as exposure to hard vacuum.
Airless worlds are hostile to human life, but they excel at preserving the relics of the past. Provided that the ruins or remains are kept out of the baking heat of the local stellar body and the impact of random meteorites, they can survive for millions of years. Some exceptionally ancient alien ruins might even date back from before the world lost its atmosphere.', 'Airless');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (5, 'Breathable mix', 'Breathable mix atmospheres can support human life without additional equipment or gengineered modification. Any world that has a human population in the millions or more almost certainly has a breathable mix atmosphere.
While the air is breathable, almost every world has its own subtle cocktail of inert gases, atmospheric contaminants, and other odiferous ingredients. For spacers accustomed to the filtered air supply of a starship, the “new world stink” of a fresh planetfall can be maddening, as few linger long enough to get used to the smell of the local air. Attempting to explain the source of this discomfort to the locals rarely results in positive results. Some spaceport bars make a point of their air filtration and composition mixers.', 'Breathable');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (6, 'Breathable mix', 'Breathable mix atmospheres can support human life without additional equipment or gengineered modification. Any world that has a human population in the millions or more almost certainly has a breathable mix atmosphere.
While the air is breathable, almost every world has its own subtle cocktail of inert gases, atmospheric contaminants, and other odiferous ingredients. For spacers accustomed to the filtered air supply of a starship, the “new world stink” of a fresh planetfall can be maddening, as few linger long enough to get used to the smell of the local air. Attempting to explain the source of this discomfort to the locals rarely results in positive results. Some spaceport bars make a point of their air filtration and composition mixers.', 'Breathable');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (7, 'Breathable mix', 'Breathable mix atmospheres can support human life without additional equipment or gengineered modification. Any world that has a human population in the millions or more almost certainly has a breathable mix atmosphere.
While the air is breathable, almost every world has its own subtle cocktail of inert gases, atmospheric contaminants, and other odiferous ingredients. For spacers accustomed to the filtered air supply of a starship, the “new world stink” of a fresh planetfall can be maddening, as few linger long enough to get used to the smell of the local air. Attempting to explain the source of this discomfort to the locals rarely results in positive results. Some spaceport bars make a point of their air filtration and composition mixers.', 'Breathable');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (8, 'Breathable mix', 'Breathable mix atmospheres can support human life without additional equipment or gengineered modification. Any world that has a human population in the millions or more almost certainly has a breathable mix atmosphere.
While the air is breathable, almost every world has its own subtle cocktail of inert gases, atmospheric contaminants, and other odiferous ingredients. For spacers accustomed to the filtered air supply of a starship, the “new world stink” of a fresh planetfall can be maddening, as few linger long enough to get used to the smell of the local air. Attempting to explain the source of this discomfort to the locals rarely results in positive results. Some spaceport bars make a point of their air filtration and composition mixers.', 'Breathable');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (9, 'Breathable mix', 'Breathable mix atmospheres can support human life without additional equipment or gengineered modification. Any world that has a human population in the millions or more almost certainly has a breathable mix atmosphere.
While the air is breathable, almost every world has its own subtle cocktail of inert gases, atmospheric contaminants, and other odiferous ingredients. For spacers accustomed to the filtered air supply of a starship, the “new world stink” of a fresh planetfall can be maddening, as few linger long enough to get used to the smell of the local air. Attempting to explain the source of this discomfort to the locals rarely results in positive results. Some spaceport bars make a point of their air filtration and composition mixers.', 'Breathable');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (10, 'Thick atmosphere; need pressure mask', 'Thick atmospheres can usually be breathed with the aid of a filter mask, though the mix of contaminants renders it slowly or quickly toxic to humans who attempt to breathe it straight. Separate air supplies are not necessary to supplement the blend, but any society that means to survive on such a world must have sufficient technological expertise to manufacture and maintain large numbers of filter masks.
Thick atmospheres are often at least semi-opaque, and some worlds have thick atmospheres that are completely impenetrable to ordinary light. Deep banks of permanent fog might shroud the planet, or natives might have to go about with sophisticated ultraviolet or infrared viewing equipment if they don’t wish to be blind. Some banks of gases might be impenetrable to even these viewing tools, leaving a party vulnerable to moments of complete blindness while out on the surface of the world.', 'Thick');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (11, 'Invasive, toxic atmosphere', 'Invasive toxic atmospheres are composed of a substantial proportion of molecules small enough to infiltrate past the seals of most vacc suits. This infiltration doesn’t harm the suit, but the molecules have to be steadily flushed by the system’s purification sensors before they build up to a debilitating level. This causes a much faster bleed of air as breathable oxygen is jettisoned along with the infiltrating molecules. Most invasive atmospheres cut oxygen supply durations by half, at best.
Invasive atmospheres make oxygen an even more important resource than it is on inert gas worlds. Outdoor work is avoided whenever possible, as any failure of a suit’s toxin sensors or flush system can lead to death before the wearer even realizes something is wrong. Steady exposure to low levels of the toxins can also result in unfortunate effects even with a fully-functional suit. Hallucinations, chronic sickness, or worse can follow.', 'Invasive');
INSERT INTO "WORLD_ATMOSPHERE" VALUES (12, 'Corrosive and invasive atmosphere', 'Corrosive and invasive atmospheres exist at the very border of what human society can tolerate. Combining all the worst traits of an eroding, corrosive atmosphere and the invasive intrusion of toxic molecules, a planet cursed with an atmosphere like this is far more hostile than any merely airless rock.
Advanced pretech filtering and oxygen generation equipment might be able to maintain tolerable pressurized habitats and hydroponic systems uncontaminated by exterior atmosphere. Anything less than this tech level means greater and greater amounts of societal resources devoted simply to the effort of breathing. Entire civilizations can be oriented around overcoming the difficulties of maintaining their structures and their pressurized homes.
Whatever provoked the initial inhabitants to settle on this world must have been of overwhelming value or necessity to convince them to consign themselves and their children to such a place. It is highly unlikely that enough ship traffic exists to get any but the most fortunate locals offworld, so the rest are obliged to deal with their harsh existence as best they can.', 'Corr / Inv');


CREATE TABLE "WORLD_BIOSPHERE" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR(64) NOT NULL , "desc" CLOB NOT NULL , "short" VARCHAR(32));
INSERT INTO "WORLD_BIOSPHERE" VALUES (2, 'Biosphere remnants', 'Biosphere remnants are the wreckage of a ruined ecology. Petrified trees, drifts of preserved bones, forests of dead plant life; something killed all the life on this planet in the relatively recent past. It may have been the exercise of a maltech planet-buster weapon, or a mutant microbe introduced by human colonists, or some volcanic eruption or asteroid impact that plunged the world into decades of frozen night.
Any local civilization not sophisticated enough to escape the planet likely died when it did. Their ruins and remains might be found throughout the desolate wastes, along with more clues as to the cause of the devastation.', 'Remnants');
INSERT INTO "WORLD_BIOSPHERE" VALUES (3, 'Microbial life', 'Microbial life is often the only thing that exists on the more inhospitable planets, yet the wide variety of environments that can accommodate life means that these little beasts show up in some of the most unlikely places. Some varieties of slime mold have even managed to evolve on corrosive-atmosphere planets, forming a mucous-like outer shell against the atmosphere and then feeding and growing off the chemical byproducts of its erosion.
Microbial life can also be dangerous. While most alien microbes are unable to infect or harm the radically different biology of humans, some show enough ingenuity to accomplish even that difficult feat. Rumors of terrible “space plagues” that leave behind only drifting ships and garbled warnings remain a steady staple at spacer bars throughout the known universe.', 'Microbial');
INSERT INTO "WORLD_BIOSPHERE" VALUES (4, 'No native biosphere', 'No native biosphere is occasionally found on even the most temperate and otherwise habitable worlds. For one reason or another, life simply never evolved on these worlds, leaving them a blank slate for the agricultural and ecological efforts of humans. If the world is otherwise amenable to Terran life, such planets can be enormously fertile and agriculturally rich.
They can also be disasters waiting to happen. Pretech xenobiologists compiled standardized colonization packages of plants, animals, and insect life designed to expand smoothly and evenly to fill the niches of an uninhabited world. Not all colonists implemented these packages correctly, and some worlds had disasters or special circumstances that destabilized their efforts. Some empty worlds are now in a state of constant biological flux as the local ecology strives vainly to find some sort of equilibrium between the myriad imported species.
More subtly, these worlds can be suddenly and drastically destabilized by the import of some offworld plant or animal. With no strong native ecology to fight off interlopers, the wrong beast or bug can lay waste to whole continents. These planets tend to be extremely paranoid about importation of foreign life forms.', 'None');
INSERT INTO "WORLD_BIOSPHERE" VALUES (5, 'No native biosphere', 'No native biosphere is occasionally found on even the most temperate and otherwise habitable worlds. For one reason or another, life simply never evolved on these worlds, leaving them a blank slate for the agricultural and ecological efforts of humans. If the world is otherwise amenable to Terran life, such planets can be enormously fertile and agriculturally rich.
They can also be disasters waiting to happen. Pretech xenobiologists compiled standardized colonization packages of plants, animals, and insect life designed to expand smoothly and evenly to fill the niches of an uninhabited world. Not all colonists implemented these packages correctly, and some worlds had disasters or special circumstances that destabilized their efforts. Some empty worlds are now in a state of constant biological flux as the local ecology strives vainly to find some sort of equilibrium between the myriad imported species.
More subtly, these worlds can be suddenly and drastically destabilized by the import of some offworld plant or animal. With no strong native ecology to fight off interlopers, the wrong beast or bug can lay waste to whole continents. These planets tend to be extremely paranoid about importation of foreign life forms.', 'None');
INSERT INTO "WORLD_BIOSPHERE" VALUES (6, 'Human-miscible biosphere', 'Human-miscible biospheres are those in which some substantial portion of the native life is biologically compatible with human nutritional needs. The local plants and animals may not be tasty or terribly nourishing, but they can support life without the serious importation of Terran crop seeds and livestock.
Even the friendlier human-miscible biospheres often lack the wide variety of edibles that evolved on Earth, and the natives often supplement their stocks of local foods with limited Terran agriculture. Exotic foods, spices, and liquors can be worth interstellar importation to feed the hunger for novelty on these worlds.
Unfortunately, the fact that humans can eat some native life means that it is very likely that some native life can eat humans in turn. Large predators and diseases capable of human infection are by no means uncommon on these worlds, and small colonies can be hard- pressed to survive them.', 'Miscible');
INSERT INTO "WORLD_BIOSPHERE" VALUES (7, 'Human-miscible biosphere', 'Human-miscible biospheres are those in which some substantial portion of the native life is biologically compatible with human nutritional needs. The local plants and animals may not be tasty or terribly nourishing, but they can support life without the serious importation of Terran crop seeds and livestock.
Even the friendlier human-miscible biospheres often lack the wide variety of edibles that evolved on Earth, and the natives often supplement their stocks of local foods with limited Terran agriculture. Exotic foods, spices, and liquors can be worth interstellar importation to feed the hunger for novelty on these worlds.
Unfortunately, the fact that humans can eat some native life means that it is very likely that some native life can eat humans in turn. Large predators and diseases capable of human infection are by no means uncommon on these worlds, and small colonies can be hard- pressed to survive them.', 'Miscible');
INSERT INTO "WORLD_BIOSPHERE" VALUES (8, 'Human-miscible biosphere', 'Human-miscible biospheres are those in which some substantial portion of the native life is biologically compatible with human nutritional needs. The local plants and animals may not be tasty or terribly nourishing, but they can support life without the serious importation of Terran crop seeds and livestock.
Even the friendlier human-miscible biospheres often lack the wide variety of edibles that evolved on Earth, and the natives often supplement their stocks of local foods with limited Terran agriculture. Exotic foods, spices, and liquors can be worth interstellar importation to feed the hunger for novelty on these worlds.
Unfortunately, the fact that humans can eat some native life means that it is very likely that some native life can eat humans in turn. Large predators and diseases capable of human infection are by no means uncommon on these worlds, and small colonies can be hard- pressed to survive them.', 'Miscible');
INSERT INTO "WORLD_BIOSPHERE" VALUES (9, 'Immiscible biosphere', 'Immiscible biospheres are not friendly to humans. None of the local plants or animals are edible, and anything the colony needs to eat will have to be grown from Terran stock. Worse, it is common for the pollen and other microbial life of these worlds to be highly allergenic to humans, requiring the regular use of tailored antiallergenics to prevent eventual respiratory failure.
These worlds are exceptionally susceptible to the temptation of human gengineering. Despite the persistent drawbacks, genetic flaws, and handicaps that human gengineering usually introduces in a subject, the desperate need to eat can drive worlds to wholesale experimentation on their progeny. The resultant altered humans are often able to digest the local food, but commonly pay for it in shortened life spans, physical disabilities, or an inability to consume Terran foodstuffs.
Immiscible biospheres produce some of the most exotic plants and animals in human space. Unfettered by the limits of familiar evolutionary patterns, creatures of bizarre beauty and strange configurations are found on many of these worlds. Many lack the intelligence to realize that humans are as poisonous to them as they are to humans.', 'Immiscible');
INSERT INTO "WORLD_BIOSPHERE" VALUES (10, 'Immiscible biosphere', 'Immiscible biospheres are not friendly to humans. None of the local plants or animals are edible, and anything the colony needs to eat will have to be grown from Terran stock. Worse, it is common for the pollen and other microbial life of these worlds to be highly allergenic to humans, requiring the regular use of tailored antiallergenics to prevent eventual respiratory failure.
These worlds are exceptionally susceptible to the temptation of human gengineering. Despite the persistent drawbacks, genetic flaws, and handicaps that human gengineering usually introduces in a subject, the desperate need to eat can drive worlds to wholesale experimentation on their progeny. The resultant altered humans are often able to digest the local food, but commonly pay for it in shortened life spans, physical disabilities, or an inability to consume Terran foodstuffs.
Immiscible biospheres produce some of the most exotic plants and animals in human space. Unfettered by the limits of familiar evolutionary patterns, creatures of bizarre beauty and strange configurations are found on many of these worlds. Many lack the intelligence to realize that humans are as poisonous to them as they are to humans.', 'Immiscible');
INSERT INTO "WORLD_BIOSPHERE" VALUES (11, 'Hybrid biosphere', 'Hybrid biospheres are a stable intermixing of Terran flora and fauna with local life forms. Most such worlds have been colonized for centuries before the Silence, giving the local ecology time to shake out into a relatively stable configuration of Earth-born organisms and native life. The native biology may or may not be miscible with human life, but it unlikely to be particularly hostile in any case, or else the interloping life forms would not have been able to get a foothold on the planet.
Hybrid biospheres often show strange examples of symbiosis and adaptation, with plants and animals forming new alliances. Large predators from one world may find themselves subsisting on herds of herbivorous alien life, while Terran vegetation provides sustenance for large populations of small, furred, insect-like grazers. Familiar animals may show seemingly bizarre behavior patterns that have formed in response to local conditions, perhaps becoming larger or more aggressive.', 'Hybrid');
INSERT INTO "WORLD_BIOSPHERE" VALUES (12, 'Engineered biosphere', 'Engineered biospheres are among the rarest, as they require enormous time and effort on the part of a highly advanced civilization. Whatever life exists on this planet has been extensively altered by an alien race or by advanced pretech gengineering methods. Some such worlds are paradise planets, carefully sculpted by some fabulously wealthy predecessor to suit their own tastes. Others are living forges, where foodstuffs and refined minerals are produced as byproducts from the basic organic processes of the world’s biosphere.
Such worlds tend to be fragile. Many engineered worlds are dependent upon regular stabilizing work to prevent genetic drift and adaptations that do not serve the creator’s purpose. Without regular pruning and adjustment, engineered biospheres can go badly awry. Some end up leaving nothing but genetic wreckage in their wake, while others go wrong in more subtle ways. Where once the biosphere existed to serve the inhabitants, a creaking engineered biosphere can leave the planet’s population chained to constant repair and maintenance efforts just to prevent a planetary collapse.', 'Engineered');


CREATE TABLE "WORLD_POPULATION" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR(64) NOT NULL , "desc" CLOB NOT NULL , "short" VARCHAR(32));
INSERT INTO "WORLD_POPULATION" VALUES (2, 'Failed colony', 'Failed colonies are occasionally found dotting the worlds of human space. Some date back to the First Wave of human colonization more than a thousand years ago, while others are more recent efforts that guttered out under the strains of a colony’s birth.
Pirate attacks might have wiped out a young colony, as might a hostile biosphere, alien attack, internal dissension, disease outbreaks, failure of vital colonial equipment, or any one of a hundred other disasters. The ruins of the colony might still have valuable pretech artifacts, however, or colonization deeds authorized by neighboring worlds. A few survivors might even have clung to life in the intervening centuries, maintaining some sort of society in the wreckage of their ancestors’ work.', 'Failed');
INSERT INTO "WORLD_POPULATION" VALUES (3, 'Outpost', 'Outposts are rarely composed of more than a few hundred or few thousand colonists at the most. Outposts are either very new colonies that have not have the requisite time to grow or they are uncolonized worlds that just happen to have a naval or corporate base on the surface.
Corporate or military outposts aren’t intended to be completely self- sufficient. While large outposts are often forced to raise their own food supplies, replacement personnel, spare parts, and advanced tech must all be brought in from elsewhere. Such temporary outposts are known to find themselves in sudden distress when a vital supply ship fails to make its drop or when some local threat proves more than the staff can handle.
Colonial outposts tend to be better equipped but with less outside backing. Such natives expect to live and die on the world, and are more inclined to build permanent structures and local improvements. Many are exiles, malcontents, or others incapable of tolerating the world that sent them forth, and it can make for a somewhat explosive mix in a young colony. These pioneers tend to be very friendly towards visiting starships, as they are often dependent upon free traders and tramp merchants to bring them vital supplies or news of the sector.
Some “outposts” are really just the stubborn, persistent survivors of a long-failed colonization attempt. These cultures can survive for centuries, perpetually culled by the dangers of the world until the survivors are little more than one more element of the local ecology.', 'Outpost');
INSERT INTO "WORLD_POPULATION" VALUES (4, 'Tens of thousands of inhabitants', 'Tens of thousands of inhabitants are often found on newly-colonized worlds, or those with limited arable land. With such a small population, most settlements tend to be clustered close to one another for mutual support and efficient exploitation of land. The atmosphere can be something like that of a village-dotted countryside, with too few people to support large, specialized cities. The major settlement of the planet is usually built around the spaceport.
Politics on planets with so few people tend to be very personal in nature. Individual leaders can address the entire population of a world at a single meeting, and networks of family, friends, and employees can dominate the local social life. This small population combined with limited outside contact can result in somewhat... unusual societies more strongly influenced by a leader’s personal quirks than a more populous planet might be. Some such worlds can grow decidedly unhealthy in their customs and traditions.', '10K+');
INSERT INTO "WORLD_POPULATION" VALUES (5, 'Tens of thousands of inhabitants', 'Tens of thousands of inhabitants are often found on newly-colonized worlds, or those with limited arable land. With such a small population, most settlements tend to be clustered close to one another for mutual support and efficient exploitation of land. The atmosphere can be something like that of a village-dotted countryside, with too few people to support large, specialized cities. The major settlement of the planet is usually built around the spaceport.
Politics on planets with so few people tend to be very personal in nature. Individual leaders can address the entire population of a world at a single meeting, and networks of family, friends, and employees can dominate the local social life. This small population combined with limited outside contact can result in somewhat... unusual societies more strongly influenced by a leader’s personal quirks than a more populous planet might be. Some such worlds can grow decidedly unhealthy in their customs and traditions.', '10K+');
INSERT INTO "WORLD_POPULATION" VALUES (6, 'Hundreds of thousands of inhabitants', 'Hundreds of thousands of inhabitants make up the population of most frontier worlds, usually ones with adequate supplies of arable land and surface conditions amenable to a human without a vacc suit or filter mask. This level of population is also usually the most that a world at tech level 4 can support using only artificial hydroponic complexes and sealed agricultural systems, so less hospitable planets rarely have more than this many inhabitants.
At this level of population, city-states and hub settlements start to form, and some political divisions might exist beneath the overall planetary government. Regional variations start to become present as towns and smaller settlements start to assert their own cultural traits. Young colonies rarely have much of a framework for resolving these new tensions, and it’s not uncommon for outsiders to end up as catspaws for varying factions.
This level of population is normally the smallest that can create spike drive-equipped starships. Less populous worlds rarely have the broad range of specialists and workers necessary to build such ships, even if they possess the necessary technical information.', '100K+');
INSERT INTO "WORLD_POPULATION" VALUES (7, 'Hundreds of thousands of inhabitants', 'Hundreds of thousands of inhabitants make up the population of most frontier worlds, usually ones with adequate supplies of arable land and surface conditions amenable to a human without a vacc suit or filter mask. This level of population is also usually the most that a world at tech level 4 can support using only artificial hydroponic complexes and sealed agricultural systems, so less hospitable planets rarely have more than this many inhabitants.
At this level of population, city-states and hub settlements start to form, and some political divisions might exist beneath the overall planetary government. Regional variations start to become present as towns and smaller settlements start to assert their own cultural traits. Young colonies rarely have much of a framework for resolving these new tensions, and it’s not uncommon for outsiders to end up as catspaws for varying factions.
This level of population is normally the smallest that can create spike drive-equipped starships. Less populous worlds rarely have the broad range of specialists and workers necessary to build such ships, even if they possess the necessary technical information.', '100K+');
INSERT INTO "WORLD_POPULATION" VALUES (8, 'Hundreds of thousands of inhabitants', 'Hundreds of thousands of inhabitants make up the population of most frontier worlds, usually ones with adequate supplies of arable land and surface conditions amenable to a human without a vacc suit or filter mask. This level of population is also usually the most that a world at tech level 4 can support using only artificial hydroponic complexes and sealed agricultural systems, so less hospitable planets rarely have more than this many inhabitants.
At this level of population, city-states and hub settlements start to form, and some political divisions might exist beneath the overall planetary government. Regional variations start to become present as towns and smaller settlements start to assert their own cultural traits. Young colonies rarely have much of a framework for resolving these new tensions, and it’s not uncommon for outsiders to end up as catspaws for varying factions.
This level of population is normally the smallest that can create spike drive-equipped starships. Less populous worlds rarely have the broad range of specialists and workers necessary to build such ships, even if they possess the necessary technical information.', '100K+');
INSERT INTO "WORLD_POPULATION" VALUES (9, 'Millions of inhabitants', 'Millions of inhabitants are found on some of the more populous frontier worlds, those planets with an excellent climate and soil for agriculture. These worlds teem with human life compared to most of their neighbors, and if they have sufficient technological expertise to build spike drives, they probably are one of the more powerful planets in the sector. The sheer amount of labor and expertise they can put into their projects dwarfs the capabilities of most other worlds.
Some worlds of this type fail to coalesce under a unified planetary government, however, and turn most of their attention to intra- planetary quarrels between different nations or city-states. Full-scale planetary wars have been known to break out on such worlds, with some being reduced to burnt-out cinders by some maltech weapon or by nuclear attacks against regions stripped of their nuke snuffers.', '1M+');
INSERT INTO "WORLD_POPULATION" VALUES (10, 'Millions of inhabitants', 'Millions of inhabitants are found on some of the more populous frontier worlds, those planets with an excellent climate and soil for agriculture. These worlds teem with human life compared to most of their neighbors, and if they have sufficient technological expertise to build spike drives, they probably are one of the more powerful planets in the sector. The sheer amount of labor and expertise they can put into their projects dwarfs the capabilities of most other worlds.
Some worlds of this type fail to coalesce under a unified planetary government, however, and turn most of their attention to intra- planetary quarrels between different nations or city-states. Full-scale planetary wars have been known to break out on such worlds, with some being reduced to burnt-out cinders by some maltech weapon or by nuclear attacks against regions stripped of their nuke snuffers.', '1M+');
INSERT INTO "WORLD_POPULATION" VALUES (11, 'Billions of inhabitants', 'Billions of inhabitants on a world is a freak occurrence in most sectors, a circumstance dependent on almost perfect planetary conditions, a First Wave date of colonization, and a very large initial colonial expedition. These worlds have been colonized for almost a thousand years, and have likely gone through substantial cultural development and change since the original founding.
Planets with this many inhabitants tend to come in two main varieties. The more common is that of regional hegemon, leveraging its enormous reserves of labor and scientific personnel to build hundreds or thousands of starships. Some hegemons might even have the transport weight and personnel available to colonize or conquer their less powerful neighbors outright, though most hegemons prefer the safer route of docile client states rather than outright conquests.
Not all such worlds have the necessary resources to build starships, even when the labor is cheap and abundant. These worlds tend to take a different route, becoming balkanized, conflict-torn planets not unlike a mid-20th-century Earth. Resource wars are common and local politics revolve around Byzantine feuds and ancient slights. Technology on such planets tends to be very uneven; it is limited or nonexistent in fields that depend on unavailable resources, but the natives often show remarkable sophistication in making the most of what they have available.', '1B+');
INSERT INTO "WORLD_POPULATION" VALUES (12, 'Alien civilization', 'Alien civilizations are even rarer than massively human-populated planets, but they can be found in some sectors. On these worlds, any human presence is either nonexistent or simply a token contingent of traders and diplomats. The actual number of aliens may range from a few tens of thousands to teeming worlds of billions.
Alien civilizations appear to be no more immune to conflict, disaster, and decadence than that of humans, and most alien worlds are isolated planets. Some sectors were known to be dominated by alien empires before the Scream, but most inhabited worlds found by colonial surveyors consisted of indigenous, low-tech sapients who evolved on the world, or else were the decaying remnants of a former empire that had fallen apart into isolated colonial worlds.
This fate of growth, expansion, colonization, and collapse appears to be a very common event in the galaxy. Countless alien ruins and lost deep-space artifacts indicate that cycles of growth and decay have been going on for millennia, and there is little way to tell how many alien empires have swept over what is now human space before dwindling to decaying worlds and then empty ruins.
Aliens on a decaying colony are likely to be too burdened by the weight of history and dissolution to be aggressive, but may retain dangerously sophisticated devices and scientific expertise. Newly- rising native sophonts may be more interested in reaching the stars, and their ships might well share the spacelanes with the starships of humankind.', 'Alien');


CREATE TABLE "WORLD_TAG" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR(64) NOT NULL , "desc" CLOB NOT NULL , "enemies" CLOB NOT NULL , "friends" CLOB NOT NULL , "complications" CLOB NOT NULL , "things" CLOB NOT NULL , "places" CLOB NOT NULL , "short" VARCHAR(32));
INSERT INTO "WORLD_TAG" VALUES (101, 'Abandoned Colony', 'The world once hosted a colony, whether human or otherwise, until some crisis or natural disaster drove the inhabitants away or killed them off. The colony might have been mercantile in nature, an expedition to extract valuable local resources, or it might have been a reclusive cabal of zealots. The remains of the colony are usually in ruins, and might still be dangerous from the aftermath of whatever destroyed it in the first place.', 'Crazed survivors, Ruthless plunderers of the ruins, Automated defense system', 'Inquisitive stellar archaeologist, Heir to the colony''s property, Local wanting the place cleaned out', 'The local government wants the ruins to remain a secret, The locals claim ownership of it, The colony is crumbling and dangerous to navigate', 'Long-lost property deeds, Relic stolen by the colonists when they left, Historical record of the colonization attempt', 'Decaying habitation block, Vine-covered town square, Structure buried by an ancient landslide', 'Abandoned');
INSERT INTO "WORLD_TAG" VALUES (102, 'Ancient Ruins', 'The world has significant alien ruins present. The locals may or may not permit others to investigate the ruins, and may make it difficult to remove any objects of value without substantial payment.', 'Customs inspector, Worshipper of the ruins, Hidden alien survivor', 'Curious scholar, Avaricious local resident, Interstellar smuggler', 'Traps in the ruins, Remote location, Paranoid customs officials', 'Precious alien artifacts, Objects left with the remains of a prior unsuccessful expedition, Untranslated alien texts, Untouched hidden ruins', 'Undersea ruin, Orbital ruin, Perfectly preserved alien building, Alien mausoleum', 'Ruins');
INSERT INTO "WORLD_TAG" VALUES (103, 'Altered Humanity', 'The humans on this world are visibly and drastically different from normal humanity. They may have additional limbs, new sensory organs, or other significant changes. Were these from ancestral eugenic manipulation, or from environmental toxins?', 'Biochauvinist local, Local experimenter, Mentally unstable mutant', 'Local seeking a "cure", Curious xenophiliac, Anthropological researcher', 'Alteration is contagious, Alteration is necessary for long-term survival, Locals fear and mistrust non-local humans', 'Original pretech mutagenic equipment, Valuable biological byproduct from the mutants, "Cure" for the altered genes, Record of the original colonial genotypes', 'Abandoned eugenics laboratory, An environment requiring the mutation for survival, A sacred site where the first local was transformed', 'Altered Hum.');
INSERT INTO "WORLD_TAG" VALUES (104, 'Area 51', 'The world’s government is fully aware of their local stellar neighbors, but the common populace has no idea about it- and the government means to keep it that way. Trade with government officials in remote locations is possible, but any attempt to clue the commoners in on the truth will be met with lethal reprisals.', 'Suspicious government minder, Free merchant who likes his local monopoly, Local who wants a specimen for dissection', 'Crusading offworld investigator, Conspiracy-theorist local, Idealistic government reformer', 'The government has a good reason to keep the truth concealed, The government ruthlessly oppresses the natives, The government is actually composed of offworlders', 'Elaborate spy devices, Memory erasure tech, Possessions of the last offworlder who decided to spread the truth', 'Desert airfield, Deep subterranean bunker, Hidden mountain valley', NULL);
INSERT INTO "WORLD_TAG" VALUES (105, 'Badlands World', 'Whatever the ostensible climate and atmosphere type, something horrible happened to this world. Biological, chemical, or nanotechnical weaponry has reduced it to a wretched hellscape.', 'Mutated badlands fauna, Desperate local, Badlands raider chief', 'Native desperately wishing to escape the world, Scientist researching ecological repair methods, Ruin scavenger', 'Radioactivity, Bioweapon traces, Broken terrain, Sudden local plague', 'Maltech research core, Functional pretech weaponry, An uncontaminated well', 'Untouched oasis, Ruined city, Salt flat', 'Badlands');
INSERT INTO "WORLD_TAG" VALUES (106, 'Bubble Cities', 'Whether due to a lack of atmosphere or an uninhabitable climate, the world’s cities exist within domes or pressurized buildings. In such sealed environments, techniques of surveillance and control can grow baroque and extreme.', 'Native dreading outsider contamination, Saboteur from another bubble city, Local official hostile to outsider ignorance of laws', 'Local rebel against the city officials, Maintenance chief in need of help, Surveyor seeking new building sites', 'Bubble rupture, Failing atmosphere reprocessor, Native revolt against officials, All-seeing surveillance cameras', 'Pretech habitat technology, Valuable industrial products, Master key codes to a city''s security system', 'City power core, Surface of the bubble, Hydroponics complex, Warren-like hab block', NULL);
INSERT INTO "WORLD_TAG" VALUES (107, 'Civil War', 'The world is currently torn between at least two opposing factions, all of which claim legitimacy. The war may be the result of a successful rebel uprising against tyranny, or it might just be the result of schemers who plan to be the new masters once the revolution is complete.', 'Faction commissar, Angry native, Conspiracy theorist who blames offworlders for the war, Deserter looking out for himself, Guerilla bandits', 'Faction loyalist seeking aid, Native caught in the crossfire, Offworlder seeking passage off the planet', 'The front rolls over the group, Famine strikes, Bandit infestations', 'Ammo dump, Military cache, Treasure buried for after the war, Secret war plans', 'Battle front, Bombed-out town, Rear-area red light zone, Propaganda broadcast tower', NULL);
INSERT INTO "WORLD_TAG" VALUES (108, 'Cold War', 'Two or more great powers control the planet, and they have a hostility to each other that’s just barely less than open warfare. The hostility might be ideological in nature, or it might revolve around control of some local resource.', 'Suspicious chief of intelligence, Native who thinks the outworlders are with the other side, Femme fatale', 'Apolitical information broker, Spy for the other side, Unjustly accused innocent, "He''s a bastard, but he''s our bastard" official', 'Police sweep, Low-level skirmishing, "Red scare"', 'List of traitors in government, secret military plans, Huge cache of weapons built up in preparation for war', 'Seedy bar in a neutral area, Political rally, Isolated area where fighting is underway', NULL);
INSERT INTO "WORLD_TAG" VALUES (109, 'Colonized Population', 'A neighboring world has successfully colonized this less-advanced or less-organized planet, and the natives aren’t happy about it. A puppet government may exist, but all real decisions are made by the local viceroy.', 'Suspicious security personnel, Offworlder-hating natives, Local crime boss preying on rich offworlders', 'Native resistance leader, Colonial official seeking help, Native caught between the two sides', 'Natives won''t talk to offworlders, Colonial repression, Misunderstood local customs', 'Relic of the resistance movement, List of collaborators, Precious substance extracted by colonial labor', 'Deep wilderness resistance camp, City district off-limits to natives, Colonial labor site', 'Colonized');
INSERT INTO "WORLD_TAG" VALUES (110, 'Desert World', 'The world may have a breathable atmosphere and a human-tolerable temperature range, but it is an arid, stony waste outside of a few places made habitable by human effort. The deep wastes are largely unexplored and inhabited by outcasts and worse.', 'Raider chieftain, Crazed hermit, Angry isolationists, Paranoid mineral prospector, Strange desert beast', 'Native guide, Research biologist, Aspiring terraformer', 'Sandstorms, Water supply failure, Native warfare over water rights', 'Enormous water reservoir, Map of hidden wells, Pretech rainmaking equipment', 'Oasis, "The Empty Quarter" of the desert, Hidden underground cistern', NULL);
INSERT INTO "WORLD_TAG" VALUES (201, 'Eugenic Cult', 'Even in the days before the Silence, major improvement of the human genome always seemed to come with unacceptable side-effects. Some worlds host secret cults that perpetuate these improvements regardless of the cost, and a few planets have been taken over entirely by the cults.', 'Eugenic superiority fanatic, Mentally unstable homo superior, Mad eugenic scientist', 'Eugenic propagandist, Biotechnical investigator, Local seeking revenge on cult', 'The altered cultists look human, The locals are terrified of any unusual physical appearance, The genetic modifications- and drawbacks- are contagious with long exposure', 'Serum that induces the alteration, Elixir that reverses the alteration, Pretech biotechnical databanks, List of secret cult sympathizers', 'Eugenic breeding pit, Isolated settlement of altered humans, Public place infiltrated by cult sympathizers', NULL);
INSERT INTO "WORLD_TAG" VALUES (202, 'Exchange Consulate', 'The Exchange of Light once served as the largest, most trusted banking and diplomatic service in human space. Even after the Silence, some worlds retain a functioning Exchange Consulate where banking services and arbitration can be arranged.', 'Corrupt Exchange official, Indebted native who thinks the players are Exchange agents, Exchange official dunning the players for debts incurred', 'Consul in need of offworld help, Local banker seeking to hurt his competition, Exchange diplomat', 'The local Consulate has been corrupted, the Consulate is cut off from its funds, A powerful debtor refuses to pay', 'Exchange vault codes, Wealth hidden to conceal it from a bankruptcy judgment, Location of forgotten vault', 'Consulate meeting chamber, Meeting site between fractious disputants, Exchange vault', 'Exch. Cons.');
INSERT INTO "WORLD_TAG" VALUES (203, 'Feral World', 'In the long, isolated night of the Silence, some worlds have experienced total moral and cultural collapse. Whatever remains has been twisted beyond recognition into assorted death cults, xenophobic fanaticism, horrific cultural practices, or other behavior unacceptable on more enlightened worlds. These worlds are almost invariably classed under Red trade codes.', 'Decadent noble, Mad cultist, Xenophobic local, Cannibal chief, Maltech researcher', 'Trapped outworlder, Aspiring reformer, Native wanting to avoid traditional flensing', 'Horrific local "celebration", Inexplicable and repugnant social rules, Taboo zones and people', 'Terribly misused piece of pretech, Wealth accumulated through brutal evildoing, Valuable possession owned by luckless outworlder victim', 'Atrocity amphitheater, Traditional torture parlor, Ordinary location twisted into something terrible.', 'Feral');
INSERT INTO "WORLD_TAG" VALUES (204, 'Flying Cities', 'Perhaps the world is a gas giant, or plagued with unendurable storms at lower levels of the atmosphere. For whatever reason, the cities of this world fly above the surface of the planet. Perhaps they remain stationary, or perhaps they move from point to point in search of resources.', 'Rival city pilot, Tech thief attempting to steal outworld gear, Saboteur or scavenger plundering the city''s tech', 'Maintenance tech in need of help, City defense force pilot, Meteorological researcher', 'Sudden storms, Drastic altitude loss, Rival city attacks, Vital machinery breaks down', 'Precious refined atmospheric gases, Pretech grav engine plans, Meteorological codex predicting future storms', 'Underside of the city, The one calm place on the planet’s surface, Catwalks stretching over unimaginable gulfs below.', NULL);
INSERT INTO "WORLD_TAG" VALUES (205, 'Forbidden Tech', 'Some group on this planet fabricates or uses maltech. Unbraked AIs doomed to metastasize into insanity, nation-destroying nanowarfare particles, slow-burn DNA corruptives, genetically engineered slaves, or something worse still. The planet’s larger population may or may not be aware of the danger in their midst.', 'Mad scientist, Maltech buyer from offworld, Security enforcer', 'Victim of maltech, Perimeter agent, Investigative reporter, Conventional arms merchant', 'The maltech is being fabricated by an unbraked AI, The government depends on revenue from maltech sales to offworlders, Citizens insist that it''s not really maltech', 'Maltech research data, The maltech itself, Precious pretech equipment used to create it', 'Horrific laboratory, Hellscape sculpted by the maltech''s use, Government building meeting room', NULL);
INSERT INTO "WORLD_TAG" VALUES (206, 'Freak Geology', 'The geology or geography of this world is simply freakish. Perhaps it’s composed entirely of enormous mountain ranges, or regular bands of land and sea, or the mineral structures all fragment into perfect cubes. The locals have learned to deal with it and their culture will be shaped by its requirements.', 'Crank xenogeologist, Cultist who believes it the work of aliens', 'Research scientist, Prospector, Artist', 'Local conditions that no one remembers to tell outworlders about, Lethal weather, Seismic activity', 'Unique crystal formations, Hidden veins of a major precious mineral strike, Deed to a location of great natural beauty', 'Atop a bizarre geological formation, Tourist resort catering to offworlders', 'Frk. Geology');
INSERT INTO "WORLD_TAG" VALUES (207, 'Freak Weather', 'The planet is plagued with some sort of bizarre or hazardous weather pattern. Perhaps city-flattening storms regularly scourge the surface, or the world’s sun never pierces its thick banks of clouds.', 'Criminal using the weather as a cover, Weather cultists convinced the offworlders are responsible for some disaster, Native predators dependent on the weather', 'Meteorological researcher, Holodoc crew wanting shots of the weather', 'The weather itself, Malfunctioning pretech terraforming engines that cause the weather', 'Wind-scoured deposits of precious minerals, Holorecords of a spectacularly and rare weather pattern, Naturally- sculpted objects of intricate beauty', 'Eye of the storm, The one sunlit place, Terraforming control room', 'Frk. Weather');
INSERT INTO "WORLD_TAG" VALUES (208, 'Friendly Foe', 'Some hostile alien race or malevolent cabal has a branch or sect on this world that is actually quite friendly toward outsiders. For whatever internal reason, they are willing to negotiate and deal honestly with strangers, and appear to lack the worst impulses of their fellows.', 'Driven hater of all their kind, Internal malcontent bent on creating conflict, Secret master who seeks to lure trust', 'Well-meaning bug-eyed monster, Principled eugenics cultist, Suspicious investigator', 'The group actually is as harmless and benevolent as they seem, The group offers a vital service at the cost of moral compromise, The group still feels bonds of affiliation with their hostile brethren', 'Forbidden xenotech, Eugenic biotech template, Evidence to convince others of their kind that they are right', 'Repurposed maltech laboratory, Alien conclave building, Widely-feared starship interior', NULL);
INSERT INTO "WORLD_TAG" VALUES (209, 'Gold Rush', 'Gold, silver, and other conventional precious minerals are common and cheap now that asteroid mining is practical for most worlds. But some minerals and compounds remain precious and rare, and this world has recently been discovered to have a supply of them. People from across the sector have come to strike it rich.', 'Paranoid prospector, Aspiring mining tycoon, Rapacious merchant', 'Claim-jumped miner, Native alien, Curious tourist', 'The strike is a hoax, The strike is of a dangerous toxic substance, Export of the mineral is prohibited by the planetary government, The native aliens live around the strike''s location', 'Cases of the refined element, Pretech mining equipment, A dead prospector''s claim deed', 'Secret mine, Native alien village, Processing plant, Boom town', NULL);
INSERT INTO "WORLD_TAG" VALUES (210, 'Hatred', 'For whatever reason, this world’s populace has a burning hatred for the inhabitants of a neighboring system. Perhaps this world was colonized by exiles, or there was a recent interstellar war, or ideas of racial or religious superiority have fanned the hatred. Regardless of the cause, the locals view their neighbor and any sympathizers with loathing.', 'Native convinced that the offworlders are agents of Them, Cynical politician in need of scapegoats', 'Intelligence agent needing catspaws, Holodoc producers needing "an inside look"', 'The characters are wearing or using items from the hated world, The characters are known to have done business there, The characters "look like" the hated others', 'Proof of Their evildoing, Reward for turning in enemy agents, Relic stolen by Them years ago', 'War crimes museum, Atrocity site, Captured, decommissioned spaceship kept as a trophy', NULL);
INSERT INTO "WORLD_TAG" VALUES (301, 'Heavy Industry', 'With interstellar transport so limited in the bulk it can move, worlds have to be largely self-sufficient in industry. Some worlds are more sufficient than others, however, and this planet has a thriving manufacturing sector capable of producing large amounts of goods appropriate to its tech level. The locals may enjoy a correspondingly higher lifestyle, or the products might be devoted towards vast projects for the aggrandizement of the rulers.', 'Tycoon monopolist, Industrial spy, Malcontent revolutionary', 'Aspiring entrepreneur, Worker union leader, Ambitious inventor', 'The factories are toxic, The resources extractable at their tech level are running out, The masses require the factory output for survival, The industries'' major output is being obsoleted by offworld tech', 'Confidential industrial data, Secret union membership lists, Ownership shares in an industrial complex', 'Factory floor, Union meeting hall, Toxic waste dump, R&D complex', 'Hvy. Industry');
INSERT INTO "WORLD_TAG" VALUES (302, 'Heavy Mining', 'This world has large stocks of valuable minerals, usually necessary for local industry, life support, or refinement into loads small enough to export offworld. Major mining efforts are necessary to extract the minerals, and many natives work in the industry.', 'Mine boss, Tunnel saboteur, Subterranean predators', 'Hermit prospector, Offworld investor, Miner''s union representative', 'The refinery equipment breaks down, Tunnel collapse, Silicate life forms growing in the miners'' lungs', 'The mother lode, Smuggled case of refined mineral, Faked crystalline mineral samples', 'Vertical mine face, Tailing piles, Roaring smelting complex', 'Hvy. Mining');
INSERT INTO "WORLD_TAG" VALUES (303, 'Hostile Biosphere', 'The world is teeming with life, and it hates humans. Perhaps the life is xenoallergenic, forcing filter masks and tailored antiallergens for survival. It could be the native predators are huge and fearless, or the toxic flora ruthlessly outcompetes earth crops.', 'Local fauna, Nature cultist, Native aliens, Callous labor overseer', 'Xenobiologist, Tourist on safari, Grizzled local guide', 'Filter masks fail, Parasitic alien infestation, Crop greenhouses lose bio-integrity', 'Valuable native biological extract, Abandoned colony vault, Remains of an unsuccessful expedition', 'Deceptively peaceful glade, Steaming polychrome jungle, Nightfall when surrounded by Things', 'Host. Biosphere');
INSERT INTO "WORLD_TAG" VALUES (304, 'Hostile Space', 'The system in which the world exists is a dangerous neighborhood. Something about the system is perilous to inhabitants, either through meteor swarms, stellar radiation, hostile aliens in the asteroid belt, or periodic comet clouds.', 'Alien raid leader, Meteor-launching terrorists, Paranoid local leader', 'Astronomic researcher, Local defense commander, Early warning monitor agent', 'The natives believe the danger is divine chastisement, The natives blame outworlders for the danger, The native elite profit from the danger in some way', 'Early warning of a raid or impact, Abandoned riches in a disaster zone, Key to a secure bunker', 'City watching an approaching asteroid, Village burnt in an alien raid, Massive ancient crater', 'Host. Space');
INSERT INTO "WORLD_TAG" VALUES (305, 'Local Specialty', 'The world may be sophisticated or barely capable of steam engines, but either way it produces something rare and precious to the wider galaxy. It might be some pharmaceutical extract produced by a secret recipe, a remarkably popular cultural product, or even gengineered humans uniquely suited for certain work.', 'Monopolist, Offworlder seeking prohibition of the specialty, Native who views the specialty as sacred', 'Spy searching for the source, Artisan seeking protection, Exporter with problems', 'The specialty is repugnant in nature, The crafters refuse to sell to offworlders, The specialty is made in a remote, dangerous place, The crafters don''t want to make the specialty any more', 'The specialty itself, The secret recipe, Sample of a new improved variety', 'Secret manufactory, Hidden cache, Artistic competition for best artisan', 'Lcl. Spec.');
INSERT INTO "WORLD_TAG" VALUES (306, 'Local Tech', 'The locals can create a particular example of extremely high tech, possibly even something that exceeds pretech standards. They may use unique local resources to do so, or have stumbled on a narrow scientific breakthrough, or still have a functional experimental manufactory.', 'Keeper of the tech, Offworld industrialist, Automated defenses that suddenly come alive, Native alien mentors', 'Curious offworld scientist, Eager tech buyer, Native in need of technical help', 'The tech is unreliable, The tech only works on this world, The tech has poorly-understood side effects, The tech is alien in nature.', 'The tech itself, An unclaimed payment for a large shipment, The secret blueprints for its construction, An ancient alien R&D database', 'Alien factory, Lethal R&D center, Tech brokerage vault', 'Lcl. Tech');
INSERT INTO "WORLD_TAG" VALUES (307, 'Major Spaceyard', 'Most worlds of tech level 4 or greater have the necessary tech and orbital facilities to build spike drives and starships. This world is blessed with a major spaceyard facility, either inherited from before the Silence or painstakingly constructed in more recent decades. It can build even capital-class hulls, and do so more quickly and cheaply than its neighbors.', 'Enemy saboteur, Industrial spy, Scheming construction tycoon, Aspiring ship hijacker', 'Captain stuck in drydock, Maintenance chief, Mad innovator', 'The spaceyard is an alien relic, The spaceyard is burning out from overuse, The spaceyard is alive, The spaceyard relies on maltech to function', 'Intellectual property-locked pretech blueprints, Override keys for activating old pretech facilities, A purchased but unclaimed spaceship.', 'Hidden shipyard bay, Surface of a partially-completed ship, Ship scrap graveyard', 'Maj. Spaceyard');
INSERT INTO "WORLD_TAG" VALUES (308, 'Minimal Contact', 'The locals refuse most contact with offworlders. Only a small, quarantined treaty port is provided for offworld trade, and ships can expect an exhaustive search for contraband. Local governments may be trying to keep the very existence of interstellar trade a secret from their populations, or they may simply consider offworlders too dangerous or repugnant to be allowed among the population.', 'Customs official, Xenophobic natives, Existing merchant who doesn''t like competition', 'Aspiring tourist, Anthropological researcher, Offworld thief, Religious missionary', 'The locals carry a disease harmless to them and lethal to outsiders, The locals hide dark purposes from offworlders, The locals have something desperately needed but won''t bring it into the treaty port', 'Contraband trade goods, Security perimeter codes, Black market local products', 'Treaty port bar, Black market zone, Secret smuggler landing site', 'Min. Contact');
INSERT INTO "WORLD_TAG" VALUES (309, 'Misandry/Misogyny', 'The culture on this world holds a particular gender in contempt. Members of that gender are not permitted positions of formal power, and may be restricted in their movements and activities. Some worlds may go so far as to scorn both traditional genders, using gengineering techniques to hybridize or alter conventional human biology.', 'Cultural fundamentalist, Cultural missionary to outworlders', 'Oppressed native, Research scientist, Offworld emancipationist, Local reformer', 'The oppressed gender is restive against the customs, The oppressed gender largely supports the customs, The customs relate to some physical quality of the world, The oppressed gender has had maltech gengineering done to "tame" them.', 'Aerosol reversion formula for undoing gengineered docility, Hidden history of the world, Pretech gengineering equipment', 'Shrine to the virtues of the favored gender, Security center for controlling the oppressed, Gengineering lab', NULL);
INSERT INTO "WORLD_TAG" VALUES (310, 'Oceanic World', 'The world is entirely or almost entirely covered with liquid water. Habitations might be floating cities, or might cling precariously to the few rocky atolls jutting up from the waves, or are planted as bubbles on promontories deep beneath the stormy surface. Survival depends on aquaculture. Planets with inedible alien life rely on gengineered Terran sea crops.', 'Pirate raider, Violent "salvager" gang, Tentacled sea monster', 'Daredevil fisherman, Sea hermit, Sapient native life', 'The liquid flux confuses grav engines too badly for them to function on this world, Sea is corrosive or toxic, The seas are wracked by regular storms', 'Buried pirate treasure, Location of enormous schools of fish, Pretech water purification equipment', 'The only island on the planet, Floating spaceport, Deck of a storm-swept ship, Undersea bubble city', 'Oceanic');
INSERT INTO "WORLD_TAG" VALUES (401, 'Out of Contact', 'The natives have been entirely out of contact with the greater galaxy for centuries or longer. Perhaps the original colonists were seeking to hide from the rest of the universe, or the Silence destroyed any means of communication. It may have been so long that human origins on other worlds have regressed into a topic for legends. The players might be on the first offworld ship to land since the First Wave of colonization a thousand years ago.', 'Fearful local ruler, Zealous native cleric, Sinister power that has kept the world isolated', 'Scheming native noble, Heretical theologian, UFO cultist native', 'Automatic defenses fire on ships that try to take off, The natives want to stay out of contact, The natives are highly vulnerable to offworld diseases, The native language is completely unlike any known to the group', 'Ancient pretech equipment, Terran relic brought from Earth, Logs of the original colonists', 'Long-lost colonial landing site, Court of the local ruler, Ancient defense battery controls', NULL);
INSERT INTO "WORLD_TAG" VALUES (402, 'Outpost World', 'The world is only a tiny outpost of human habitation planted by an offworld corporation or government. Perhaps the staff is there to serve as a refueling and repair stop for passing ships, or to oversee an automated mining and refinery complex. They might be there to study ancient ruins, or simply serve as a listening and monitoring post for traffic through the system. The outpost is likely well-equipped with defenses against casual piracy.', 'Space-mad outpost staffer, Outpost commander who wants it to stay undiscovered, Undercover saboteur', 'Lonely staffer, Fixated researcher, Overtaxed maintenance chief', 'The alien ruin defense systems are waking up, Atmospheric disturbances trap the group inside the outpost for a month, Pirates raid the outpost, The crew have become converts to a strange set of beliefs', 'Alien relics, Vital scientific data, Secret corporate exploitation plans', 'Grimy recreation room, Refueling station, The only building on the planet, A “starport” of swept bare rock.', 'Outpost');
INSERT INTO "WORLD_TAG" VALUES (403, 'Perimeter Agency', 'Before the Silence, the Perimeter was a Terran-sponsored organization charged with rooting out use of maltech- technology banned in human space as too dangerous for use or experimentation. Unbraked AIs, gengineered slave species, nanotech replicators, weapons of planetary destruction... the Perimeter hunted down experimenters with a great indifference to planetary laws. Most Perimeter Agencies collapsed during the Silence, but a few managed to hold on to their mission, though modern Perimeter agents often find more work as conventional spies and intelligence operatives.', 'Renegade Agency Director, Maltech researcher, Paranoid intelligence chief', 'Agent in need of help, Support staffer, "Unjustly" targeted researcher', 'The local Agency has gone rogue and now uses maltech, The Agency archives have been compromised, The Agency has been targeted by a maltech-using organization, The Agency''s existence is unknown to the locals', 'Agency maltech research archives, Agency pretech spec-ops gear, File of blackmail on local politicians', 'Interrogation room, Smoky bar, Maltech laboratory, Secret Agency base', 'Perim. Agcy.');
INSERT INTO "WORLD_TAG" VALUES (404, 'Pilgrimage Site', 'The world is noted for an important spiritual or historical location, and might be the sector headquarters for a widespread religion or political movement. The site attracts wealthy pilgrims from throughout nearby space, and those with the money necessary to manage interstellar travel can be quite generous to the site and its keepers. The locals tend to be fiercely protective of the place and its reputation, and some places may forbid the entrance of those not suitably pious or devout.', 'Saboteur devoted to a rival belief, Bitter reformer who resents the current leadership, Swindler conning the pilgrims', 'Protector of the holy site, Naive offworlder pilgrim, Outsider wanting to learn the sanctum''s inner secrets', 'The site is actually a fake, The site is run by corrupt and venal keepers, A natural disaster threatens the site', 'Ancient relic guarded at the site, Proof of the site''s inauthenticity, Precious offering from a pilgrim', 'Incense-scented sanctum, Teeming crowd of pilgrims, Imposing holy structure', 'Pilgrimage');
INSERT INTO "WORLD_TAG" VALUES (405, 'Police State', 'The world is a totalitarian police state. Any sign of disloyalty to the planet’s rulers is punished severely, and suspicion riddles society. Some worlds might operate by Soviet-style informers and indoctrination, while more technically sophisticated worlds might rely on omnipresent cameras or braked AI "guardian angels". Outworlders are apt to be treated as a necessary evil at best, and "disappeared" if they become troublesome.', 'Secret police chief, Scapegoating official, Treacherous native informer', 'Rebel leader, Offworld agitator, Imprisoned victim, Crime boss', 'The natives largely believe in the righteousness of the state, The police state is automated and its "rulers" can''t shut it off, The leaders foment a pogrom against "offworlder spies".', 'List of police informers, Wealth taken from "enemies of the state", Dear Leader''s private stash', 'Military parade, Gulag, Gray concrete housing block, Surveillance center', NULL);
INSERT INTO "WORLD_TAG" VALUES (406, 'Preceptor Archive', 'The Preceptors of the Great Archive were a pre-Silence organization devoted to ensuring the dissemination of human culture, history, and basic technology to frontier worlds that risked losing this information during the human expansion. Most frontier planets had an Archive where natives could learn useful technical skills in addition to human history and art. Those Archives that managed to survive the Silence now strive to send their missionaries of knowledge to new worlds in need of their lore.', 'Luddite native, Offworld Merchant who wants the natives kept ignorant, Religious zealot, Corrupted First Speaker who wants to keep a monopoly on learning', 'Preceptor Adept missionary, Offworld scholar, Reluctant student, Roving Preceptor Adept', 'The local Archive has taken a very religious and mystical attitude toward their teaching, The Archive has maintained some replicable pretech science, The Archive has been corrupted and their teaching is incorrect', 'Lost Archive database, Ancient pretech teaching equipment, Hidden cache of theologically unacceptable tech', 'Archive lecture hall, Experimental laboratory, Student-local riot', 'Precept. Arch.');
INSERT INTO "WORLD_TAG" VALUES (407, 'Pretech Cultists', 'The capacities of human science before the Silence vastly outmatch the technology available since the Scream. The jump gates alone were capable of crossing hundreds of light years in a moment, and they were just one example of the results won by blending psychic artifice with pretech science. Some worlds outright worship the artifacts of their ancestors, seeing in them the work of more enlightened and perfect humanity. These cultists may or may not understand the operation or replication of these devices, but they seek and guard them jealously.', 'Cult leader, Artifact supplier, Pretech smuggler', 'Offworld scientist, Robbed collector, Cult heretic', 'The cultists can actually replicate certain forms of pretech, The cultists abhor use of the devices as "presumption on the holy", The cultists mistake the party''s belongings for pretech', 'Pretech artifacts both functional and broken, Religious-jargon laced pretech replication techniques, Waylaid payment for pretech artifacts', 'Shrine to nonfunctional pretech, Smuggler''s den, Public procession showing a prized artifact', 'Pretech Cult.');
INSERT INTO "WORLD_TAG" VALUES (408, 'Primitive Aliens', 'The world is populated by a large number of sapient aliens that have yet to develop advanced technology. The human colonists may have a friendly or hostile relationship with the aliens, but a certain intrinsic tension is likely. Small human colonies might have been enslaved or otherwise subjugated.', 'Hostile alien chief, Human firebrand, Dangerous local predator, Alien religious zealot', 'Colonist leader, Peace-faction alien chief, Planetary frontiersman, Xenoresearcher', 'The alien numbers are huge and can overwhelm the humans whenever they so choose, One group is trying to use the other to kill their political opponents, The aliens are incomprehensibly strange, One side commits an atrocity', 'Alien religious icon, Ancient alien-human treaty, Alien technology', 'Alien village, Fortified human settlement, Massacre site', 'Prim. Aliens');
INSERT INTO "WORLD_TAG" VALUES (409, 'Psionics Fear', 'The locals are terrified of psychics. Perhaps their history is studded with feral psychics who went on murderous rampages, or perhaps they simply nurse an unreasoning terror of those “mutant freaks”. Psychics demonstrate their powers at risk of their lives.', 'Mental purity investigator, Suspicious zealot, Witch-finder', 'Hidden psychic, Offworlder psychic trapped here, Offworld educator', 'Psychic potential is much more common here, Some tech is mistaken as psitech, Natives believe certain rituals and customs can protect them from psychic powers', 'Hidden psitech cache, Possessions of convicted psychics, Reward for turning in a psychic', 'Inquisitorial chamber, Lynching site, Museum of psychic atrocities', 'Psi. Fear');
INSERT INTO "WORLD_TAG" VALUES (410, 'Psionics Worship', 'These natives view psionic powers as a visible gift of god or sign of superiority. If the world has a functional psychic training academy, psychics occupy almost all major positions of power and are considered the natural and proper rulers of the world. If the world lacks training facilities, it is likely a hodgepodge of demented cults, with each one dedicated to a marginally-coherent feral prophet and their psychopathic ravings.', 'Psychic inquisitor, Haughty mind-noble, Psychic slaver, Feral prophet', 'Offworlder psychic researcher, Native rebel, Offworld employer seeking psychics', 'The psychic training is imperfect, and the psychics all show significant mental illness, The psychics have developed a unique discipline, The will of a psychic is law, Psychics in the party are forcibly kidnapped for "enlightening".', 'Ancient psitech, Valuable psychic research records, Permission for psychic training', 'Psitech-imbued council chamber, Temple to the mind, Sanitarium-prison for feral psychics', 'Psi. Worship');
INSERT INTO "WORLD_TAG" VALUES (501, 'Psionics Academy', 'This world is one of the few that have managed to redevelop the basics of psychic training. Without this education, a potential psychic is doomed to either madness or death unless they refrain from using their abilities. Psionic academies are rare enough that offworlders are often sent there to study by wealthy patrons. The secrets of psychic mentorship, the protocols and techniques that allow a psychic to successfully train another, are carefully guarded at these academies. Most are closely affiliated with the planetary government.', 'Corrupt psychic instructor, Renegade student, Mad psychic researcher, Resentful townie', 'Offworld researcher, Aspiring student, Wealthy tourist', 'The academy curriculum kills a significant percentage of students, The faculty use students as research subjects, The students are indoctrinated as sleeper agents, The local natives hate the academy, The academy is part of a religion.', 'Secretly developed psitech, A runaway psychic mentor, Psychic research prize', 'Training grounds, Experimental laboratory, School library, Campus hangout', 'Psi. School');
INSERT INTO "WORLD_TAG" VALUES (502, 'Quarantined World', 'The world is under a quarantine, and space travel to and from it is strictly forbidden. This may be enforced by massive ground batteries that burn any interlopers from the planet’s sky, or it may be that a neighboring world runs a persistent blockade.', 'Defense installation commander, Suspicious patrol leader, Crazed asteroid hermit', 'Relative of a person trapped on the world, Humanitarian relief official, Treasure hunter', 'The natives want to remain isolated, The quarantine is enforced by an ancient alien installation, The world is rife with maltech abominations, The blockade is meant to starve everyone on the barren world.', 'Defense grid key, Bribe for getting someone out, Abandoned alien tech', 'Bridge of a blockading ship, Defense installation control room, Refugee camp', 'Quarantined');
INSERT INTO "WORLD_TAG" VALUES (503, 'Radioactive World', 'Whether due to a legacy of atomic warfare unhindered by nuke snuffers or a simple profusion of radioactive elements, this world glows in the dark. Even heavy vacc suits can filter only so much of the radiation, and most natives suffer a wide variety of cancers, mutations and other illnesses without the protection of advanced medical treatments.', 'Bitter mutant, Relic warlord, Desperate would-be escapee', 'Reckless prospector, Offworld scavenger, Biogenetic variety seeker', 'The radioactivity is steadily growing worse, The planet''s medical resources break down, The radioactivity has inexplicable effects on living creatures, The radioactivity is the product of a malfunctioning pretech manufactory.', 'Ancient atomic weaponry, Pretech anti-radioactivity drugs, Untainted water supply', 'Mutant-infested ruins, Scorched glass plain, Wilderness of bizarre native life, Glowing barrens', 'Radioactive');
INSERT INTO "WORLD_TAG" VALUES (504, 'Regional Hegemon', 'This world has the technological sophistication, natural resources, and determined polity necessary to be a regional hegemon for the sector. Nearby worlds are likely either directly subservient to it or tack carefully to avoid its anger. It may even be the capital of a small stellar empire.', 'Ambitious general, Colonial official, Contemptuous noble', 'Diplomat, Offworld ambassador, Foreign spy', 'The hegemon''s influence is all that''s keeping a murderous war from breaking out on nearby worlds, The hegemon is decaying and losing its control, The government is riddled with spies, The hegemon is genuinely benign', 'Diplomatic carte blanche, Deed to an offworld estate, Foreign aid grant', 'Palace or seat of government, Salon teeming with spies, Protest rally, Military base', 'Reg. Hegemon');
INSERT INTO "WORLD_TAG" VALUES (505, 'Restrictive Laws', 'A myriad of laws, customs, and rules constrain the inhabitants of this world, and even acts that are completely permissible elsewhere are punished severely here. The locals may provide lists of these laws to offworlders, but few non-natives can hope to master all the important intricacies.', 'Law enforcement officer, Outraged native, Native lawyer specializing in peeling offworlders, Paid snitch', 'Frustrated offworlder, Repressed native, Reforming crusader', 'The laws change regularly in patterns only natives understand, The laws forbid some action vital to the party, The laws forbid the simple existence of some party members, The laws are secret to offworlders', 'Complete legal codex, Writ of diplomatic immunity, Fine collection vault contents', 'Courtroom, Mob scene of outraged locals, Legislative chamber, Police station', 'Restrictive');
INSERT INTO "WORLD_TAG" VALUES (506, 'Rigid Culture', 'The local culture is extremely rigid. Certain forms of behavior and belief are absolutely mandated, and any deviation from these principles is punished, or else society may be strongly stratified by birth with limited prospects for change. Anything which threatens the existing social order is feared and shunned.', 'Rigid reactionary, Wary ruler, Regime ideologue, Offended potentate', 'Revolutionary agitator, Ambitious peasant, Frustrated merchant', 'The cultural patterns are enforced by technological aids, The culture is run by a secret cabal of manipulators, The culture has explicit religious sanction, The culture evolved due to important necessities that have since been forgotten', 'Precious traditional regalia, Peasant tribute, Opulent treasures of the ruling class', 'Time-worn palace, Low-caste slums, Bandit den, Reformist temple', 'Rigid');
INSERT INTO "WORLD_TAG" VALUES (507, 'Seagoing Cities', 'Either the world is entirely water or else the land is simply too dangerous for most humans. Human settlement on this world consists of a number of floating cities that follow the currents and the fish.', 'Pirate city lord, Mer-human raider chieftain, Hostile landsman noble, Enemy city saboteur', 'City navigator, Scout captain, Curious mer-human', 'The seas are not water, The fish schools have vanished and the city faces starvation, Terrible storms drive the city into the glacial regions, Suicide ships ram the city’s hull', 'Giant pearls with mysterious chemical properties, Buried treasure, Vital repair materials', 'Bridge of the city, Storm-tossed sea, A bridge fashioned of many small boats.', 'Seagoing');
INSERT INTO "WORLD_TAG" VALUES (508, 'Sealed Menace', 'Something on this planet has the potential to create enormous havoc for the inhabitants if it is not kept safely contained by its keepers. Whether a massive seismic fault line suppressed by pretech terraforming technology, a disease that has to be quarantined within hours of discovery, or an ancient alien relic that requires regular upkeep in order to prevent planetary catastrophe, the menace is a constant shadow on the populace.', 'Hostile outsider bent on freeing the menace, Misguided fool who thinks he can use it, Reckless researcher who thinks he can fix it', 'Keeper of the menace, Student of its nature, Victim of the menace', 'The menace would bring great wealth along with destruction, The menace is intelligent, The natives don''t all believe in the menace', 'A key to unlock the menace, A precious byproduct of the menace, The secret of the menace’s true nature', 'Guarded fortress containing the menace, Monitoring station, Scene of a prior outbreak of the menace', NULL);
INSERT INTO "WORLD_TAG" VALUES (509, 'Sectarians', 'The world is torn by violent disagreement between sectarians of a particular faith. Each views the other as a damnable heresy in need of extirpation. Local government may be able to keep open war from breaking out, but the poisonous hatred divides communities. The nature of the faith may be religious, or it may be based on some secular ideology.', 'Paranoid believer, Native convinced the party is working for the other side, Absolutist ruler', 'Reformist clergy, Local peacekeeping official, Offworld missionary, Exhausted ruler', 'The conflict has more than two sides, The sectarians hate each other for multiple reasons, The sectarians must cooperate or else life on this world is imperiled, The sectarians hate outsiders more than they hate each other, The differences in sects are incomprehensible to an outsider', 'Ancient holy book, Incontrovertible proof, Offering to a local holy man', 'Sectarian battlefield, Crusading temple, Philosopher’s salon, Bitterly divided village', NULL);
INSERT INTO "WORLD_TAG" VALUES (510, 'Seismic Instability', 'The local land masses are remarkably unstable, and regular earthquakes rack the surface. Local construction is either advanced enough to sway and move with the vibrations or primitive enough that it is easily rebuilt. Severe volcanic activity may be part of the instability.', 'Earthquake cultist, Hermit seismologist, Burrowing native life form, Earthquake-inducing saboteur', 'Experimental construction firm owner, Adventurous volcanologist, Geothermal prospector', 'The earthquakes are caused by malfunctioning pretech terraformers, They''re caused by alien technology, They''re restrained by alien technology that is being plundered by offworlders, The earthquakes are used to generate enormous amounts of energy.', 'Earthquake generator, Earthquake suppressor, Mineral formed at the core of the world, Earthquake-proof building schematics', 'Volcanic caldera, Village during an earthquake, Mud slide, Earthquake opening superheated steam fissures', 'Seismic');
INSERT INTO "WORLD_TAG" VALUES (601, 'Secret Masters', 'The world is actually run by a hidden cabal, acting through their catspaws in the visible government. For one reason or another, this group finds it imperative that they not be identified by outsiders, and in some cases even the planet’s own government may not realize that they’re actually being manipulated by hidden masters.', 'An agent of the cabal, Government official who wants no questions asked, Willfully blinded local', 'Paranoid conspiracy theorist, Machiavellian gamesman within the cabal, Interstellar investigator', 'The secret masters have a benign reason for wanting secrecy, The cabal fights openly amongst itself, The cabal is recruiting new members', 'A dossier of secrets on a government official, A briefcase of unmarked credit notes, The identity of a cabal member', 'Smoke-filled room, Shadowy alleyway, Secret underground bunker', NULL);
INSERT INTO "WORLD_TAG" VALUES (602, 'Theocracy', 'The planet is ruled by the priesthood of the predominant religion or ideology. The rest of the locals may or may not be terribly pious, but the clergy have the necessary military strength, popular support or control of resources to maintain their rule. Alternative faiths or incompatible ideologies are likely to be both illegal and socially unacceptable.', 'Decadent priest-ruler, Zealous inquisitor, Relentless proselytizer, True Believer', 'Heretic, Offworld theologian, Atheistic merchant, Desperate commoner', 'The theocracy actually works well, The theocracy is decadent and hated by the common folk, The theocracy is divided into mutually hostile sects, The theocracy is led by aliens', 'Precious holy text, Martyr''s bones, Secret church records, Ancient church treasures', 'Glorious temple, Austere monastery, Academy for ideological indoctrination, Decadent pleasure-cathedral', NULL);
INSERT INTO "WORLD_TAG" VALUES (603, 'Tomb World', 'Tomb worlds are planets that were once inhabited by humans before the Silence. The sudden collapse of the jump gate network and the inability to bring in the massive food supplies required by the planet resulted in starvation, warfare, and death. Most tomb worlds are naturally hostile to human habitation and could not raise sufficient crops to maintain life. The few hydroponic facilities were usually destroyed in the fighting, and all that is left now are ruins, bones, and silence.', 'Demented survivor tribe chieftain, Avaricious scavenger, Automated defense system, Native predator', 'Scavenger Fleet captain, Archaeologist, Salvaging historian', 'The ruins are full of booby-traps left by the final inhabitants, The world''s atmosphere quickly degrades anything in an opened building, A handful of desperate natives survived the Silence, The structures are unstable and collapsing', 'Lost pretech equipment, Psitech caches, Stores of unused munitions, Ancient historical documents', 'Crumbling hive-city, City square carpeted in bones, Ruined hydroponic facility, Cannibal tribe''s lair, Dead orbital jump gate', NULL);
INSERT INTO "WORLD_TAG" VALUES (604, 'Trade Hub', 'This world is a major crossroads for local interstellar trade. It is well-positioned at the nexus of several short-drill trade routes, and has facilities for easy transfer of valuable cargoes and the fueling and repairing of starships. The natives are accustomed to outsiders, and a polyglot mass of people from every nearby world can be found trading here.', 'Cheating merchant, Thieving dockworker, Commercial spy, Corrupt customs official', 'Rich tourist, Hardscrabble free trader, Merchant prince in need of catspaws, Friendly spaceport urchin', 'An outworlder faction schemes to seize the trade hub, Saboteurs seek to blow up a rival''s warehouses, Enemies are blockading the trade routes, Pirates lace the hub with spies', 'Voucher for a warehouse''s contents, Insider trading information, Case of precious offworld pharmaceuticals, Box of legitimate tax stamps indicating customs dues have been paid.', 'Raucous bazaar, Elegant restaurant, Spaceport teeming with activity, Foggy street lined with warehouses', NULL);
INSERT INTO "WORLD_TAG" VALUES (605, 'Tyranny', 'The local government is brutal and indifferent to the will of the people. Laws may or may not exist, but the only one that matters is the whim of the rulers on any given day. Their minions swagger through the streets while the common folk live in terror of their appetites. The only people who stay wealthy are friends and servants of the ruling class.', 'Debauched autocrat, Sneering bully-boy, Soulless government official, Occupying army officer', 'Conspiring rebel, Oppressed merchant, Desperate peasant, Inspiring religious leader', 'The tyrant rules with vastly superior technology, The tyrant is a figurehead for a cabal of powerful men and women, The people are resigned to their suffering, The tyrant is hostile to "meddlesome outworlders".', 'Plundered wealth, Beautiful toys of the elite, Regalia of rulership', 'Impoverished village, Protest rally massacre, Decadent palace, Religious hospital for the indigent', NULL);
INSERT INTO "WORLD_TAG" VALUES (606, 'Unbraked AI', 'Artificial intelligences are costly and difficult to create, requiring a careful sequence of "growth stages" in order to bring them to sentience before artificial limits on cognition speed and learning development are installed. These "brakes" prevent runaway cognition metastasis, wherein an AI begins to rapidly contemplate certain subjects in increasingly baroque fashion, until they become completely crazed by rational human standards. This world has one such "unbraked AI" on it, probably with a witting or unwitting corps of servants. Unbraked AIs are quite insane, but they learn and reason with a speed impossible for humans, and can demonstrate a truly distressing subtlety at times.', 'AI Cultist, Maltech researcher, Government official dependent on the AI', 'Perimeter agent, AI researcher, Braked AI', 'The AI''s presence is unknown to the locals, The locals depend on the AI for some vital service, The AI appears to be harmless, The AI has fixated on the group''s ship''s computer, The AI wants transport offworld', 'The room-sized AI core itself, Maltech research files, Perfectly tabulated blackmail on government officials, Pretech computer circuitry', 'Municipal computing banks, Cult compound, Repair center, Ancient hardcopy library', NULL);
INSERT INTO "WORLD_TAG" VALUES (607, 'Warlords', 'The world is plagued by warlords. Numerous powerful men and women control private armies sufficiently strong to cow whatever local government may exist. On the lands they claim, their word is law. Most spend their time oppressing their own subjects and murderously pillaging those of their neighbors. Most like to wrap themselves in the mantle of ideology, religious fervor, or an ostensibly legitimate right to rule.', 'Warlord, Avaricious lieutenant, Expensive assassin, Aspiring minion', 'Vengeful commoner, Government military officer, Humanitarian aid official, Village priest', 'The warlords are willing to cooperate to fight mutual threats, The warlords favor specific religions or races over others, The warlords are using substantially more sophisticated tech than others, Some of the warlords are better rulers than the government', 'Weapons cache, Buried plunder, A warlord''s personal battle harness, Captured merchant shipping', 'Gory battlefield, Burnt-out village, Barbaric warlord palace, Squalid refugee camp', NULL);
INSERT INTO "WORLD_TAG" VALUES (608, 'Xenophiles', 'The natives of this world are fast friends with a particular alien race. The aliens may have saved the planet at some point in the past, or awed the locals with superior tech or impressive cultural qualities. The aliens might even be the ruling class on the planet.', 'Offworld xenophobe, Suspicious alien leader, Xenocultural imperialist', 'Benevolent alien, Native malcontent, Gone-native offworlder', 'The enthusiasm is due to alien psionics or tech, The enthusiasm is based on a lie, The aliens strongly dislike their "groupies", The aliens feel obliged to rule humanity for its own good, Humans badly misunderstand the aliens', 'Hybrid alien-human tech, Exotic alien crafts, Sophisticated xenolinguistic and xenocultural research data', 'Alien district, Alien-influenced human home, Cultural festival celebrating alien artist', NULL);
INSERT INTO "WORLD_TAG" VALUES (609, 'Xenophobes', 'The natives are intensely averse to dealings with outworlders. Whether through cultural revulsion, fear of tech contamination, or a genuine immunodeficiency, the locals shun foreigners from offworld and refuse to have anything to do with them beyond the bare necessities of contact. Trade may or may not exist on this world, but if it does, it is almost certainly conducted by a caste of untouchables and outcasts.', 'Revulsed local ruler, Native convinced some wrong was done to him, Cynical demagogue', 'Curious native, Exiled former ruler, Local desperately seeking outworlder help', 'The natives are symptomless carriers of a contagious and dangerous disease, The natives are exceptionally vulnerable to offworld diseases, The natives require elaborate purification rituals after speaking to an offworlder or touching them, The local ruler has forbidden any mercantile dealings with outworlders', 'Jealously-guarded precious relic, Local product under export ban, Esoteric local technology', 'Sealed treaty port, Public ritual not open to outsiders, Outcaste slum home', NULL);
INSERT INTO "WORLD_TAG" VALUES (610, 'Zombies', 'This menace may not take the form of shambling corpses, but some disease, alien artifact, or crazed local practice produces men and women with habits similar to those of murderous cannibal undead. These outbreaks may be regular elements in local society, either provoked by some malevolent creators or the consequence of some local condition.', 'Soulless maltech biotechnology cult, Sinister governmental agent, Crazed zombie cultist', 'Survivor of an outbreak, Doctor searching for a cure, Rebel against the secret malefactors', 'The zombies retain human intelligence, The zombies can be cured, The process is voluntary among devotees, The condition is infectious', 'Cure for the condition, Alien artifact that causes it, Details of the cult''s conversion process', 'House with boarded-up windows, Dead city, Fortified bunker that was overrun from within', NULL);


CREATE TABLE "WORLD_TECH_LEVEL" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR(64) NOT NULL , "desc" CLOB NOT NULL , "short" VARCHAR(32));
INSERT INTO "WORLD_TECH_LEVEL" VALUES (2, 'Tech Level 0. Stone-age technology.', 'Tech level 0 represents a world with technologies similar to neolithic- era humanity. Very few worlds collapse this far without dying out completely, and so a world this primitive is very rare in human space. The world is so profoundly devoid of useful resources that the natives may simply not have anything better to work with than rocks and native vegetation.
Natives of a world at this tech level might retain elaborate cultural artifacts and a very sophisticated society. Existing resources tend to be exploited to the hilt, with large populations producing massive stone cities, human-powered engines for irrigation, and vast displays of foodstuffs and craft work for the ruling class. Despite this, the lack of metal, domesticated beasts of burden, and petrochemicals puts a hard stop on the technological development of most of these worlds.
Responses to free traders and other interstellar travellers will vary with the local culture. The lack of quick communications methods tends to result in large populations breaking up into numerous smaller regional cultures, and the friendly prince of one domain might neighbor an implacably hostile sage-king. Most “lostworlders” have a keen appreciation for the benefits these strangers from the sky can bring them, and will bargain accordingly.
Some worlds might retain crisply rational records of their colonization and downfall. Others might preserve tales of a starry origin in legends and story. A few might have forgotten their origins entirely, and view sky-born humans as gods or messengers of the divine. Such awe rarely lasts very long once the merchants or pirates who landed make their purposes clear.', '0');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (3, 'Tech Level 1. Medieval technology.', 'Tech level 1 worlds have managed to find and exploit metal deposits and likely have imported or domesticated beasts of burden. Those worlds with easy access to fossil fuels or a similarly energy-dense substance can advance to greater things, but a culture trapped at tech level 1 is unlikely to have access to such helpful resources. A few worlds have enough plant matter or other combustibles to make steam engines feasible, but those with very much of such a resource usually make the leap to the next tech level eventually.
As a consequence, tech level 1 worlds tend to be caught at much the same general level of development as their tech level 0 cousins. They may have elaborate social structures and cultural development, but they are unable to mechanize without some energy-dense resource to serve as fuel. The scavenged hulks of their ancestors’ fusion plants may stand as mute temples to the achievements of their forebears, but without the tech necessary to repair and rebuild such edifices the world is dependent on purely local fuel sources.
Tech level 1 worlds tend to respond to visitors in much the same way as tech level 0 planets. The ruling class of these worlds is liable to be able to muster larger cities, bigger armies, and all the other perquisites that come from being able to work the available agricultural land with fewer hands.', '1');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (4, 'Tech level 2. 19th-century technology.', 'Tech level 2 worlds are blessed with the presence of fossil fuels. Internal combustion engines are crude things compared to the power of a fusion plant, but they can be built with primitive tools and a basic degree of education. The mechanization that results from this resource vastly increases the efficiency of local farming, the speed of travel, and the productivity of factory workers.
Most tech level 2 worlds are “knockdowns”; planets that once had a much higher degree of sophistication but were recently crippled by disease, disaster, or invasion. The natives tend to be keenly aware of the glories of former generations, and work fiercely to redevelop lost techniques and reclaim old knowledge.
Few tech level 2 worlds produce much that’s worth interstellar trade. Most foodstuffs are too bulky and cheap to make it worth a captain’s time. Some worlds have rare ore deposits, but the natives have no reason to dig them until a merchant makes it worth their while to set up a whole new industry for export. Some such worlds barter the relics of their ancestors in exchange for educational materials or rare resources necessary for advancing local industry. Others feel forced to trade native work contracts for dangerous, dirty labor.', '2');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (5, 'Tech Level 3. 20th-century technology.', 'Tech level 3 worlds are those that have developed to a level much like that of the more advanced nations of late twentieth-century Earth. The main difference between tech level 3 worlds and level 4 worlds is the lack of fusion power or spike drive manufacture.
These worlds come in two major varieties. The first is a "knockdown" world that formerly had tech level 4 technologies before some catastrophe or pirate attack destroyed their knowledge and industrial base. Some of the wrecked infrastructure might have been irreplaceable, and the world must struggle to regain its former level of technological production. Worlds in this condition tend to have rather small populations that are susceptible to the loss of a few concentrated groups of experts.
The second major variety is a world that suffered a severe disaster shortly after colonization and has been forced to painstakingly build up their technological base ever since. Some of these worlds date back to the First Wave of colonization a thousand years ago, driven into near-neolithic conditions by some outside pressure before slowly and painfully rebuilding their technological base through purely indigenous efforts. These worlds tend to have very large populations if the world’s climate permits, as they have been colonized for quite some time.
Simply providing a world with the necessary technical data for advancement doesn’t mean that advancement will be quick or even. Even if a tech level 3 world has the necessary resources to build tech level 4 devices, it may take as much as a generation for a world to build the necessary infrastructure and resource extraction enterprises. The time may be longer still if the dominant cultures are uneasy with the new technology.', '3');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (6, 'Tech Level 3. 20th-century technology.', 'Tech level 3 worlds are those that have developed to a level much like that of the more advanced nations of late twentieth-century Earth. The main difference between tech level 3 worlds and level 4 worlds is the lack of fusion power or spike drive manufacture.
These worlds come in two major varieties. The first is a "knockdown" world that formerly had tech level 4 technologies before some catastrophe or pirate attack destroyed their knowledge and industrial base. Some of the wrecked infrastructure might have been irreplaceable, and the world must struggle to regain its former level of technological production. Worlds in this condition tend to have rather small populations that are susceptible to the loss of a few concentrated groups of experts.
The second major variety is a world that suffered a severe disaster shortly after colonization and has been forced to painstakingly build up their technological base ever since. Some of these worlds date back to the First Wave of colonization a thousand years ago, driven into near-neolithic conditions by some outside pressure before slowly and painfully rebuilding their technological base through purely indigenous efforts. These worlds tend to have very large populations if the world’s climate permits, as they have been colonized for quite some time.
Simply providing a world with the necessary technical data for advancement doesn’t mean that advancement will be quick or even. Even if a tech level 3 world has the necessary resources to build tech level 4 devices, it may take as much as a generation for a world to build the necessary infrastructure and resource extraction enterprises. The time may be longer still if the dominant cultures are uneasy with the new technology.', '3');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (7, 'Tech Level 4. Baseline postech.', 'Tech level 4 worlds are the most common in human space, and their technical expertise is the baseline for modern post-Silence "postech". These worlds can create spike drives rated up to drive-3, fusion power plants, grav vehicles, simple energy weapons, and medicines that extend human life to a hundred years of vigorous good health. They can manage sophisticated gengineering on simple life forms, and some tech level 4 worlds have even attempted to improve the genetic structures of human life itself. These attempts have yet to produce results without severe drawbacks, but some such worlds remain populated by altered humanity designed to cope with local conditions more perfectly than baseline humans.
Most worlds with regular interstellar contact and the necessary raw resources eventually gravitate towards this level of technological expertise. It may take decades, or even centuries in the case of more retrograde worlds, but this tech level is the highest that can readily be achieved by most planets.', '4');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (8, 'Tech Level 4. Baseline postech.', 'Tech level 4 worlds are the most common in human space, and their technical expertise is the baseline for modern post-Silence "postech". These worlds can create spike drives rated up to drive-3, fusion power plants, grav vehicles, simple energy weapons, and medicines that extend human life to a hundred years of vigorous good health. They can manage sophisticated gengineering on simple life forms, and some tech level 4 worlds have even attempted to improve the genetic structures of human life itself. These attempts have yet to produce results without severe drawbacks, but some such worlds remain populated by altered humanity designed to cope with local conditions more perfectly than baseline humans.
Most worlds with regular interstellar contact and the necessary raw resources eventually gravitate towards this level of technological expertise. It may take decades, or even centuries in the case of more retrograde worlds, but this tech level is the highest that can readily be achieved by most planets.', '4');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (9, 'Tech Level 4. Baseline postech.', 'Tech level 4 worlds are the most common in human space, and their technical expertise is the baseline for modern post-Silence "postech". These worlds can create spike drives rated up to drive-3, fusion power plants, grav vehicles, simple energy weapons, and medicines that extend human life to a hundred years of vigorous good health. They can manage sophisticated gengineering on simple life forms, and some tech level 4 worlds have even attempted to improve the genetic structures of human life itself. These attempts have yet to produce results without severe drawbacks, but some such worlds remain populated by altered humanity designed to cope with local conditions more perfectly than baseline humans.
Most worlds with regular interstellar contact and the necessary raw resources eventually gravitate towards this level of technological expertise. It may take decades, or even centuries in the case of more retrograde worlds, but this tech level is the highest that can readily be achieved by most planets.', '4');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (10, 'Tech Level 4. Baseline postech.', 'Tech level 4 worlds are the most common in human space, and their technical expertise is the baseline for modern post-Silence "postech". These worlds can create spike drives rated up to drive-3, fusion power plants, grav vehicles, simple energy weapons, and medicines that extend human life to a hundred years of vigorous good health. They can manage sophisticated gengineering on simple life forms, and some tech level 4 worlds have even attempted to improve the genetic structures of human life itself. These attempts have yet to produce results without severe drawbacks, but some such worlds remain populated by altered humanity designed to cope with local conditions more perfectly than baseline humans.
Most worlds with regular interstellar contact and the necessary raw resources eventually gravitate towards this level of technological expertise. It may take decades, or even centuries in the case of more retrograde worlds, but this tech level is the highest that can readily be achieved by most planets.', '4');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (11, 'Tech Level 4 w/ specialities / pretech.', 'Tech level 4 with specialties is an unusual case of a normal tech level 4 world that has retained some pretech industries or has developed their own local technical expertise beyond baseline postech in certain disciplines.
Most such specialties are relatively narrow in scope; grav tech, medicine, hydroponics, force field generation, or some field of roughly similar breadth. These specialties are usually either the product of a few, unreplaceable pretech manufactories or the result of some unique local resource that serves amazingly well for the purpose at hand. In both cases, the world will jealously guard the tech, and much local conflict may relate to control over these resources.
These worlds tend to have substantial amounts of interstellar trade from neighboring worlds interested in their tech. The ruling elite of the world can be ostentatious about display of this wealth.', '4+');
INSERT INTO "WORLD_TECH_LEVEL" VALUES (12, 'Tech Level 5. Pretech, pre-Silence tech.', 'Tech level 5 is the highest tech level that might merit random placement. A world with this level of technological expertise has somehow managed to hold on to the majority of the pre-Scream technology base, and can produce a wide range of goods that are unknown on less sophisticated worlds. Miniaturized fusion plants, drive-6 rated spike drives, exotic grav weaponry, and even the development of psionics-based "psitech" is possible on such a world.
Pretech manufacturing was largely dependent on specially-trained industrial psychics. With the loss of their unique disciplines in the Scream, most worlds that retain this level of tech classification were forced to substitute slower, less precise methods that sharply curtailed their production efficiency. Barring the profoundly unlikely happenstance of this world’s redevelopment of the lost disciplines, their maximum industrial output is sharply limited. Even on worlds such as this, most technology is likely mass-produced postech, with only important goods produced to pretech levels of quality.
A world with this level of technology is almost certainly a regional hegemon, one of the most powerful and influential worlds in the sector. Even those worlds that have no imperial ambitions have enormous influence simply through the vast superiority of their starships and military technology.', '5');


CREATE TABLE "WORLD_TEMPERATURE" ("id" INTEGER PRIMARY KEY  NOT NULL  UNIQUE , "name" VARCHAR(64) NOT NULL , "desc" CLOB NOT NULL , "short" VARCHAR(32));
INSERT INTO "WORLD_TEMPERATURE" VALUES (2, 'Frozen', 'Frozen worlds are those with so weak a stellar primary or so great a distance that the average temperature is close to absolute zero. Any atmosphere that once existed has long since frozen into drifts of solidified oxygen or lakes of liquid helium. Exposure to these drifts is very dangerous. Vacc suits maintain a tolerable temperature easily because the stellar void is very empty, and there is little conduction of heat between the suit and empty space. Dunking a suit into a lake of thermally-conductive superchilled liquid can force the heating elements into sudden and drastic overload, draining a power cell in minutes even seconds.', 'Frozen');
INSERT INTO "WORLD_TEMPERATURE" VALUES (3, 'Variable; Cold-to-Temperate', 'Variable temperature worlds tend to show a greater distribution of climates than other worlds, either ranging from cold to temperate levels or temperate to hot levels. This may be a climate that changes world-wide when a long, slow orbit brings the planet into proximity with a stellar primary, or it might be a world that has substantially different climactic zones spread across its surface. The north pole of one world might be a sun-blasted desert that moderates to a cool, wet equator, or an icy world might be warmed here and there by complex channels of geothermally-heated subsurface rivers.
Variable temperature worlds tend to have savage weather. The mixing of hot and cold air can send ferocious cyclones and raging hurricanes across the surface of the world, some large enough to consume most of a hemisphere.', 'Var. Cold');
INSERT INTO "WORLD_TEMPERATURE" VALUES (4, 'Cold', 'Cold worlds are uncomfortable, but a human can survive on them in nothing more than heavy clothing. The worst of the cold worlds are similar in condition to Earth’s Antarctic regions, barren wastes of ice and wind. The more clement ones have brief warmer seasons or equatorial bands that get enough solar radiation to support substantial agriculture.
On cold worlds, agricultural land is at a premium. The population is unlikely to be willing to limit its numbers to what hydroponic farms can provide, and they may lack the technology for wide-scale artificial production methods. Savage wars may have broken out over control of fertile growing regions, and populations have perhaps been driven away from the arable land into the cold zones and a lingering death.
Some worlds retain installations from before the Silence deep within the frozen wastes, ancient bases and laboratories that were planted in an age when good launch sites and orbital windows meant more than trifles of temperature. These lost sites might be remembered in legend and story, and some native leaders might still be in possession of the automatic defense bypass codes handed down by their ancestors.', 'Cold');
INSERT INTO "WORLD_TEMPERATURE" VALUES (5, 'Cold', 'Cold worlds are uncomfortable, but a human can survive on them in nothing more than heavy clothing. The worst of the cold worlds are similar in condition to Earth’s Antarctic regions, barren wastes of ice and wind. The more clement ones have brief warmer seasons or equatorial bands that get enough solar radiation to support substantial agriculture.
On cold worlds, agricultural land is at a premium. The population is unlikely to be willing to limit its numbers to what hydroponic farms can provide, and they may lack the technology for wide-scale artificial production methods. Savage wars may have broken out over control of fertile growing regions, and populations have perhaps been driven away from the arable land into the cold zones and a lingering death.
Some worlds retain installations from before the Silence deep within the frozen wastes, ancient bases and laboratories that were planted in an age when good launch sites and orbital windows meant more than trifles of temperature. These lost sites might be remembered in legend and story, and some native leaders might still be in possession of the automatic defense bypass codes handed down by their ancestors.', 'Cold');
INSERT INTO "WORLD_TEMPERATURE" VALUES (6, 'Temperate', 'Temperate worlds were the most popular colony sites, and most of the truly populous worlds of the frontier have a temperate climate. Many temperate worlds have temperature ranges not unlike that of Earth, though most are canted a little further toward cold or heat depending on their angle and proximity to the local star.
Temperate worlds are the most likely to teem with native life as well, and to have alien ruins or remains located somewhere on their surface. Most frontier worlds never accumulated enough population to put a serious strain on a temperate world’s arable land, but this same capaciousness often allow for more complicated social divisions to develop. Natives of other worlds are often forced to cooperate or die, while those of a clement temperate world have the luxury of deep and lasting divisions.', 'Temp.');
INSERT INTO "WORLD_TEMPERATURE" VALUES (7, 'Temperate', 'Temperate worlds were the most popular colony sites, and most of the truly populous worlds of the frontier have a temperate climate. Many temperate worlds have temperature ranges not unlike that of Earth, though most are canted a little further toward cold or heat depending on their angle and proximity to the local star.
Temperate worlds are the most likely to teem with native life as well, and to have alien ruins or remains located somewhere on their surface. Most frontier worlds never accumulated enough population to put a serious strain on a temperate world’s arable land, but this same capaciousness often allow for more complicated social divisions to develop. Natives of other worlds are often forced to cooperate or die, while those of a clement temperate world have the luxury of deep and lasting divisions.', 'Temp.');
INSERT INTO "WORLD_TEMPERATURE" VALUES (8, 'Temperate', 'Temperate worlds were the most popular colony sites, and most of the truly populous worlds of the frontier have a temperate climate. Many temperate worlds have temperature ranges not unlike that of Earth, though most are canted a little further toward cold or heat depending on their angle and proximity to the local star.
Temperate worlds are the most likely to teem with native life as well, and to have alien ruins or remains located somewhere on their surface. Most frontier worlds never accumulated enough population to put a serious strain on a temperate world’s arable land, but this same capaciousness often allow for more complicated social divisions to develop. Natives of other worlds are often forced to cooperate or die, while those of a clement temperate world have the luxury of deep and lasting divisions.', 'Temp.');
INSERT INTO "WORLD_TEMPERATURE" VALUES (9, 'Warm', 'Warm worlds come in two main flavors, depending on the prevalence of water. “Desert worlds” are hot enough or arid enough to be deprived of most surface water. Any life on such a planet has to be capable of extracting water from living prey, air currents or moisture supplies deep underground. Humans can survive on warm worlds without more than appropriate clothing, but desert-world humans must learn sophisticated techniques of water prospecting and well- drilling in order to maintain their agricultural systems. Warfare often revolves around these water systems.
The other common variety of warm world is one blessed with an abundance of surface water. These worlds tend to be covered with plant and animal life, teeming with thick jungles and vast mats of sargasso on seas that boil with piscids and other alien life analogs. These worlds can be quite prosperous for humans if the native life is edible, but inhabitants are often forced to deal with large predators and a vividly ingenious native ecology of disease.', 'Warm');
INSERT INTO "WORLD_TEMPERATURE" VALUES (10, 'Warm', 'Warm worlds come in two main flavors, depending on the prevalence of water. “Desert worlds” are hot enough or arid enough to be deprived of most surface water. Any life on such a planet has to be capable of extracting water from living prey, air currents or moisture supplies deep underground. Humans can survive on warm worlds without more than appropriate clothing, but desert-world humans must learn sophisticated techniques of water prospecting and well- drilling in order to maintain their agricultural systems. Warfare often revolves around these water systems.
The other common variety of warm world is one blessed with an abundance of surface water. These worlds tend to be covered with plant and animal life, teeming with thick jungles and vast mats of sargasso on seas that boil with piscids and other alien life analogs. These worlds can be quite prosperous for humans if the native life is edible, but inhabitants are often forced to deal with large predators and a vividly ingenious native ecology of disease.', 'Warm');
INSERT INTO "WORLD_TEMPERATURE" VALUES (11, 'Variable; Temperate-to-Warm', 'Variable temperature worlds tend to show a greater distribution of climates than other worlds, either ranging from cold to temperate levels or temperate to hot levels. This may be a climate that changes world-wide when a long, slow orbit brings the planet into proximity with a stellar primary, or it might be a world that has substantially different climactic zones spread across its surface. The north pole of one world might be a sun-blasted desert that moderates to a cool, wet equator, or an icy world might be warmed here and there by complex channels of geothermally-heated subsurface rivers.
Variable temperature worlds tend to have savage weather. The mixing of hot and cold air can send ferocious cyclones and raging hurricanes across the surface of the world, some large enough to consume most of a hemisphere.', 'Var. Warm');
INSERT INTO "WORLD_TEMPERATURE" VALUES (12, 'Burning', 'Burning worlds are too hot for a human to survive without equipment similar to a vacc suit in effectiveness. Rivulets of molten lead or copper might bleed from open veins on the hillsides, and many of the same perils that face an explorer on a frozen world have hotter equivalents on a burning one. Ash drifts, pools of molten metal, and superheated liquid vents can bring quick death to an unwary explorer, and the miners who inhabit such worlds must be forever vigilant against the perils of their burning home.', 'Burning');
