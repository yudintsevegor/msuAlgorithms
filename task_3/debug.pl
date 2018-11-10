	sub creation{
		my $mode = shift @_;
		my @array = @_;
		my $len = scalar @array;
		my $i = 0;

		my $k = $i;
		my $x = $array[$i];
		my $j = $i + 1;

		while ($j <= $len - 1) {
			if ( ($mode == 1) && ( $array[$j] < $x) ) {
				$k = $j;
				$x = $array[$k];
			} elsif ( ($mode == 2) && ($array[$j] > $x) ) {
				$k = $j;
				$x = $array[$k];
			}	
			++$j;
		}
		$array[$k] = $array[$i];
		$array[$i] = $x;

		return $x, @array[1..scalar @_ - 1];
	}

	my $c = 0;
	my $mode;
	my @add;
	my $el;
	my @data;
	my @result = @array;	
	while ( $c < scalar @array){
		$mode = 1;
		unshift @result, $mode;
		($el, @result) = creation(@result);
		
		say "EL: ".$el;
		push (@add, $el);
		@data = (@add, @result);
		p @data;

		my $object = SORT->new(
			data	=>	[@data],
		);
		
		my ($it_swap, $it_compare, @answer_sel) = $object->selection;
		#p @answer_sel;
		#my @answer_qs = $object->quicksort;
		#p @answer_qs;
	
		++$c;
	}
	
	my $c = 0;
	my @add;
	my $el;
	my @data;
	my @result = @array;	

	while ( $c < scalar @array){
		$mode = 2;
		unshift @result, $mode;
		($el, @result) = creation(@result);
		
		say "EL: ".$el;
		push (@add, $el);
		@data = (@add, @result);
		p @data;

		my $object = SORT->new(
			data	=>	[@data],
		);
		
		my ($it_swap, $it_compare, @answer_sel) = $object->selection;
		#p @answer_sel;
		#my @answer_qs = $object->quicksort;
		#p @answer_qs;
	
		++$c;
	}

