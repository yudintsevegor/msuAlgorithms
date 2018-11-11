package SORT;

use 5.016;
use DDP;

sub new {
	my $class = shift;
	my %args = @_;
	my $self = bless \%args, $class;
	return $self;
}

sub selection {
	my ($self) = @_;
	my @array = @{ $self->{ data } };
	my $len = scalar @array;
	my $i = 0;
	my $it_swap = 0;
	my $it_compare = 0;
	
	while ($i <= $len - 2) {
		my $k = $i;
		my $x = $array[$i];
		my $j = $i + 1;
		while ($j <= $len - 1) {
			if ( $array[$j] < $x) {
				$k = $j;
				$x = $array[$k];
				++$it_swap;
			}
			++$it_compare;
			++$j;
		}
		$array[$k] = $array[$i];
		++$it_swap;
		$array[$i] = $x;
		++$it_swap;
		++$i; 
	}
	return $it_swap, $it_compare, @array;
}

sub quicksort {
	my ($self) = @_;
	my @array = @{ $self->{ data } };
	my $len = scalar @array;
	
	my $it_swap = 0;
	my $it_compare = 0;

	sub sort_alg {
		my $L = shift @_;
		my $R = shift @_;
		$it_compare = shift @_;
		$it_swap = shift @_;
		my @array = @_;

		my $i = $L;
		my $j = $R;
		my $w;

		my $x = $array[($L + $R)/2];
		while ($i < $j) {
			while ($array[$i] < $x) {++$i; ++$it_compare;};
			while ($x < $array[$j]) {--$j; ++$it_compare;};
			if ($i <= $j) {
				$w = $array[$i];
				$array[$i] = $array[$j];
				$array[$j] = $w;
				
				++$it_swap;
				++$i;
				--$j;
			}
		}
		if ($L < $j) { 
			unshift @array, $it_swap;
			unshift @array, $it_compare;
			unshift @array, $j;
			unshift @array, $L;
			
			@array = sort_alg(@array)
		};
	
		if ($i < $R) { 
			unshift @array, $it_swap;
			unshift @array, $it_compare;
			unshift @array, $R;
			unshift @array, $i;
			
			@array = sort_alg(@array);
		};
		unshift @array, $it_swap;
		unshift @array, $it_compare;

		return @array;
	};

	unshift @array, $it_swap;
	unshift @array, $it_compare;
	unshift @array, ($len - 1);
	unshift @array, 0;

	my (@result) = sort_alg(@array);
	$it_compare = shift @result;
	$it_swap = shift @result;
	
	return $it_swap, $it_compare, @result;

}

sub insertion {
	my ($self) = @_;
	my @array = @{ $self->{ data } };
	my $len = scalar @array;
	my $i = 1;
	my $j;
	my $x;
	my $it_swap = 0;
	my $it_compare = 0;

	while( $i <= $len - 1){
		$j = $i;
		$x = $array[$i];
		LOOP:
		while ( $j > 0 ) {
			++$it_compare;
			if ($x <= $array[$j - 1]) {
				$array[$j] = $array[$j - 1];
				++$it_swap;
				--$j;
			} else {
				last LOOP;		
			}
		}
		$array[$j] = $x;
		$i++;
	}
	return $it_swap, $it_compare, @array;
}

sub heapsort {
	my ($self) = @_;
	my @array = @{ $self->{ data }};
	my $len =  scalar @array;
	my $it = 0;
	my $L = $len / 2;
	my $R = $len - 1;
	my @data;
	my $x;
	my $it_swap = 0;
	my $it_compare = 0;

	while ( $L > 0){
		--$L;
		
		push @data, $L;
		push @data, $R;
		push @data, $it_swap;
		push @data, $it_compare;
		($it_swap, $it_compare) = sift(\@data, \@array);
		
	}
	
	while ( $R > 0) {
		$x = $array[0];
		$array[0] = $array[$R];
		$array[$R] = $x;
		$R--;
		$it_swap++;
	
		push @data, $L;
		push @data, $R;
		push @data, $it_swap;
		push @data, $it_compare;
		($it_swap, $it_compare, @array) = sift(\@data, \@array);
	}

	sub sift{
		my ($ItLR, $arrayToSift) = @_;
		my $it_compare = pop @$ItLR;
		my $it_swap = pop @$ItLR;
		my $L = shift @$ItLR;
		my $R = shift @$ItLR;
		my $i = $L;
		my $j = 2*$i + 1;
		my $x = @$arrayToSift[$i];
		
		if ( ( $j < $R ) && ( @$arrayToSift[$j] < @$arrayToSift[$j + 1] ) ){
			$j++;
		}
		$it_compare++;
		while ( ($j <= $R) && ($x < @$arrayToSift[$j]) ) {
			$it_compare++;
			@$arrayToSift[$i] = @$arrayToSift[$j];
			$i = $j;
			$j = 2*$j + 1;
			$it_swap++;

			$it_compare++;
			if ( ($j < $R ) && ( @$arrayToSift[$j] < @$arrayToSift[$j + 1]) ){
				$j++;
			}
		}
		@$arrayToSift[$i] = $x;
		return $it_swap, $it_compare, @$arrayToSift;
	}	
	my @result = @array;	
	return $it_swap, $it_compare, @result;
}

1;

