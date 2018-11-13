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
my $points = 100;
#my @data = (44, 55, 12, 42, 94 ,18 , 06, 67); 
#my @data = (06, 12, 18, 42, 44, 55, 67, 94);
#@data = reverse @data; 
my @data = map{ int(rand(100000)) } (1..4000);

my @swapPointsIns;
my @comparePointsIns;
my @swapPointsHS;
my @comparePointsHS;
my @lenth;
my @order;


if ( $fm == 1) {
	$filename = "fix_massive";
	my $runs = 0;
	my $x;
	my $len = scalar @data;
	my @dataToOrder = @data;
	my @dataToUnOrder = @data;

	while ( $runs < $len ){
		if ( $runs != 0 ) {
			for ( my $i = 0; $i < 1; $i++){
				for (my $j = $len - 1; $j > $i; $j-- ){
					if ( ($dataToOrder[$j-1] > $dataToOrder[$j])){
						$x = $dataToOrder[$j - 1];
						$dataToOrder[$j - 1] = $dataToOrder[$j];
						$dataToOrder[$j] = $x;
					}
				}
			}
			for ( my $i = 0; $i < 1; $i++){
			for (my $j = $len - 1; $j > $i; $j-- ){
				if ( ($dataToUnOrder[$j-1] < $dataToUnOrder[$j]) ){
					$x = $dataToUnOrder[$j - 1];
					$dataToUnOrder[$j - 1] = $dataToUnOrder[$j];
					$dataToUnOrder[$j] = $x;
				}

			}
		}
		}
		#say join(" ", @dataToOrder);
		#say join(" ", @dataToUnOrder);
		my $objectOrder = SORT->new(
			data	=>	[@dataToOrder],
		);

		my $objectUnorder = SORT->new(
			data	=>	[@dataToUnOrder],
		);
		my ($it_swapInsOrder, $it_compareInsOrder, @answer_InsOrder) = $objectOrder->insertion;
		#p @answer_;
		#say "SWAP: ".$it_swapInsOrder;
		#say "COMPARE: ".$it_compareSel;

		my ($it_swapHSOrder, $it_compareHSOrder, @answer_hsOrder) = $objectOrder->heapsort;
		#p @answer_hsOrder;
		#say "SWAP: ".$it_swapHSOrder;
		#say "COMPARE: ".$it_compareHSOrder;
		
		my ($it_swapInsUnorder, $it_compareInsUnorder, @answer_insUnorder) = $objectUnorder->insertion;
		#p @answer_sel;
		#say "SWAP: ".$it_swapInsUnorder;
		#say "COMPARE: ".$it_compareSel;

		my ($it_swapHSUnorder, $it_compareHSUnorder, @answer_hsUnorder) = $objectUnorder->heapsort;
		#p @answer_qs;
		#say "SWAP: ".$it_swapHSUnorder;
		#say "COMPARE: ".$it_compareHSUnorder;

		push @order, $runs;
		push @swapPointsIns, $it_swapInsOrder;
		push @swapPointsHS, $it_swapHSOrder;
		push @comparePointsIns, $it_compareInsOrder;
		push @comparePointsHS, $it_compareHSOrder;

		if ($runs != 0) {
			unshift @order, 0-$runs;
			unshift @swapPointsIns, $it_swapInsUnorder;
			unshift @swapPointsHS, $it_swapHSUnorder;
			unshift @comparePointsIns, $it_compareInsUnorder;
			unshift @comparePointsHS, $it_compareHSUnorder;
		}
		$runs++;
	}
	#say "Order";
	#p @order;
	
	#say "sw Ins";
	#p @swapPointsIns;
	#say "sw HS";
	#p @swapPointsHS;
	#say "com ins";
	#p @comparePointsIns;
	#say "com HS";
	#p @comparePointsHS;
	
} elsif ($fo == 1) {	
	my $counter = 0;
	$filename ="fix_order";
	while ($counter <= $points ) {
		#my @array = @data[0..(scalar @data - 1)/2**$counter];
		my @array = @data[0..scalar @data - 1 - $points*$counter];
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
		#say "SWAP: ".$it_swapHS;
		#say "COMPARE: ".$it_compareHS;
		
		unshift @lenth, scalar @array;
		unshift @swapPointsIns, $it_swapIns;
		unshift @swapPointsHS, $it_swapHS;
		unshift @comparePointsIns, $it_compareIns;
		unshift @comparePointsHS, $it_compareHS;

		$counter++;
	}
	#say "LENTH:";
	#p @lenth;
	#say "SWAP INS:";
	#p @swapPointsIns;
	#say "SWAP HS:";
	#p @swapPointsHS;
	#say "Compare Ins:";
	#p @comparePointsIns;
	#say "Compare HS:";
	#p @comparePointsHS;

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

