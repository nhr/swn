package SWN2WIKI;
use strict;

BEGIN {
    our $VERSION   = 1.00;
    our @ISA       = qw(Exporter);
    our @EXPORT    = qw(generate_wiki render_map);
    our @EXPORT_OK = qw();
    require Exporter;
}

use SWNUtil;

use Archive::Zip qw(:ERROR_CODES :CONSTANTS);
use Data::Dumper;
use GD;
use GD::Image;
use GD::Polyline;
use GD::Text;
use MIME::Base64 qw(encode_base64);

use constant { MAP_X   => 38,
	       MAP_COL => 67,
	       MAP_MOD => 38,
	       MAP_ROW => 78,
	       BLLX    => 0,
	       BLLY    => 1,
	       BLRX    => 2,
	       BLRY    => 3,
	       BURX    => 4,
	       BURY    => 5,
	       BULX    => 6,
	       BULY    => 7,
	       FSIZE   => 9,
	       DEBUG   => 0,
             };

my $GM_COLOR  = 'FF0000';
my $OUT_PATH  = get_output_dir();
my $INC_PATH  = get_includes_dir();
my $FONT_PATH = get_fonts_dir();
my $SOURCE    = $INC_PATH.'/swn.html';
my $FONT      = $FONT_PATH.'/ProFontWindows.ttf';

sub generate_wiki {
    my %args   = @_;
    my $s      = $args{sector};
    my $time   = $args{time};
    my $cgi    = $args{cgi};
    my $for_ie = $args{for_ie};

    $cgi = 0
	unless defined $cgi;

    my $sector_name = $s->{name};
    my $token       = $s->{token};

    # Make the TiddlyWiki-style time stamp.
    my @tvals      = localtime $time;
    my $tyr        = $tvals[5] + 1900;
    my $tmon       = $tvals[4] + 1;
    $tmon          = '0'.$tmon
	if length $tmon == 1;
    my $tday       = length $tvals[3] == 1 ? '0'.$tvals[3] : $tvals[3];
    my $thr        = length $tvals[2] == 1 ? '0'.$tvals[2] : $tvals[2];
    my $tmin       = length $tvals[1] == 1 ? '0'.$tvals[1] : $tvals[1];
    my $time_stamp = $tyr.$tmon.$tday.$thr.$tmin;

    # Make the star map image.
    my ($mapobj, $areas) = render_map( sector_name => $s->{name},
				       star_map    => $s->{map},
				       for_ie      => $for_ie,
	                              );

    # Make the sector map
    my $sm_txt = _markup_sector_map( worlds   => $s->{worlds},
				     star_map => $s->{map},
	                           );

    # Make the planetary directory
    my $gm_pd_txt = _markup_planetary_lists( worlds   => $s->{worlds},
					     star_map => $s->{map},
					     for_pc   => 0,
	                                   );
    my $pc_pd_txt = _markup_planetary_lists( worlds   => $s->{worlds},
					     star_map => $s->{map},
					     for_pc   => 1,
	                                   );

    my $pc_bkmk = join("\n",
		       '----',
		       '[[Alien Races]]',
		       '[[Political Groups]]',
		       '[[Corporations|Corporation Listing]]',
		       '[[Religions|Sector Religions]]',
	              );

    my $gm_bkmk = $pc_bkmk . "\n[[NPCs|NPC Listing]]";

    my $gm_art_txt = _markup_articles( sector     => $s,
				       time_stamp => $time_stamp,
				       for_pc     => 0,
	                             );

    my $pc_art_txt = _markup_articles( sector     => $s,
				       time_stamp => $time_stamp,
				       for_pc     => 1,
	                             );

    my $gm_link = "----\n[[GM Info]]";
    my $pc_link = "----";

    my $starimg = 'data:image/png;base64,'.$mapobj;
    my $starurl = '';
    my $starfn  = 'SWN_wiki_'.$token.'.png';
    if ($for_ie) {
	$starimg = '';
	$starurl = $starfn;
    }

    # Open the TiddlyWiki source file.
    open my $sfh, '<', $SOURCE;

    # Open the target files.
    my $gmfn = 'SWN_wiki_'.$token.'_GM.html';
    my $pcfn = 'SWN_wiki_'.$token.'_PC.html';

    my $gmstr = '';
    my $pcstr = '';

    while (<$sfh>) {
	my $gm_line = $_;
	my $pc_line = $_;

	$gm_line =~ s/\$\$GMINFO/$gm_link/;
	$pc_line =~ s/\$\$GMINFO/$pc_link/;

	$gm_line =~ s/\$\$SEED_TOKEN/$token/;
	$pc_line =~ s/\$\$SEED_TOKEN/$token/;

	$gm_line =~ s/\$\$SECTOR_NAME/$sector_name/g;
	$pc_line =~ s/\$\$SECTOR_NAME/$sector_name/g;

	$gm_line =~ s/\$\$SECTOR_MAP/$sm_txt/;
	$pc_line =~ s/\$\$SECTOR_MAP/$sm_txt/;

	$gm_line =~ s/\$\$PLANETARY_DIRECTORY/$gm_pd_txt/;
	$pc_line =~ s/\$\$PLANETARY_DIRECTORY/$pc_pd_txt/;

	$gm_line =~ s/\$\$PLANET_LIST/$gm_bkmk/;
	$pc_line =~ s/\$\$PLANET_LIST/$pc_bkmk/;

	$gm_line =~ s/\$\$STARMAP/$starimg/;
	$pc_line =~ s/\$\$STARMAP/$starimg/;

	$gm_line =~ s/\$\$STARURL/$starurl/;
	$pc_line =~ s/\$\$STARURL/$starurl/;

	$gm_line =~ s/\$\$MAP_LINKS/$areas/;
	$pc_line =~ s/\$\$MAP_LINKS/$areas/;

	$gm_line =~ s/\$\$TIME_STAMP/$time_stamp/;
	$pc_line =~ s/\$\$TIME_STAMP/$time_stamp/;

	$gm_line =~ s/<\!--\$\$SECTOR_INFO-->/$gm_art_txt/;
	$pc_line =~ s/<\!--\$\$SECTOR_INFO-->/$pc_art_txt/;

	$gmstr .= $gm_line;
	$pcstr .= $pc_line;
    }

    close $sfh;

    if (not $cgi) {
	open my $gmfh, '>', $OUT_PATH.'/'.$gmfn
	    or die "Could not create GM file: $!";
	print $gmfh $gmstr;
	close $gmfh;

	open my $pcfh, '>', $OUT_PATH.'/'.$pcfn
	    or die "Could not create PC file: $!";
	print $pcfh $pcstr;
	close $pcfh;

	return;
    }

    my $zfn = 'SWN_wiki_'.$token.'.zip';

    # Open a scalar filehandle.
    my $zipfile;
    open my $zfh, '>', \$zipfile;

    my $zip = Archive::Zip->new();
    $zip->addString(get_readme(), 'README.text');
    $zip->addString($gmstr,  $gmfn);
    $zip->addString($pcstr,  $pcfn);
    $zip->addString($mapobj, $starfn)
	if $for_ie;

    die "Could not write zip file"
	unless $zip->writeToFileHandle($zfh) == AZ_OK;

    close $zfh;

    return $zipfile;
}

sub render_map {
    my %args        = @_;
    my $sector_name = $args{sector_name};
    my $star_map    = $args{star_map};
    my $for_ie      = $args{for_ie} || 0;

    my %star_ref = map { $_->{cell} => $_->{id} } @$star_map;

    open my $hfh, '<', $INC_PATH.'/swnmap.png';
    open my $sfh, '<', $INC_PATH.'/swndot.png';
    my $img = GD::Image->newFromPng($hfh);
    my $dot = GD::Image->newFromPng($sfh);
    my ($dotw, $doth) = $dot->getBounds();
    close $hfh;
    close $sfh;
    my $black = $img->colorClosest(0,0,0);
    my $blue  = $img->colorClosest(0,0,255);

    my $x = MAP_X;
    my $y = 32;

    my $areas = '';
    my $first = 1;
    for (my $row = 0; $row < 10; $row++) {
	for (my $col = 0; $col < 8; $col++) {
	    my $cell  = cell_id( col => $col, row => $row );
	    my $cname = '';
	    if (exists $star_ref{$cell}) {
		$cname = $star_map->[$star_ref{$cell}]{name};
	    }

	    my $ly  = $y;
	    if ($col % 2) {
		$ly += MAP_MOD;
	    }
	    else {
		$x += 1;
	    }

	    if ($cname) {
		$img->copy($dot, $x, $ly, 0, 0, $dotw, $doth);

		# Start building up a coordinate map for image links.
		my @coords = ($x,$ly+$doth,$x,$ly,$x+$dotw,$ly,$x+$dotw,$ly+$doth);

		my @res = GD::Image->stringFT($black, $FONT, FSIZE, 0, $x, $ly, uc($cname));
		my $w   = $res[BLRX] - $res[BLLX];
		my $h   = $res[BLLY] - $res[BULY];
		my $cx  = $x  - int($w/2) + 8;
		my $cy  = $ly + int($h/2) + 22;
		my @srs = $img->stringFT($black, $FONT, FSIZE, 0, $cx, $cy, uc($cname));

		# Finish the coordinate map.
		push @coords, $srs[BURX], $srs[BURY], $srs[BLRX], $srs[BLRY], $srs[BLLX], $srs[BLLY], $srs[BULX], $srs[BULY], $x, $ly + $doth;

		# Save the coordinate map for later.
		if ($first) {
		    $first = 0;
		}
		else {
		    $areas .= "----\n";
		}
		$areas .= sys_name( star => $cname, cell => $cell )."\n".join(',', @coords)."\n";

		# Turn on DEBUG to see the coordinate outline on the image.
		if (DEBUG) {
		    my $ply = GD::Polyline->new();
		    for (my $xidx = 0; $xidx < @coords; $xidx += 2) {
			my $xv = $coords[$xidx];
			my $yv = $coords[$xidx + 1];
			$ply->addPt($xv,$yv);
		    }
		    $img->polydraw($ply,$blue);
		}
	    }
	    
	    $x += MAP_COL;
	}
	$x = MAP_X;
	$y += MAP_ROW;
    }

    return ($img->png, $areas)
	if $for_ie;

    my $encdata = encode_base64($img->png,'');
    
    return ($encdata, $areas);
}

sub _markup_sector_map {
    my %args     = @_;
    my $worlds   = $args{worlds};
    my $star_map = $args{star_map};

    my %wmap = ();
    foreach my $w (sort { $a->{sys_pos} <=> $b->{sys_pos} } @$worlds) {
	$wmap{$w->{star_id}} = []
	    unless defined $wmap{$w->{star_id}};

	push @{$wmap{$w->{star_id}}}, $w;
    }

    my $txt = '|[img[StarMap]]&lt;&lt;imageMap StarMapLinks&gt;&gt;|!Hex|!World or Station|'."\n";

    foreach my $s ( sort { $a->{cell} cmp $b->{cell} } @$star_map ) {
	my $sysname  = sys_name( star => $s->{name}, cell => $s->{cell} );
	my $cell_str = '[['.$s->{cell}.'|'.$sysname.']]';
	foreach my $w (@{$wmap{$s->{id}}}) {
	    $txt .= '|~|'.$cell_str.'|[['.$w->{name}.'|Planet:'.$w->{name}.']]|'."\n";
	    $cell_str = '~';
	}
    }

    return $txt;
}

sub _markup_planetary_lists {
    my %args     = @_;
    my $worlds   = $args{worlds};
    my $star_map = $args{star_map};
    my $for_pc   = $args{for_pc};

    my $dirtxt = '|!Hex|!World or Station|!Atmo.|!Temp.|!Biosphere|!Population|!TL|';
    $dirtxt .= '!@@color:#'.$GM_COLOR.';Tags@@|'
	unless $for_pc;
    $dirtxt .= "h\n";

    foreach my $w (sort { $a->{name} cmp $b->{name} } @$worlds) {
	my $s       = $star_map->[$w->{star_id}];
	my $sysname = sys_name( star => $s->{name}, cell => $s->{cell} );
	my $tags    = '@@color:#'.$GM_COLOR.';'.$w->{tags}[0]{short}.', '.$w->{tags}[1]{short}.'@@';
	my $plname  = '[['.$w->{name}.'|Planet:'.$w->{name}.']]';

	my @flds    = ('[['.$s->{cell}.'|'.$sysname.']]', $plname, $w->{atmosphere}{short},
		       $w->{temperature}{short}, $w->{biosphere}{short},
		       $w->{population}{short}, $w->{tech_level}{short});
	push @flds, $tags
	    unless $for_pc;

	$dirtxt .= '|'.join('|', @flds)."|\n"; 
    }

    return $dirtxt;
}

sub _markup_articles {
    my %args       = @_;
    my $s          = $args{sector};
    my $time_stamp = $args{time_stamp};
    my $for_pc     = $args{for_pc};

    my $worlds     = $s->{worlds};
    my $star_map   = $s->{map};

    my %systems = ();
    my %atms    = ();
    my %temps   = ();
    my %bios    = ();
    my %pops    = ();
    my %tls     = ();
    my %tags    = ();

    my $txt = '';
    foreach my $w (sort { $a->{name} cmp $b->{name} } @$worlds) {
	my $star    = $star_map->[$w->{star_id}];
	my $sysname = sys_name( star => $star->{name},
				cell => $star->{cell},
	                      );

	# Track our systems.
	$systems{$sysname} = { star    => $star->{name},
			       cell    => $star->{cell},
	                       planets => {},
	                     }
	    unless exists $systems{$sysname};

	$systems{$sysname}{planets}{$w->{sys_pos}} = $w->{name};

	my $p = join
	    ("\n",
	     '\'\'//Nav Designation//: [['.$star->{name}.'|'.$sysname.']] '.$w->{sys_num}.'\'\'',
	     '|!Atmosphere |'.$w->{atmosphere}{name}.'|',
	     '|!Temperature|'.$w->{temperature}{name}.'|',
	     '|!Biosphere  |'.$w->{biosphere}{name}.'|',
	     '|!Population |'.$w->{population}{name}.'|',
	     '|!Tech Level |'.$w->{tech_level}{name}.'|',
	    );

	unless ($for_pc) {
	    $p .= "\n".join
		("\n",
		 '|!@@color:#'.$GM_COLOR.';Tags@@|@@color:#'.$GM_COLOR.';'.$w->{tags}[0]{name}.', '.$w->{tags}[1]{name}.'@@|',
		 '!!!@@color:#'.$GM_COLOR.';Enemies@@',
		 '@@color:#'.$GM_COLOR.';'.$w->{tags}[0]{enemies}.'; '.$w->{tags}[1]{enemies}.'@@',
		 '!!!@@color:#'.$GM_COLOR.';Friends@@',
		 '@@color:#'.$GM_COLOR.';'.$w->{tags}[0]{friends}.'; '.$w->{tags}[1]{friends}.'@@',
		 '!!!@@color:#'.$GM_COLOR.';Complications@@',
		 '@@color:#'.$GM_COLOR.';'.$w->{tags}[0]{complications}.'; '.$w->{tags}[1]{complications}.'@@',
		 '!!!@@color:#'.$GM_COLOR.';Places@@',
		 '@@color:#'.$GM_COLOR.';'.$w->{tags}[0]{places}.'; '.$w->{tags}[1]{places}.'@@',
		 '!!!@@color:#'.$GM_COLOR.';Things@@',
		 '@@color:#'.$GM_COLOR.';'.$w->{tags}[0]{things}.'; '.$w->{tags}[1]{things}.'@@',
		 '!!@@color:#'.$GM_COLOR.';Capital and Government@@',
		 '!!@@color:#'.$GM_COLOR.';Cultural Notes@@',
		 '!!@@color:#'.$GM_COLOR.';Adventures Prepared@@',
		 '!!@@color:#'.$GM_COLOR.';Party Activities on this World@@',
		);
	}
	else {
	    $p .= "\n!!!Notes\n//Add your own notes here//\n";
	}

	my $atag = 'Atmosphere:'.tagify($w->{atmosphere}{short});
	my $ttag = 'Temperature:'.tagify($w->{temperature}{short});
	my $btag = 'Biosphere:'.tagify($w->{biosphere}{short});
	my $ptag = 'Population:'.$w->{population}{short};
	my $ltag = 'TechLevel:'.$w->{tech_level}{short};
	my $tag1 = 'Tag:'.tagify($w->{tags}[0]{short});
	my $tag2 = 'Tag:'.tagify($w->{tags}[1]{short});

	$atms{$atag}  = { name => $w->{atmosphere}{name},  desc => $w->{atmosphere}{desc}  }
	    unless exists $atms{$atag};
	$temps{$ttag} = { name => $w->{temperature}{name}, desc => $w->{temperature}{desc} }
	    unless exists $temps{$ttag};
	$bios{$btag}  = { name => $w->{biosphere}{name},   desc => $w->{biosphere}{desc}   }
	    unless exists $bios{$btag};
	$pops{$ptag}  = { name => $w->{population}{name},  desc => $w->{population}{desc}  }
	    unless exists $pops{$ptag};
	$tls{$ltag}   = { name => $w->{tech_level}{name},  desc => $w->{tech_level}{desc}  }
	    unless exists $tls{$ptag};
	$tags{$tag1}  = { name => $w->{tags}[0]{name},     desc => $w->{tags}[0]{desc}     }
	    unless exists $tags{$tag1};
	$tags{$tag2}  = { name => $w->{tags}[1]{name},     desc => $w->{tags}[1]{desc}     }
	    unless exists $tags{$tag2};

	my @all_tags = ('System:'.uc($star_map->[$w->{star_id}]{name}), 'Planet:'.$w->{name}, $atag, $ttag, $btag, $ptag, $ltag);
	push @all_tags, $tag1, $tag2
	    unless $for_pc;

	my $tags = join ' ', @all_tags;

	$txt .= '<div title="Planet:'.$w->{name}.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$tags.'" changecount="1">'."\n";
	$txt .= '<pre>'.$p.'</pre>'."\n";
	$txt .= '</div>'."\n";
    }

    foreach my $s (sort { $a cmp $b } keys %systems) {
	my $tags  = join(' ', 'System:'.uc($systems{$s}{star}), map { 'Planet:'.$systems{$s}{planets}{$_} } sort { $a <=> $b } keys %{$systems{$s}{planets}});
	my @links = map { '[['.$systems{$s}{planets}{$_}.'|Planet:'.$systems{$s}{planets}{$_}.']]' } sort { $a <=> $b } keys %{$systems{$s}{planets}};
	$txt .= '<div title="'.$s.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$tags.'" changecount="1">'."\n";
	$txt .= '<pre>|!Nav Designation|\'\'GRID '.$systems{$s}{cell}."''|\n";
	my $tl   = '!System Planet'.( @links > 1 ? 's' : '');
	my $lidx = 0;
	foreach my $link (@links) {
	    my $c1 = ($lidx == 0) ? $tl : '~';
	    $txt .= '|'.$c1.'|'.$link.'|'."\n";
	    $lidx++;
	}
	$txt .= "</pre>\n</div>\n";
    }

    my @tag_lists = (\%atms, \%temps, \%bios, \%pops, \%tls);
    push @tag_lists, \%tags
	unless $for_pc;

    foreach my $list (@tag_lists) {
	foreach my $tag (keys %$list) {
	    my $name = $list->{$tag}{name};
	    my $desc = $list->{$tag}{desc};

	    $txt .= '<div title="'.$tag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">'."\n";
	    $txt .= '<pre>\'\''.$name.'\'\' - '.$desc.''."\n".'</pre>'."\n";
	    $txt .= '</div>'."\n";	    
	}
    }

    my @corp_arts = ();
    my %corp_tags = ();

    # Make the Corp articles; we do the listing page and the articles simultaneously.
    $txt .= '<div title="Corporation Listing" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">'."\n";
    $txt .= '<pre>'."\n";
    $txt .= '|!Company Name|!Business|h'."\n";
    foreach my $corp (sort { $a->{name} cmp $b->{name} } @{$s->{corps}}) {
	my $title  = 'Corp:'.tagify($corp->{name});
	my $biztag = 'Business:'.tagify($corp->{business});

	unless (exists $corp_tags{$biztag}) {
	    my $bta = join
		("\n",
		 '<div title="'.$biztag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		 '<pre></pre>',
		 '</div>'
		);
	    $corp_tags{$biztag} = $bta;
	}

	$txt .= '|[['.$corp->{name}.'|'.$title.']]|'.$corp->{business}.'|'."\n";

	# Write the article
	my $art   = join
	    ("\n",
	     '<div title="'.$title.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$title.' '.$biztag.'" changecount="1">',
	     '<pre>',
	     '|!Name      |'.$corp->{name}.'|',
	     '|!Business  |'.$corp->{business}.'|',
	    );

	$art .= "\n".'|!@@color:#'.$GM_COLOR.';Reputation@@|@@color:#'.$GM_COLOR.';'.$corp->{reputation}.'@@|'."\n"
	    unless $for_pc;

	$art .= "\n".join
	    ("\n",
	     '!!!Notes',
	     '</pre>',
	     '</div>',
	    );

	push @corp_arts, $art;
    }
    $txt .= '</pre>'."\n";
    $txt .= '</div>'."\n";

    $txt .= join("\n", @corp_arts)."\n";
    $txt .= join("\n", values %corp_tags)."\n";

    my @rel_arts  = ();
    my @her_arts  = ();
    my %rel_otags = ();

    # Make the Religion and Heresy articles; we do the listing page and the articles simultaneously.
    $txt .= '<div title="Sector Religions" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">'."\n";
    $txt .= '<pre>'."\n";
    $txt .= '|!Religion|!Origin|!Leadership|h'."\n";
    foreach my $rel (sort { $a->{origin} cmp $b->{origin} } @{$s->{rels}}) {
	my $title = 'Religion:'.tagify($rel->{name});
	my $otag  = 'Origin:'.tagify($rel->{origin});
	my ($ltype, $ldesc) = split '\.', $rel->{leadership};

	$txt .= '|[['.$rel->{name}.'|'.$title.']]|'.$rel->{origin}.'|'.$ltype.'|'."\n";

	my $rtags = $title.' '.$otag;

	unless (exists $rel_otags{$otag}) {
	    my $oa = join
		("\n",
		 '<div title="'.$otag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		 '<pre></pre>',
		 '</div>'
		);
	    $rel_otags{$otag} = $oa;
	}

	my $hlinks = '';
	unless ($for_pc) {
	    my $hers   = $rel->{offshoots};
	    foreach my $her (sort { $a->{name} cmp $b->{name} } @$hers) {
		my $htag = 'Heresy:'.tagify($her->{name});
		my ($ftype, $fdesc) = split ':', $her->{founder};
		$hlinks .= '|[['.$her->{name}.'|'.$htag.']]|'.$her->{quirk}.'|'.$ftype.'|'."\n";
		$rtags  .= ' '.$htag;
		my $ha = join
		    ("\n",
		     '<div title="'.$htag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$title.'" changecount="1">',
		     '<pre>',
		     '|!Name   |'.$her->{name}.'|',
		     '|!Origin |[['.$rel->{name}.'|'.$title.']]|',
		     '|!Founder|'.$her->{founder}.'|',
		     '|!Quirk  |'.$her->{quirk}.'|',
		     '!!!Major Heresy',
		     $her->{heresy},
		     '!!!Attitude towards Orthodoxy',
		     $her->{attitude},
		     '</pre>',
		     '</div>',
		    );
		push @her_arts, $ha;
	    }
	}

	# Write the article
	my $art   = join
	    ("\n",
	     '<div title="'.$title.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$rtags.'" changecount="1">',
	     '<pre>',
	     '|!Name      |'.$rel->{name}.'|',
	     '|!Origin    |'.$rel->{origin}.'|',
	     '!!!Leadership',
	     $rel->{leadership},
	     '!!!Evolution',
	     $rel->{evolution},
	    );

	$art .= "\n".'!!!@@color:#'.$GM_COLOR.';Heresies@@'."\n".'|!Name|!Quirk|!Founder|h'."\n".$hlinks
	    unless $for_pc;

	$art.= join
	    ("\n",
	     '!!!Notes',
	     '</pre>',
	     '</div>',
	    );

	push @rel_arts, $art;
    }
    $txt .= '</pre>'."\n";
    $txt .= '</div>'."\n";

    $txt .= join("\n", @rel_arts)."\n";
    $txt .= join("\n", values %rel_otags)."\n";
    $txt .= join("\n", @her_arts)."\n"
	unless $for_pc;

    my @pol_arts = ();
    my %iss_tags = ();
    my %pcy_tags = ();

    # Make the Political Group articles; we do the listing page and the articles simultaneously.
    $txt .= '<div title="Political Groups" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">'."\n";
    $txt .= '<pre>'."\n";
    $txt .= '|!Organization|!Leadership|!Policy|!Outsiders|!Issues|h'."\n";
    foreach my $pol (sort { $a->{name} cmp $b->{name} } @{$s->{pols}}) {
	my $title = 'Group:'.tagify($pol->{name});
	my ($ptype, $pdesc) = split ':', $pol->{policy};
	my ($ltype, $ldesc) = split ':', $pol->{leadership};
        my ($otype, $odesc) = split ':', $pol->{relationship};
	my $ptag = 'Ideology:'.tagify($ptype);

	my $tags = $title.' '.$ptag;

	unless (exists $pcy_tags{$ptag}) {
	    my $pt = join
		("\n",
		 '<div title="'.$ptag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		 '<pre>\'\''.$ptype.'\'\': '.$pdesc.'</pre>',
		 '</div>'
		);
	    $pcy_tags{$ptag} = $pt;
	}

	my $itagtxt = '';
	my $itbltxt = '';
	foreach my $iss (@{$pol->{issues}}) {
	    if ($itbltxt eq '') {
		$itbltxt = $iss->{tag};
	    }
	    else {
		$itbltxt .= ', '.$iss->{tag};
	    }
	    my $itag = 'Issue:'.tagify($iss->{tag});
	    $itagtxt .= '* '.$iss->{issue}."\n";
	    $tags .= ' '.$itag;
	    unless (exists $iss_tags{$itag}) {
		my $it = join
		    ("\n",
		     '<div title="'.$itag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		     '<pre>'.$iss->{issue}.'</pre>',
		     '</div>'
		    );
		$iss_tags{$itag} = $it;
	    }
	}

	$txt .= '|[['.$pol->{name}.'|'.$title.']]|'.$ltype.'|'.$ptype.'|'.$otype.'|'.$itbltxt.'|'."\n";

	# Write the article
	my $art = join
	    ("\n",
	     '<div title="'.$title.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$tags.'" changecount="1">',
	     '<pre>',
	     '|!Name      |'.$pol->{name}.'|',
	     '!!!Ideology',
	     $pol->{policy},
	     '!!!Leadership',
	     $pol->{leadership},
	     '!!!Key Issues',
	     $itagtxt,
	     '!!!Relationship toward Outsiders',
	     $pol->{relationship},
	     '!!!Notes',
	     '</pre>',
	     '</div>',
	    );
	push @pol_arts, $art;
    }
    $txt .= '</pre>'."\n";
    $txt .= '</div>'."\n";

    $txt .= join("\n", @pol_arts)."\n";
    $txt .= join("\n", values %pcy_tags)."\n";
    $txt .= join("\n", values %iss_tags)."\n";

    my @alien_arts = ();
    my %body_tags  = ();
    my %lens_tags  = ();
    my %soc_tags   = ();

    # Make the Alien articles; we do the listing page and the articles simultaneously.
    $txt .= '<div title="Alien Races" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">'."\n";
    $txt .= '<pre>'."\n";
    $txt .= '|!Name|!Body Type|';
    $txt .= '!@@color:#'.$GM_COLOR.';Lenses@@|!@@color:#'.$GM_COLOR.';Structure@@|'
	unless $for_pc;
    $txt .= "h\n";

    foreach my $aln (sort { $a->{name} cmp $b->{name} } @{$s->{aliens}}) {
	my $title  = 'Alien:'.tagify($aln->{name});

	my $tags = $title;

	my $bcount = int @{$aln->{body}};
	my $btag  = '';
	my $bname = '';
	my $bdesc = '';
	my $btxt  = '';
	my $bpar  = '';
	if ($bcount > 1) {
	    $btag  = 'Body:Hybrid';
	    $bname = 'Hybrid';
	    $btxt  = 'Hybrid: '.$aln->{body}[0][0].' and '.$aln->{body}[1][0];
	    $bpar  = "''".$aln->{body}[0][0]."'': ".$aln->{body}[0][1]."&lt;br&gt;&lt;br&gt;''".$aln->{body}[1][0]."'': ".$aln->{body}[1][1];
	}
	else {
	    $btag  = 'Body:'.$aln->{body}[0][0];
	    $bname = $aln->{body}[0][0];
	    $bdesc = ': '.$aln->{body}[0][1];
	    $btxt  = $aln->{body}[0][0];
	    $bpar  = "''".$aln->{body}[0][0]."'': ".$aln->{body}[0][1];
	}

	$tags .= ' '.$btag;

	unless (exists $body_tags{$btag}) {
	    my $bt = join
		("\n",
		 '<div title="'.$btag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		 '<pre>\'\''.$bname.'\'\''.$bdesc.'</pre>',
		 '</div>',
		);
	    $body_tags{$btag} = $bt;
	}

	my $ltxt = '';
	my $lpar = '';
	foreach my $lens (@{$aln->{lens}}) {
	    my $lname = $lens->[0];
	    my $ldesc = $lens->[1];
	    my $ltag  = 'Lens:'.$lname;
	    $tags .= ' '.$ltag
		unless $for_pc;

	    if (not $ltxt) {
		$ltxt = $lname;
		$lpar = "''".$lname."'': ".$ldesc;
	    }
	    else {
		$ltxt .= ', '.$lname;
		$lpar .= "&lt;br&gt;&lt;br&gt;''".$lname."'': ".$ldesc;
	    }

	    unless (exists $lens_tags{$ltag}) {
		my $lt = join
		    ("\n",
		     '<div title="'.$ltag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		     '<pre>\'\''.$lname.'\'\''.$ldesc.'</pre>',
		     '</div>',
		    );
		$lens_tags{$ltag} = $lt;
	    }
	}

	my $spar = '';
	my %structs = ();
	foreach my $soc (@{$aln->{social}}) {
	    my $sname = $soc->[0];
	    my $sdesc = $soc->[1];
	    my $stag  = 'Structure:'.$sname;
	    $tags .= ' '.$stag
		unless $for_pc;

	    $structs{$sname} = 1;
	    unless ($spar) {
		$spar = "''".$sname."'': ".$sdesc;
	    }
	    else {
		$spar .= "&lt;br&gt;&lt;br&gt;''".$sname."'': ".$sdesc;
	    }

	    unless (exists $soc_tags{$stag}) {
		my $st = join
		    ("\n",
		     '<div title="'.$stag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		     '<pre>\'\''.$sname.'\'\': '.$sdesc.'</pre>',
		     '</div>',
		    );
		$soc_tags{$stag} = $st;
	    }
	}
	my $stxt = join(', ', keys %structs);

	# Write the listing entry
	$txt .= '|[['.$aln->{name}.'|'.$title.']]|'.$btxt.'|';
	$txt .= '@@color:#'.$GM_COLOR.';'.$ltxt.'@@|@@color:#'.$GM_COLOR.';'.$stxt.'@@|'
	    unless $for_pc;
	$txt .= "\n";

	# Write the article
	my $art   = join
	    ("\n",
	     '<div title="'.$title.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$tags.'" changecount="1">',
	     '<pre>',
	     '|!Name      |'.$aln->{name}.'|',
	     '|!Body Type |'.$btxt.'|',
	    );
	
	$art .= "\n".join
	    ("\n",
	     '|!@@color:#'.$GM_COLOR.';Lenses@@|@@color:#'.$GM_COLOR.';'.$ltxt.'@@|',
	     '|!@@color:#'.$GM_COLOR.';Structure@@|@@color:#'.$GM_COLOR.';'.$stxt.'@@|',
	    )
	    unless $for_pc;

	$art .= "\n".join
	    ("\n",
	     '!!!Distinguishing Features',
	     '* '.$aln->{vars}[0],
	     '* '.$aln->{vars}[1],
	    );

	$art .= "\n".join
	    ("\n",
	     '!!!@@color:#'.$GM_COLOR.';Body Type@@',
	     '@@color:#'.$GM_COLOR.';'.$bpar.'@@',
	     '!!!@@color:#'.$GM_COLOR.';Lenses@@',
	     '@@color:#'.$GM_COLOR.';'.$lpar.'@@',
	     '!!!@@color:#'.$GM_COLOR.';Social Structure@@',
	     '@@color:#'.$GM_COLOR.';'.$spar.'@@',
	     '!!!@@color:#'.$GM_COLOR.';Architecture@@',
	     '* @@color:#'.$GM_COLOR.';'.$aln->{arch}{towers}.'@@',
	     '* @@color:#'.$GM_COLOR.';'.$aln->{arch}{foundations}.'@@',
	     '* @@color:#'.$GM_COLOR.';'.$aln->{arch}{wall_decor}.'@@',
	     '* @@color:#'.$GM_COLOR.';'.$aln->{arch}{supports}.'@@',
	     '* @@color:#'.$GM_COLOR.';'.$aln->{arch}{arches}.'@@',
	     '* @@color:#'.$GM_COLOR.';'.$aln->{arch}{extras}.'@@',
	    )
	    unless $for_pc;

	$art .= "\n".join
	    ("\n",	
	     '!!!Notes',
	     '</pre>',
	     '</div>',
	    );
	push @alien_arts, $art;
    }
    $txt .= '</pre>'."\n";
    $txt .= '</div>'."\n";

    $txt .= join("\n", @alien_arts)."\n";
    $txt .= join("\n", values %body_tags)."\n";
    $txt .= join("\n", values %lens_tags)."\n"
	unless $for_pc;
    $txt .= join("\n", values %soc_tags)."\n"
	unless $for_pc;

    # We've written everything the players will need to know.
    return $txt
	if $for_pc;

    my @npc_arts = ();
    my %npc_sex  = ();
    my %npc_age  = ();
    my %npc_hgt  = ();

    # Make the NPC articles; we do the listing page and the articles simultaneously.
    $txt .= '<div title="NPC Listing" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">'."\n";
    $txt .= '<pre>'."\n";
    $txt .= '|!Name|!Gender|!Age|!Height|h'."\n";
    foreach my $npc (sort { $a->{sort} cmp $b->{sort} } @{$s->{npcs}}) {
	my $title = 'NPC:'.tagify($npc->{name});

	$txt .= '|[['.$npc->{name}.'|'.$title.']]|'.$npc->{gender}.'|'.$npc->{age}.'|'.$npc->{height}."|\n";

	my $stag = 'Gender:'.$npc->{gender};
	my $atag = 'Age:'.$npc->{age};
	my $htag = 'Height:'.tagify($npc->{height});

	unless (exists $npc_sex{$stag}) {
	    my $st = join
		("\n",
		 '<div title="'.$stag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		 '<pre></pre>',
		 '</div>',
	        );
	    $npc_sex{$stag} = $st;
	}
	unless (exists $npc_age{$atag}) {
	    my $at = join
		("\n",
		 '<div title="'.$atag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		 '<pre></pre>',
		 '</div>',
	        );
	    $npc_age{$atag} = $at;
	}
	unless (exists $npc_hgt{$htag}) {
	    my $ht = join
		("\n",
		 '<div title="'.$htag.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
		 '<pre></pre>',
		 '</div>',
	        );
	    $npc_hgt{$htag} = $ht;
	}

	my $tags = join(' ', $title, $stag, $atag, $htag);

	my $art   = join
	    ("\n",
	     '<div title="'.$title.'" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" tags="'.$tags.'" changecount="1">',
	     '<pre>',
	     '|!Name  |'.$npc->{name}.'|',
	     '|!Gender|'.$npc->{gender}.'|',
	     '|!Age   |'.$npc->{age}.'|',
	     '|!Height|'.$npc->{height}.'|',
	     '|!Quirk |'.$npc->{quirk}.'|',
	     '!!!Motive',
	     $npc->{motive},
	     '!!!Problem',
	     $npc->{problem},
	     '!!!Notes',
	     '</pre>',
	     '</div>',
	    );
	push @npc_arts, $art;
    }
    $txt .= '</pre>'."\n";
    $txt .= '</div>'."\n";
    $txt .= join("\n", @npc_arts)."\n";

    $txt .= join("\n", values %npc_sex)."\n";
    $txt .= join("\n", values %npc_age)."\n";
    $txt .= join("\n", values %npc_hgt)."\n";

    $txt .= join
	    ("\n",
	     '<div title="GM Info" creator="SWN Sector Generator" modifier="SWN Sector Generator" created="'.$time_stamp.'" changecount="1">',
	     '<pre>',
	     '!!General Stuff to Know',
	     'A couple of quick notes on the differences between the GM and PC versions of this file:',
	     '* The PC version does not contain //any// info on:',
             '** ~NPCs',
	     '** Heretical groups',
	     '* The PC version contains //limited// info on:',
	     '** Planets',
	     '** Corporations',
	     '** Alien Races',
	     'Otherwise, the PC version of the file is identical to the GM version. Where possible, "~GM-only" information in this document is highlighted in @@color:#'.$GM_COLOR.';this color@@. Sometimes only a header is highlighted; the paragraphs within the section can be treated as ~GM-only knowledge.',
	     '',
	     'You can alter the level of information that ~PCs have by editing the PC copy of the file before handing it out. Or, you can skip handing out the PC version entirely. I attempted to limit PC info to what I thought the characters could glean from the post-Scream version of the Internet, but the very existence of a post-Scream Internet in your sector is really up to you.',
	     '',
	     '!!Other Comments',
	     'While you could start a campaign without making any changes to the contents of this file, you should be aware of a few things:',
	     '',
	     "''1. Alien Races''",
	     'The generator always rolls up ten alien races and generates a distinct set of architectural features for each race. That presumes that every alien race in the sector is sentient and feels inclined to build structures, which may not make sense. Look at the alien races, decide which ones are sentient participants in the overall universe and adjust the articles for each race accordingly.',
	     '',
	     "''2. Corporations, Political Parties, ~NPCs''",
	     'A sizeable number of each of these has been generated for your convenience. However, they are not linked to any of the planets or to each other. If you want J. Random NPC to be the president of ACME Corp, based on planet Zanzibar, then a brief introduction to the extremely simple-to-use ~TiddlyWiki markup is in order.',
	     '',
	     "''3. Religions and Heresies''",
	     'By design, the generator very frequently produces hitherto unknown intepretations of known world religions. If you are put off by a religion that is generated by this utility, by all means, edit it in your copies of the sector wiki. Regarding heresies; the generator rolls up 1-3 heretical offshoots for every generated religion. Heresies don\'t get their own listing page because they are listed on the page of their "parent religion".',
	     '',
	     'As an aside, this article is also not included in the PC version of the file. Happy gaming!',
	     '</pre>',
	     '</div>',
	    );

    return $txt;
}

1;
