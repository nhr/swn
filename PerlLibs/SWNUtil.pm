package SWNUtil;
use strict;

BEGIN {
    our $VERSION   = 1.00;
    our @ISA       = qw(Exporter);
    our @EXPORT    = qw(cell_id sys_name tagify filename random_seed
                        tokenize_seed untokenize_seed get_includes_dir
                        get_fonts_dir get_output_dir get_readme);
    our @EXPORT_OK = qw();
    require Exporter;
}

use Cwd qw(abs_path);
use File::Spec;
my ($swnu_volume, $swnu_directory, $swnu_file) = File::Spec->splitpath(__FILE__);

use constant SEED_MAX => 4294967296; # 2^32 i.e. MAXINT

my $IPATH = File::Spec->catpath($swnu_volume, $swnu_directory, 'Includes');
my $FPATH = File::Spec->catpath($swnu_volume, $swnu_directory, 'Fonts');
my $OPATH = File::Spec->catpath($swnu_volume, $swnu_directory, 'Output');
if ($swnu_directory =~ /Test/ or $swnu_directory =~ /cgi-bin/ or $swnu_directory =~ /PerlLibs/) {
    $IPATH = File::Spec->catpath($swnu_volume, $swnu_directory, '../Includes');
    $FPATH = File::Spec->catpath($swnu_volume, $swnu_directory, '../Fonts');
    $OPATH = File::Spec->catpath($swnu_volume, $swnu_directory, '../Output');
}

sub cell_id {
    my %args = @_;
    my $row  = $args{row};
    my $col  = $args{col};

    return '0'.$col.'0'.$row;
}

sub sys_name {
    my %args = @_;
    my $star = $args{star};
    my $cell = $args{cell};

    return 'System:'.uc($star);
}

sub random_seed {
    # No args

    my $seed = int(rand(SEED_MAX));
    return ($seed == 0) ? 1 : $seed;
}

sub tagify {
    my $txt = shift;
    my @words = split ' ', $txt;
    return join('', map { ucfirst(lc($_)) } @words);
}

sub filename {
    my $txt = shift;
    my @words = split ' ', $txt;
    return join '_', @words;
}

sub tokenize_seed {
    my $seed = shift;

    # Alpha caps (26) + Numbers (10)
    my $base = 36;

    # Translate the ID to the new base
    my @pieces;
    while ($seed) {
	my $num = $seed % $base;
	$seed = int($seed/$base);
	
	my $chr = $num > 9 ? chr(ord('A') + $num - 10) : $num;
	unshift @pieces, $chr;
    }

    return join("", @pieces);
}

sub untokenize_seed {
    my $token = shift;

    my @chars = split '', $token;
    my $seed  = 0;
    my $mult  = 1;
    for (my $i = @chars - 1; $i >= 0; $i--) {
	my $char = $chars[$i];
	my $num  = $char;

	$num = ord($char) - ord('A') + 10
	    if $num !~ /^\d$/;

	$seed += $num * $mult;
	$mult *= 36; # Same base as above.
    }

    # A user-entered seed may work out to be larger than maxint.
    $seed = SEED_MAX - 1
	if $seed >= SEED_MAX;
    
    # ...or too small.
    $seed = 1
	if $seed < 1;

    return $seed;
}

sub get_includes_dir {
    return abs_path($IPATH);
}

sub get_fonts_dir {
    return abs_path($FPATH);
}

sub get_output_dir {
    return abs_path($OPATH);
}

sub get_readme {
    my $email = 'swn_generator@emichron.com';
    my $txt   = 
qq(SWN Sector Generator
===================

A utility for use with [Stars Without Number](http://www.sinenomine-pub.com/).


## Contents
The zip file that you've unpacked contains the following items:

* This README file
* A 'GM version' of the sector that you generated
* A 'PC version' of the sector that you generated
* A star map image file (if you generated the sector in Internet Explorer)


## How to Use
Open the GM version of the sector wiki in your browser and have a look around.
In particular, check out the 'GM Info' article. It will help you to use these
pre-generated sectors to their best effect. If you aren't familiar with how
[TiddlyWiki][] works, check out the excellent documentation at the TiddlyWiki
website.

[TiddlyWiki]: http://www.tiddlywiki.com/


## Other Cool Things to Know
If you use any browser other than Internet Explorer to generate your sector,
you will get a version of the sector wiki where the star map image is embedded
directly in the HTML file. This is particularly useful if you own an iPad,
because then you can use the extremely cool [TWEdit][] app to view and
edit your sector wiki directly on the iPad, with a fully interactive star map.

[TWEdit]: http://itunes.apple.com/us/app/twedit/id409607956?mt=8


## Credits
The SWN Sector Generator
Copyright © 2011 N. Harrison Ripps <${email}>

This utility is based on and written for use with the **Stars Without Number**
Science Fiction Roleplaying Game by [Sine Nomine Publishing][]

TiddlyWiki and the various TiddlyWiki Plugins used in this distribution are
copyright to their respective owners. See "Backstage -> Plugins" in either of
the wiki files for more info.

* [Perl](http://www.perl.org/) and several freely available Perl Libraries are
  used to generate the sector and star map:
** [Archive::Zip](http://search.cpan.org/~adamk/Archive-Zip-1.30/lib/Archive/Zip.pm)
** [Cwd](http://search.cpan.org/~smueller/PathTools-3.33/Cwd.pm)
** [Data::RandomPerson](http://search.cpan.org/~peterhi/Data-RandomPerson-0.4/lib/Data/RandomPerson.pm)
** [DBI](http://search.cpan.org/~timb/DBI-1.616/DBI.pm)
** [GD](http://search.cpan.org/~lds/GD-2.46/GD.pm)
** [GD::Text](http://search.cpan.org/~mverb/GDTextUtil-0.86/Text.pm)
** [MIME::Base64](http://search.cpan.org/~gaas/MIME-Base64-3.13/Base64.pm)
* [SQLite](http://www.sqlite.org/) is used to store and retrieve table data
  used throughout the wiki entries.
* Extra name generation help came directly from [Chris Pound][]'s amazing
  language generators.

[Sine Nomine Publishing]: http://www.sinenomine-pub.com/
[Chris Pound]: http://www.ruf.rice.edu/~pound/
);

    return $txt;
}

1;
