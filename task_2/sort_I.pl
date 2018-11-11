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

my $filename;
my $points = 10;
#my @array = (44, 55, 12, 42, 94 ,18 , 06, 67); 
#my @array = (06, 12, 18, 42, 44, 55, 67, 94);
#@array = reverse @array; 
my @data = map{ int(rand(100)) } (1..4048);

my @swapPointsIns;
my @comparePointsIns;
my @swapPointsHS;
my @comparePointsHS;
my @lenth;
my @order;


if ( $fm == 1) {
	
	my @array = @data;
	my $object = SORT->new(
		data	=>	[@array],
	);

	my ($it_swapIns, $it_compareIns, @answer_ins) = $object->insertion;
	p @answer_ins;

	my ($it_swapHs, $it_compareHs, @answer_hs) = $object->heapsort;
	p @answer_hs;
	
	
} elsif ($fo == 1) {	
	my $counter = 0;
	$filename ="fix_order";
	while ($counter <= $points ) {
		my @array = @data[0..(scalar @data - 1)/2**$counter];
		#p @array;
		my $object = SORT->new(
				data	=>	[@array],
		);

		my ($it_swapIns, $it_compareIns, @answer_ins) = $object->insertion;
		#say "INS";
		#p @answer_ins;
		#say "SWAP: ".$it_swapIns;
		#say "COMPARE: ".$it_compareIns;

		my ($it_swapHS, $it_compareHS, @answer_hs) = $object->heapsort;
		#p @answer_hs;
		#say "SWAP: ".$it_swapHs;
		#say "COMPARE: ".$it_compareHs;
		
		unshift @lenth, scalar @array;
		unshift @swapPointsIns, $it_swapIns;
		unshift @swapPointsHS, $it_swapHS;
		unshift @comparePointsIns, $it_compareIns;
		unshift @comparePointsHS, $it_compareHS;

		$counter++;
	}
	say "LENTH:";
	p @lenth;
	say "SWAP INS:";
	p @swapPointsIns;
	say "SWAP HS:";
	p @swapPointsHS;
	say "Compare Ins:";
	p @comparePointsIns;
	say "Compare HS:";
	p @comparePointsHS;

} 

my $object = GRAPH->new(
		compareIns	=>	[@comparePointsIns],
		compareHS	=>	[@comparePointsHS],
		swapIns		=>	[@swapPointsIns],
		swapHS		=>	[@swapPointsHS],
		lenth		=>	[@lenth],
		order		=>	[@order],
		sig_fo		=>	$fo,	
		sig_fm		=>	$fm,
		task		=>	"task_2",
		name		=>	$filename,
		);
$object->plot;	

