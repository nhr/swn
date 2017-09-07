package LC;
use strict;

BEGIN {
    our $VERSION   = 1.00;
    our @ISA       = qw(Exporter);
    our @EXPORT    = qw(conflux);
    our @EXPORT_OK = qw();
    require Exporter;
}

use File::Spec;
my ($lc_volume, $lc_directory, $lc_file) = File::Spec->splitpath(__FILE__);

# lc -- language confluxer (http://www.ruf.rice.edu/~pound/revised-lc)
#
# - Written by Christopher Pound (pound@rice.edu), July 1993.
# - Loren Miller suggested I make sure lc starts by picking a
#   letter pair that was at the beginning of a data word, Oct 95.
# - Cleaned it up a little bit, March 95; more, September 01

use constant {
  MIN_LENGTH => 3,
  MAX_LENGTH => 7,
};

my %hash  = ();
my $FPATH = File::Spec->catpath($lc_volume,$lc_directory,'Includes');
if ($lc_directory =~ /Test/ or $lc_directory =~ /cgi-bin/ or $lc_directory =~ /PerlLibs/) {
    $FPATH = File::Spec->catpath($lc_volume,$lc_directory,'../Includes');
}

sub conflux {
    my %args   = @_;
    my $file   = $args{file};
    my $number = $args{number};

    # Read in the data, cleaning it up as we go, and making it one long array
    my $fp = $FPATH.'/'.$file.'.txt';
    open my $fh, '<', $fp
	or die "$fp: $!\n";

    my @data = ();
    while (<$fh>) {
	s/#.*//;
	next
	    unless length;
	s/^\s*//; 
	s/\s*\n//; 
	s/\s+/ /;
	push(@data, ' ', split('', $_)); 
    }

    # Let's assume the first letter could follow the last pair (loop around)
    push(@data, ' ', $data[1]);

    # Clean out the hash object.
    %hash = ();

    # Now, load our hash of character pairs and the letters that may follow them,
    # keeping track of which pairs can be at the start of a word
    my @start_pairs = ();
    while (@data > 2) {
	my ($first, $second, $third) = @data[0..2];
	$hash{$first.$second} .= $third;
	push(@start_pairs, $second.$third) if ($first eq ' ');
	shift @data; 
    }

    # Loop to generate new words, beginning with a start_pair; find a word,
    # then continue to the next word using the last two characters (the last
    # of which will be whitespace) from the previous word as a "seed" for the new;
    # oh, and only print the first $max_length characters of any words
    my @words = ();
    my $new = $start_pairs[rand @start_pairs];
    for (my $i = 0; $i < $number; $i++) {
	$new = &new_word(substr($new, -2, 2));
	push @words, substr($new, 0, MAX_LENGTH);
    }
    
    return \@words;
}

# Messy recursive function to build a word, getting rid of short words 
# and handling "seeds" from previous words properly
sub new_word {
    my $word   = pop;
    my $pair   = substr($word, -2, 2);
    my $letter = substr($hash{$pair}, rand length($hash{$pair}), 1);
    if ($word =~ /\s$/) {
	return $word
	    if length($word) > MIN_LENGTH;
	return &new_word(substr($word, -1, 1).$letter);
    }
    else {
	$word =~ s/^\s//;
	return &new_word($word.$letter);
    }
}


1;
