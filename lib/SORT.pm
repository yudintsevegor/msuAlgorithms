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
			$it_compare++;
			if ( $array[$j] < $x) {
				$k = $j;
				$x = $array[$k];
				++$it_swap;
			}
			++$j;
		}
		$array[$k] = $array[$i];
		$array[$i] = $x;
		++$it_swap;
		++$i; 
	}
	#say "END: ";
	#say join(" ", @array);
	#say $it_swap;	
	return $it_swap, $it_compare, @array;
}

sub quicksort {
	my ($self) = @_;
	my @array = @{ $self->{ data } };
	my $len = scalar @array;
	
	my $it_swap = 0;
	my $it_compare = 0;
	my @data;
	my @result;

	sub sort_alg {
		my ($data, $array) = @_;
		my $L = pop @$data;
		my $R = pop @$data;
		my $it_compare = pop @$data;
		my $it_swap = pop @$data;

		#my $L = pop @_;
		#my $R = pop @_;
		#my $it_compare = pop @_;
		#my $it_swap = pop @_;
		#my @array = @_;

		my $i = $L;
		my $j = $R;
		my $w;

		my $x = @$array[($L + $R)/2];
		while ($i <= $j) {
			while (@$array[$i] < $x) {++$i; ++$it_compare;};
			while ($x < @$array[$j]) {--$j; ++$it_compare;};
			if ($i <= $j) {
				$w = @$array[$i];
				@$array[$i] = @$array[$j];
				@$array[$j] = $w;
				++$it_swap;
				++$i;
				--$j;
			}
		}
		if ($L < $j) { 
			#say "LEFT";
			push @$data, $it_swap;
			push @$data, $it_compare;
			push @$data, $j;
			push @$data, $L;
			
			($it_swap, $it_compare, @$array) = sort_alg(\@$data, \@$array)
		};
	
		if ($i < $R) { 
			#say "RIGHT";
			push @$data, $it_swap;
			push @$data, $it_compare;
			push @$data, $R;
			push @$data, $i;
			
			($it_swap, $it_compare, @$array) = sort_alg(\@$data, \@$array);
		};

		#push @array, $it_swap;
		#push @array, $it_compare;
		
		return $it_swap, $it_compare, @$array;
	};
	push @data, $it_swap;
	push @data, $it_compare;
	push @data, ($len - 1);
	push @data, 0;

	#push @array, $it_swap;
	#push @array, $it_compare;
	#push @array, ($len - 1);
	#push @array, 0;

	($it_swap, $it_compare, @result) = sort_alg(\@data, \@array);
	#$it_compare = pop @result;
	#$it_swap = pop @result;
	
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
		#LOOP:
		while ( ( $j > 0 ) && ($x <= $array[$j - 1]) ){
			++$it_compare;
			#if ($x <= $array[$j - 1]) {
				$array[$j] = $array[$j - 1];
				++$it_swap;
				--$j;
			#} else {
			#	last LOOP;		
			#}
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
	my $L = ($len) / 2;
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
		my $R = pop @$ItLR;
		my $L = pop @$ItLR;
		
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
			#say "X: ".$x;
			#say "a[j]".@$arrayToSift[$j];
			$it_swap++;

			$it_compare++;
			if ( ($j < $R ) && ( @$arrayToSift[$j] < @$arrayToSift[$j + 1]) ){
				$j++;
			}
		}
		@$arrayToSift[$i] = $x;
		#say join(" ", @$arrayToSift);
		return $it_swap, $it_compare, @$arrayToSift;
	}	
	my @result = @array;	
	#say "RESULT: ";
	#say join(" ", @result);
	return $it_swap, $it_compare, @result;
}

1;

