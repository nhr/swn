package SWN2PDF;
use strict;

BEGIN {
    our $VERSION   = 1.00;
    our @ISA       = qw(Exporter);
    our @EXPORT    = qw(generate_pdf);
    our @EXPORT_OK = qw();
    require Exporter;
}

use SWNUtil;

use PDF::API2;
use PDF::API2::Simple;
use Text::Reflow qw(reflow_string);

use constant { BASE_X_POS => 56,
	       LEGEND_COL => 35,
	       DIR_W_COL  => 27,
	       DIR_A_COL  => 92,
	       DIR_T_COL  => 65,
	       DIR_B_COL  => 55,
	       DIR_P_COL  => 75,
	       DIR_L_COL  => 49,
	       DIR_G_COL  => 26,
	       REC_G_ROW  => 18,
             };

my $OUT_PATH            = get_output_dir();
my $INC_PATH            = get_includes_dir();
my $FN_SECTOR_MAP       = $INC_PATH.'/swnsm.pdf';
my $FN_PLANET_DIRECTORY = $INC_PATH.'/swnpd.pdf';
my $FN_PLANET_RECORD    = $INC_PATH.'/swnpr.pdf';

sub generate_pdf {
    my %args   = @_;
    my $s      = $args{sector};
    my $time   = $args{time};
    my $cgi    = $args{cgi};
    my $for_ie = $args{for_ie};

    my $sector_name = $s->{name};
    my $token       = $s->{token};
    my $star_map    = $s->{map};
    my $npcs        = $s->{npcs};
    my $worlds      = $s->{worlds};
    my $corps       = $s->{corps};
    my $rels        = $s->{rels};
    my $pols        = $s->{pols};
    my $aliens      = $s->{aliens};

    # Make the sector map.
    print STDOUT "Writing sector map.\n";
    my $pdf = _write_sector_map( sector_name => $sector_name,
				 token       => $token,
				 star_map    => $star_map,
				 worlds      => $worlds,
	                       );

    # Cook up our cooky PDF timestamp. I always use GMT;
    # no need to look up the local diferential that way.
    my @tvals = gmtime $time;
    my $tyr   = $tvals[5] + 1900;
    my $tmon  = length $tvals[4] == 1 ? '0'.$tvals[4] : $tvals[4];
    my $tday  = length $tvals[3] == 1 ? '0'.$tvals[3] : $tvals[3];
    my $thr   = length $tvals[2] == 1 ? '0'.$tvals[2] : $tvals[2];
    my $tmin  = length $tvals[1] == 1 ? '0'.$tvals[1] : $tvals[1];
    my $tsec  = length $tvals[0] == 1 ? '0'.$tvals[0] : $tvals[0];
    my $tstr  = "D:$tyr$tmon$tday$thr$tmin$tsec+00'00'";
    
    # Set some PDF properties.
    $pdf->info( Author       => 'N. Harrison Ripps (harrison@emichron.com)',
		CreationDate => $tstr,
		ModDate      => $tstr,
		Creator      => 'Sine Nomine Publishing',
		Producer     => 'SWN Sector Generator',
		Title        => "The $sector_name Sector",
		Subject      => 'A randomly generated sector for use with Stars Without Number',
		Keywords     => 'rpg',
	      );

    # Set up the outline (TOC) for the PDF.
    my $otr  = $pdf->outlines();
    my $sec1 = $otr->outline();
    my $page = $pdf->openpage(1);
    $sec1->title('Sector Map');
    $sec1->dest($pdf->openpage(1));

    # Make the planetary directory
    print STDOUT "Writing planetary directory.\n";
    my $pd_pdf_str = _write_planetary_directory( worlds => $worlds );
    my $pd_pdf     = PDF::API2->openScalar($pd_pdf_str);
    $pdf->importpage($pd_pdf, 1, 2);
    $pd_pdf->end();
    my $sec2 = $otr->outline();
    $sec2->title('Planetary Directory');
    $sec2->dest($pdf->openpage(2));
    
    # Make the planetary records.
    print STDOUT "Writing planetary records.";
    my $rc_pdf_strs = _write_planetary_records( worlds => $worlds );
    my $tgt_page    = 3;
    my $wld_idx     = 0;
    foreach my $w (sort { $a->{name} cmp $b->{name} } @$worlds) {
	my $rc_pdf_str = $rc_pdf_strs->[$wld_idx++];
	print STDOUT ".";
	my $rc_pdf = PDF::API2->openScalar($rc_pdf_str);
	$pdf->importpage($rc_pdf, 1, $tgt_page);
	$rc_pdf->end();
	my $secN = $otr->outline();
	$secN->title($w->{name});
	$secN->dest($pdf->openpage($tgt_page++));
    }

    # Make hyperlinks from the directory to the records.
    my $grid = _pdf_directory_grid();
    my $gpos = 0;
    my $pnum = 3;
    my $page = $pdf->openpage(2);
    foreach my $world (sort { $a->{name} cmp $b->{name} } @$worlds) {
	my ($x, $y) = @{$grid->[$gpos++]};
	$x += DIR_W_COL;
	my $ant = $page->annotation;
	$ant->link($pdf->openpage($pnum));
	$ant->rect($x - 3, $y - 6, $x + 87, $y + 13);
	$world->{p_num} = $pnum++;
    }

    # Make hyperlinks from the sector map to the records.
    my $legend = _pdf_sector_legend();
    my $lpos   = 0;
    $page      = $pdf->openpage(1);
    foreach my $w ( sort { $a->{cell_pos} cmp $b->{cell_pos} } @$worlds ) {
	my ($x, $y) = @{$legend->[$lpos++]};
	$x += LEGEND_COL;
	my $ant = $page->annotation;
	$ant->link($pdf->openpage($w->{p_num}));
	$ant->rect($x - 2, $y - 4, $x + 112, $y + 11);
    }

    print STDOUT "\nSaving sector to file.\n";
    $pdf->saveas($OUT_PATH.'/SWN Sector Map - '.uc($sector_name).'.pdf');
    print STDOUT "File written; exiting.\n";

    return 1;
}

sub _pdf_sector_points {
    # No args
    
    my $x_pos  = BASE_X_POS;
    my $y_pos  = 572;
    my $r_diff = 54;
    my $c_diff = 45;
    my $r_off  = 28;
    
    my %POINTS = ();
    for (my $row = 0; $row < 10; $row++) {
	for (my $col = 0; $col < 8; $col++) {
	    my $cell       = cell_id( col => $col, row => $row );
	    my @pos        = ($x_pos, $y_pos);
	    my $c_diff_mod = 0;

	    if ($col % 2) {
		$pos[1]    -= $r_off;
		$c_diff_mod = 1;
	    }

	    $POINTS{$cell} = \@pos;

	    $x_pos += $c_diff + $c_diff_mod;
	}
	$x_pos  = BASE_X_POS;
	$y_pos -= $r_diff;
    }
    return \%POINTS;
}

sub _pdf_sector_legend {
    # No args

    my $x_pos  = 416;
    my $y_pos  = 577;
    my $r_diff = 15;

    my @LEGEND = ();
    for (my $i = 1; $i < 37; $i++) {
	push @LEGEND, [$x_pos, $y_pos];
	$y_pos -= $r_diff;
	$y_pos -= 1
	    if $i % 6 == 0 or $i % 11 == 0;
    }
    return \@LEGEND;
}

sub _pdf_directory_grid {
    # No args

    my $x_pos  = 51;
    my $y_pos  = 727;
    my $r_diff = 19;

    my @GRID = ();
    for (my $i = 1; $i < 37; $i++) {
	push @GRID, [$x_pos,$y_pos];
	$y_pos -= $r_diff;
	$y_pos -= 1
	    if $i % 4 == 0 or $i % 3 == 0;
    }
    return \@GRID;
}

sub _write_sector_map {
    my %args  = @_;
    my $sector_name = $args{sector_name};
    my $token       = $args{token};
    my $star_map    = $args{star_map};
    my $worlds      = $args{worlds};

    my $points = _pdf_sector_points();
    my $legend = _pdf_sector_legend();

    my $pdf = PDF::API2::Simple->open( open_file => $FN_SECTOR_MAP );
    $pdf->add_font('Helvetica');
    $pdf->add_font('Courier');

    # Put the sector name on.
    my $diff = $pdf->text(uc($sector_name), 'x' => 210, 'y' => 740, 'font' => 'Helvetica', 'fontsize' => 24, align => 'left' );
    $pdf->text($token, 'x' => (210 + $diff + 10), 'y' => 740, 'font' => 'Courier', 'fontsize' => 8, align => 'left' );

    # Put the stars on the hex grid.
    foreach my $cell (keys %$star_map) {
	my $star_name = $star_map->{$cell}{name};
	my ($x,$y)    = @{$points->{$cell}};
	$pdf->text('.', 'x' => $x, 'y' => $y, 'font' => 'Courier', 'fontsize' => 60, align => 'center' );
	$pdf->text(uc($star_name), 'x' => $x, 'y' => ($y + 15), 'font' => 'Courier', 'fontsize' => 7, align => 'center' );
    }

    # Put the planets on the legend.
    my $leg_idx = 0;
    foreach my $w ( sort { $a->{cell_pos} cmp $b->{cell_pos} } @$worlds ) {
	my $leg_x = $legend->[$leg_idx][0];
	my $leg_y = $legend->[$leg_idx][1];

	my $write_cell = $w->{sys_pos} == 1 ? 1 : 0;

	$pdf->text( $w->{cell},
		    'x'        => $leg_x,
		    'y'        => $leg_y,
		    'font'     => 'Courier',
		    'fontsize' => 12,
		    'align'    => 'left',
	          )
	    if $write_cell;

	$leg_x += LEGEND_COL;
	
	$pdf->text( $w->{name},
		    'x'        => $leg_x,
		    'y'        => $leg_y,
		    'font'     => 'Courier',
		    'fontsize' => 8,
		    'align'    => 'left',
	          );

	$leg_idx++;
    }

    # Hand back the PDF::API2 object; we'll be building up the rest of the doc with it.
    return $pdf->pdf;
}

sub _write_planetary_directory {
    my %args   = @_;
    my $worlds = $args{worlds};

    my $dgrid  = _pdf_directory_grid();
    
    my $pdf = PDF::API2::Simple->open( open_file => $FN_PLANET_DIRECTORY );
    $pdf->add_font('Courier');
    $pdf->add_font('Helvetica');

    my $dir_pos = 0;
    foreach my $w (sort { $a->{name} cmp $b->{name} } @$worlds) {
	my $x = $dgrid->[$dir_pos][0];
	my $y = $dgrid->[$dir_pos][1];
	    
	# Hex ID
	$pdf->text( $w->{cell},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Courier',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );
	    
	$x += DIR_W_COL;
	    
	$pdf->text( $w->{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );
	
	$x += DIR_A_COL;
	    
	$pdf->text( $w->{atmosphere}{short},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Courier',
		    'fontsize' => 7,
			'align'    => 'left',
		  );
	    
	$x += DIR_T_COL;
	    
	$pdf->text( $w->{temperature}{short},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Courier',
		    'fontsize' => 7,
		    'align'    => 'left',
	          );
	    
	$x += DIR_B_COL;
	    
	$pdf->text( $w->{biosphere}{short},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Courier',
		    'fontsize' => 7,
		    'align'    => 'left',
		  );
	    
	$x += DIR_P_COL;
	    
	$pdf->text( $w->{population}{short},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Courier',
		    'fontsize' => 7,
		    'align'    => 'left',
		  );
	    
	$x += DIR_L_COL;
	    
	$pdf->text( $w->{tech_level}{short},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Courier',
		    'fontsize' => 7,
		    'align'    => 'left',
	          );
	    
	$x += DIR_G_COL;
	    
	my $tags = $w->{tags}[0]{short}.'; '.
	    $w->{tags}[1]{short};
	    
	$pdf->text( $tags,
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Courier',
		    'fontsize' => 7,
		    'align'    => 'left',
		  );

	$dir_pos++;
    }

    # Hand back a scalar representing the compiled PDF.
    # This saves us writing it to a file and re-opening
    # it.
    return $pdf->stringify;
}

sub _write_planetary_records {
    my %args   = @_;
    my $worlds = $args{worlds};

    my @files = ();

  PLANET:
    foreach my $w (sort { $a->{name} cmp $b->{name} } @$worlds) {
	my $pdf = PDF::API2::Simple->open( open_file => $FN_PLANET_RECORD );
	$pdf->add_font('Courier');
	$pdf->add_font('Helvetica');

	my $x = 119;
	my $y = 740;

	# Name
	$pdf->text( $w->{name}.' ('.$w->{sys_name}.')',
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 12,
		    'align'    => 'left',
	          );

	$y = 706;

	# Atmoshpere
	$pdf->text( $w->{atmosphere}{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );
	
	$y -= REC_G_ROW;
	
	# Temperature
	$pdf->text( $w->{temperature}{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );

	$y -= REC_G_ROW;
	
	# Biosphere
	$pdf->text( $w->{biosphere}{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );

	$y -= REC_G_ROW;

	# Population
	$pdf->text( $w->{population}{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );
	
	$y -= REC_G_ROW;

	# Tech Level
	$pdf->text( $w->{tech_level}{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );

	$y -= REC_G_ROW;

	# Tag 1
	$pdf->text( $w->{tags}[0]{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );

	$y -= 16;
	
	# Tag 2
	$pdf->text( $w->{tags}[1]{name},
		    'x'        => $x,
		    'y'        => $y,
		    'font'     => 'Helvetica',
		    'fontsize' => 9,
		    'align'    => 'left',
	          );

	my $fn_this_pd = 'SWN_-_Planet_Record.pdf';
	
	# Enemies
	$x = 30;
	$y = 550;
	my $enemies = $w->{tags}[0]{enemies}.'; '.$w->{tags}[1]{enemies};
	_write_paragraph( 'pdf' => $pdf,
			 'txt' => $enemies,
			 'x'   => $x,
			 'y'   => $y,
                       );
	
	# Friends
	$y = 442;
	my $friends = $w->{tags}[0]{friends}.'; '.$w->{tags}[1]{friends};
	_write_paragraph( 'pdf' => $pdf,
			 'txt' => $friends,
			 'x'   => $x,
			 'y'   => $y,
                       );
	
	# Complications
	$y = 332;
	my $comps = $w->{tags}[0]{complications}.'; '.
	    $w->{tags}[1]{complications};
	_write_paragraph( 'pdf' => $pdf,
			 'txt' => $comps,
			 'x'   => $x,
			 'y'   => $y,
                       );
	
	# Places
	$y = 223;
	my $places = $w->{tags}[0]{places}.'; '.
	    $w->{tags}[1]{places};
	_write_paragraph( 'pdf' => $pdf,
			 'txt' => $places,
			 'x'   => $x,
			 'y'   => $y,
                       );
	
	# Things
	$y = 114;
	my $things = $w->{tags}[0]{things}.'; '.
	    $w->{tags}[1]{things};
	_write_paragraph( 'pdf' => $pdf,
			 'txt' => $things,
			 'x'   => $x,
			 'y'   => $y,
                       );
	
	# Push each PDF file in scalar form onto the stack.
	push @files, $pdf->stringify();
    }

    return \@files;
}

sub _write_paragraph {
    my %args = @_;
    my $pdf  = $args{pdf};
    my $txt  = $args{txt};
    my $x    = $args{x};
    my $y    = $args{y};

    my $rf = reflow_string($txt, maximum => 60, optimum => 60);
	
    my @rf_lines = split "\n", $rf;

     my $lh = int @rf_lines > 8 ? 8 : 10;
	
    foreach my $line (@rf_lines) {
	$pdf->text( $line,
		    'x'          => $x,
		    'y'          => $y,
		    'font'       => 'Courier',
		    'fontsize'   => 7,
		    'align'      => 'left',
	          );
	$y -= $lh;
    }
}

1;
