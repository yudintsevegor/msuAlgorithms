package SM;

use strict;

sub new {
	my $class = shift;
	my %args = @_;
	my $self = bless \%args, $class;
	return $self;
}


sub brute_force {
	
	my ($self) = @_;
	
	my $it = 0;
	my $i = 0;
	my $j = 0;
	my $str;
	
	my @text = @{ $self->{text} };
	my @sample = @{ $self->{sample} };
	my $N = $self->{ N };
	my $M = $self->{ M };

	while ( ($i <= $N - $M) && ($j < $M) ) {
		if  ($text[$i + $j] eq $sample[$j]) {
			$j++;
			$str = "FOUND";
		} else {
			$str = "NOT FOUND";
			$i++;
			$j = 0;
		
		}
		$it++;	
	}
	
	my $r;
	if ($str eq "FOUND"){
		$r = $i;	
	} else {
		$r = -1;
	}	
	
	my @answer = ($it, $r);;
	return @answer;

}

sub boyer_moore {
	
	my ($self) = @_;
	
	my $it;
	my $i = 0;
	my $j = 0;
	my @D;
	
	my @text = @{ $self->{text} };
	my @sample = @{ $self->{sample} };
	my $N = $self->{ N };
	my $M = $self->{ M };

	while ( $i <= 255) {
		$D[$i] = $M;
		$i++;
	}

	while ($j <= $M - 2) {
		$D[ ord($sample[$j]) ] = $M - $j - 1;
		$j++;
	}

	$i = $M;
	$j = $M;
	my $k = $i;	

	while ( ($j > 0) && ($i <= $N) ) {
		$j = $M;
		$k = $i;
		
		while( ($j > 0) && ( $text[$k - 1] eq $sample[$j - 1] ) ) {
			--$k;
			--$j;
		} 
			$i += $D[ ord($text[$i - 1]) ];
		$it++;
	}

	my $r;
	if ( $j <= 0) {
		$r = $k;
	} else {
		$r = -1;
	}
	
	my @answer = ($it, $r);
	return @answer;

}

1;
