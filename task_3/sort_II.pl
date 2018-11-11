#!/usr/bin/env perl

use 5.016;
use warnings;
use DDP;
use Getopt::Long;
Getopt::Long::Configure ('bundling');
use FindBin;
use lib "$FindBin::Bin/../lib", glob("$FindBin::Bin/../*/lib*"),;
use SORT;
use GRAPH;

my $fm = 0;
my $fo = 0;

GetOptions(
	"fm|fixed_massive" 	=> \$fm,
	"fo|fixed_order"	=> \$fo,
);

my $points = 5;

#my @array = (44, 55, 12, 42, 94 ,18 , 06, 67); 
#my @array = (06, 12, 18, 42, 44, 55, 67, 94);
#@array = reverse @array; 
my @data = map{ int(rand(100)) } (1..2048);

my $filename;
my @swapPointsSel;
my @comparePointsSel;
my @swapPointsQS;
my @comparePointsQS;
my @lenth;
my @order;

if ( $fm == 1) {
	
} elsif ($fo == 1) {	
	$filename = "fix_order";
	my $counter = 0;
	while ( $counter <= $points ) {
		my @array = @data[0..(scalar @data - 1)/2**$counter]; 	
		my $object = SORT->new(
			data	=>	[@array],
		);

		my ($it_swapSel, $it_compareSel, @answer_sel) = $object->selection;
		#p @answer_sel;
		#say "SWAP: ".$it_swapSel;
		#say "COMPARE: ".$it_compareSel;

		my ($it_swapQS, $it_compareQS, @answer_qs) = $object->quicksort;
		#p @answer_qs;
		#say "SWAP: ".$it_swapQS;
		#say "COMPARE: ".$it_compareQS;
		$counter++;
		unshift @lenth, scalar @array;
		unshift @swapPointsSel, $it_swapSel;
		unshift @swapPointsQS, $it_swapQS;
		unshift @comparePointsSel, $it_compareSel;
		unshift @comparePointsQS, $it_compareQS;

	}
	say "LENTH:";
	p @lenth;
	say "SWAP SEL:";
	p @swapPointsSel;
	say "SWAP QS:";
	p @swapPointsQS;
	say "Compare SEL:";
	p @comparePointsSel;
	say "Compare QS:";
	p @comparePointsQS;

} 

my $object = GRAPH->new(
		compareSel	=>	[@comparePointsSel],
		compareQS	=>	[@comparePointsQS],
		swapSel		=>	[@swapPointsSel],
		swapQS		=>	[@swapPointsQS],
		lenth		=>	[@lenth],
		order		=>	[@order],
		sig_fo		=>	$fo,	
		sig_fm		=>	$fm,
		task		=>	"task_3",
		name		=>	$filename,
		);
$object->plot;	


