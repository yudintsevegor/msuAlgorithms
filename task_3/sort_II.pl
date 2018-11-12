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

my $points = 1;

#my @data = (44, 55, 12, 42, 94 ,18 , 06, 67); 
#my @data = (67, 55, 12, 44, 42); 
#@data = reverse @data; 
#my @data = (06, 12, 18, 42, 43, 44, 56 ,66, 67, 68, 69, 70, 72, 75, 222, 555, 678, 888, 999);
#@data = reverse @data; 
my @data = map{ int(rand(10000)) } (1..2000);
#say "INIT ARRAY";
#say join(" ",@data); 
my $filename;
my @swapPointsSel;
my @comparePointsSel;
my @swapPointsQS;
my @comparePointsQS;
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
		#say "Order";
		#say join(" ", @dataToOrder);
		#say "UnOrder";
		#say join(" ", @dataToUnOrder);
	
		my $objectOrder = SORT->new(
			data	=>	[@dataToOrder],
		);

		my $objectUnorder = SORT->new(
			data	=>	[@dataToUnOrder],
		);
		my ($it_swapSelOrder, $it_compareSelOrder, @answer_selOrder) = $objectOrder->selection;
		#say "SWAP Order: ".$it_swapSelOrder;
		#say join(" ", @answer_selOrder);
		#say "COMPARE: ".$it_compareSel;

		my ($it_swapQSOrder, $it_compareQSOrder, @answer_qsOrder) = $objectOrder->quicksort;
		#say "Result ";
		#say join(" ", @answer_qsOrder);
		say "SWAP Order: ".$it_swapQSOrder;
		#say "COMPARE: ".$it_compareQS;
		
		my ($it_swapSelUnorder, $it_compareSelUnorder, @answer_selUnorder) = $objectUnorder->selection;
		#say "SWAP Unorder: ".$it_swapSelUnorder;
		#say join(" ", @answer_selUnorder);
		#say "COMPARE: ".$it_compareSel;

		my ($it_swapQSUnorder, $it_compareQSUnorder, @answer_qsUnorder) = $objectUnorder->quicksort;
		#say join(" ", @answer_qsUnorder);
		say "SWAP unorder: ".$it_swapQSUnorder;
		#say "COMPARE: ".$it_compareQS;

		push @order, $runs;
		push @swapPointsSel, $it_swapSelOrder;
		push @swapPointsQS, $it_swapQSOrder;
		push @comparePointsSel, $it_compareSelOrder;
		push @comparePointsQS, $it_compareQSOrder;

		if ($runs != 0) {
			unshift @order, 0-$runs;
			unshift @swapPointsSel, $it_swapSelUnorder;
			unshift @swapPointsQS, $it_swapQSUnorder;
			unshift @comparePointsSel, $it_compareSelUnorder;
			unshift @comparePointsQS, $it_compareQSUnorder;
		}
		$runs++;
	}
	#say "Order";
	#p @order;
	
	#say "sw Sel";
	#p @swapPointsSel;
	#say "sw QS";
	#p @swapPointsQS;
	#say "com Sel";
	#p @comparePointsSel;
	#say "com QS";
	#p @comparePointsQS;

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
	#say "LENTH:";
	#p @lenth;
	#say "SWAP SEL:";
	#p @swapPointsSel;
	#say "SWAP QS:";
	#p @swapPointsQS;
	#say "Compare SEL:";
	#p @comparePointsSel;
	#say "Compare QS:";
	#p @comparePointsQS;

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

