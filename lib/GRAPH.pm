#!/usr/bin/perl

package GRAPH;
 
use strict;
#use GD::Graph::linespoints;
use DDP;
 
sub new {
	my $class = shift;
	my %args = @_;
	my $self = bless \%args, $class;
	return $self;
}

sub plot {
	my ($self) = @_;

	my @X;
	p $self;
	my %dir = {
		task_1	=> "/home/yudintsev/Perl/MSU_algorithms/task_1/"
	};

	if ($self->{task} eq "task_1") {
		if ( $self->{sig_ft} == 1){
		
			@X = @{ $self->{M} };
	
		} elsif ( $self->{sig_fs} == 1) {
	
			@X = @{ $self->{N} };
	
		}
		my @Y_1 = @{ $self->{bf} };
		my @Y_2 = @{ $self->{bm} };

	
		my $filename = $dir{task_1}.$self->{name};
	
		open(my $fh, ">", $filename."_X.txt") or die $!;
		
		foreach (@X){
			say $fh $_;
		}
		close $fh;
		
		open(my $fh1, ">", $filename."_Y1.txt") or die $!;
		open(my $fh2, ">", $filename."_Y2.txt") or die $!;
		
		foreach my $i(0..scalar @Y_1 - 1){
			say $fh1 $Y_1[$i];
			say $fh2 $Y_2[$i];
		}
		close $fh1;
		close $fh2;
	}
}
1;

