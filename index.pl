#!/usr/bin/env perl

use strict;
use warnings;

my $file_text = '';
open my $fh, '<', 'index.html';
while (<$fh>) {
  $file_text .= $_;
}
close $fh;
print "Content-type: text/html\n\n";
print <<EOF
$file_text
EOF
;
