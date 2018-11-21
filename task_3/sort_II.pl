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
use Time::HiRes qw(gettimeofday tv_interval);

my $fm = 0;
my $fo = 0;

GetOptions(
	"fm|fixed_massive" 	=> \$fm,
	"fo|fixed_order"	=> \$fo,
);

my $points = 100;
my @data;


if ( $fm == 1) {
	@data = map{ int(rand(10*100)) } (1..500);
} elsif ( $fo == 1) {
	@data = map{ int(rand(10*100)) } (1..4000);
}

my $filename;
my @swapPointsSel;
my @comparePointsSel;
my @swapPointsQS;
my @comparePointsQS;
my @lenth;
my @order;

my $start_time;
my $end_time;
my $elapsed;
my @time;

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
		my ($it_swapSelOrder, $it_compareSelOrder, @answer_selOrder) = $objectOrder->selection;
		my ($it_swapQSOrder, $it_compareQSOrder, @answer_qsOrder) = $objectOrder->quicksort;
		my ($it_swapSelUnorder, $it_compareSelUnorder, @answer_selUnorder) = $objectUnorder->selection;
		my ($it_swapQSUnorder, $it_compareQSUnorder, @answer_qsUnorder) = $objectUnorder->quicksort;
		
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
	my @oper;
	foreach my $i (0..scalar @swapPointsQS - 1){
		push @oper, $swapPointsQS[$i] + $comparePointsQS[$i];
	}
	
	open(my $fh, ">", "./points/Operations.txt") or die $!;
	foreach my $i(0..scalar @oper - 1){
		say $fh $swapPointsQS[$i] + $comparePointsQS[$i];
	}
	
} elsif ($fo == 1) {	
	$filename = "fix_order";
	my $counter = 0;
	while ( $counter <= $points ) {
		my @array = @data[0..scalar @data - 1 - $points*$counter];
		my $object = SORT->new(
			data	=>	[@array],
		);

		my ($it_swapSel, $it_compareSel, @answer_sel) = $object->selection;
		my ($it_swapQS, $it_compareQS, @answer_qs) = $object->quicksort;
		
		unshift @lenth, scalar @array;
		unshift @swapPointsSel, $it_swapSel;
		unshift @swapPointsQS, $it_swapQS;
		unshift @comparePointsSel, $it_compareSel;
		unshift @comparePointsQS, $it_compareQS;
		
		$counter++;

	}
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

