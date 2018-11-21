#!/usr/bin/env perl

use 5.016;
use warnings;
use DDP;
use Getopt::Long;
Getopt::Long::Configure ('bundling');
use FindBin;
use lib "$FindBin::Bin/../lib", glob("$FindBin::Bin/../*/lib*"),;
use SearchingMethods;
use GRAPH;

my $ft = 0;
my $fs = 0;

GetOptions(
	"ft|fixed_text" 	=> \$ft,
	"fs|fixed_sample"	=> \$fs,
);

my $points = 10;	

my @IT_BF;
my @IT_BM;
my @arr_M;
my @arr_N;

my @SAMPLES = ("Mons The Best and Igor too", "Faculty Of Physics", "mdayandexgoogle", "Mons The Best", "mdakeklol", "keklol", "mda" );
my $size = scalar @SAMPLES;
my $filename;
	
if ( $fs == 1) {
	$filename = "fix_string";
	my $sample = "Mons The Best";
	my @sample = split //, $sample;
	

	my $filename = "text_eng.txt";
	open( my $fd, "<", $filename) or die $!;
	my  @text_std;
	while ( my $row = <$fd> ){
		my @arr = split //, $row;
		push @text_std, @arr;
	}

	my $M = scalar @sample;
	my $i = 2 ** $points;
	
	while ( $points > 0) {	
		
		my @text = @text_std[scalar @text_std/$i..scalar @text_std - 1]; 
		my $N = scalar @text;
		unshift @arr_N, $N;
		
		my $object = SM->new(
			text	=>	[@text],
			sample	=>	[@sample],
			N	=>	$N,
			M	=>	$M,
		);
	
		my @answer_bf = $object->brute_force;
			
		if ( $answer_bf[1] == -1 ) {
			say "NO MATCH BY Brute-Force";
		} else {
			unshift @IT_BF, $answer_bf[0]; 
		}
			
		my @answer_bm = $object->boyer_moore;	
				
		if ( $answer_bm[1] == -1 ) {
			say "NO MATCH BY Boyer-Moore";
		} else {
			unshift @IT_BM, $answer_bm[0]; 
		}
	
		$i = $i / 2;
		--$points;
	}
} elsif ( $ft == 1) {

	$filename = "fix_text";
	while ( $size > 0) {	

		my $sample = $SAMPLES[$size - 1];
		my @sample = split //, $sample;


		my $filename = "text_eng.txt";
		open( my $fd, "<", $filename) or die $!;
		my @text;

	
		while ( my $row = <$fd> ){
			my @arr = split //, $row;
			push @text, @arr;
		}
		my $len = scalar @sample;
		my $N = scalar @text;
		push @arr_M, $len;
	
		my $object = SM->new(
				text	=>	[@text],
				sample	=>	[@sample],
				N	=>	$N,
				M	=>	$len,
				);

		my @answer_bf = $object->brute_force;
		
		if ( $answer_bf[1] == -1 ) {
			say "NO MATCH BY Brute-Force";
		} else {
			push @IT_BF, $answer_bf[0]; 
		}
	
		my @answer_bm = $object->boyer_moore;	
		
		if ( $answer_bm[1] == -1 ) {
			say "NO MATCH BY Boyer-Moore";
		} else {
			push @IT_BM, $answer_bm[0];
		}

		--$size;
	}

}
	

my $object = GRAPH->new(
		bf	=>	[@IT_BF],
		bm	=>	[@IT_BM],
		N	=>	[@arr_N],
		M	=>	[@arr_M],
		sig_ft	=>	$ft,	
		sig_fs	=>	$fs,
		task	=>	"task_1",
		name	=>	$filename,
		);

$object->plot;	

