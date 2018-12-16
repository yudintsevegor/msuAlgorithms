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
my @data;

if ( $fm == 1) {
	@data = map{ int(rand(10*100)) } (1..500);
} elsif ( $fo == 1) {
	@data = map{ int(rand(10*100)) } (1..4000);
}

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
		my $objectOrder = SORT->new(
			data	=>	[@dataToOrder],
		);

		my $objectUnorder = SORT->new(
			data	=>	[@dataToUnOrder],
		);
		my ($it_swapInsOrder, $it_compareInsOrder, @answer_InsOrder) = $objectOrder->insertion;
		my ($it_swapHSOrder, $it_compareHSOrder, @answer_hsOrder) = $objectOrder->heapsort;
		my ($it_swapInsUnorder, $it_compareInsUnorder, @answer_insUnorder) = $objectUnorder->insertion;
		my ($it_swapHSUnorder, $it_compareHSUnorder, @answer_hsUnorder) = $objectUnorder->heapsort;

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
	
} elsif ($fo == 1) {	
	my $counter = 0;
	$filename ="fix_order";
	while ($counter <= $points ) {
		my @array = @data[0..scalar @data - 1 - $points*$counter];
		my $object = SORT->new(
				data	=>	[@array],
		);

		my ($it_swapIns, $it_compareIns, @answer_ins) = $object->insertion;
		my ($it_swapHS, $it_compareHS, @answer_hs) = $object->heapsort;
		
		unshift @lenth, scalar @array;
		unshift @swapPointsIns, $it_swapIns;
		unshift @swapPointsHS, $it_swapHS;
		unshift @comparePointsIns, $it_compareIns;
		unshift @comparePointsHS, $it_compareHS;

		$counter++;
	}
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

