#!/usr/bin/perl

package GRAPH;
 
use 5.016;
use strict;
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
	my %dir = (
		task_1	=> "../task_1/points/",
		task_2	=> "../task_2/points/",
		task_3	=> "../task_3/points/",
	);

	if ($self->{task} eq "task_1") {
		if ( $self->{sig_ft} == 1){
		
			@X = @{ $self->{M} };
	
		} elsif ( $self->{sig_fs} == 1) {
	
			@X = @{ $self->{N} };
	
		}
		my @Y_bf = @{ $self->{bf} };
		my @Y_bm = @{ $self->{bm} };

	
		my $filename = $dir{task_1}.$self->{name};
	
		open(my $fh, ">", $filename."_X.txt") or die $!;
		
		foreach (@X){
			say $fh $_;
		}
		close $fh;
		
		open(my $fh1, ">", $filename."_Ybf.txt") or die $!;
		open(my $fh2, ">", $filename."_Ybm.txt") or die $!;
		
		foreach my $i(0..scalar @Y_bf - 1){
			say $fh1 $Y_bf[$i];
			say $fh2 $Y_bm[$i];
		}
		close $fh1;
		close $fh2;
	} elsif ($self->{task} eq "task_2") {
		if ( $self->{sig_fo} == 1){
			@X = @{ $self->{lenth} };
	
		} elsif ( $self->{sig_fm} == 1) {
			@X = @{ $self->{order} };
	
		}
		my @Y_compareHS = @{ $self->{compareHS} };
		my @Y_compareIns = @{ $self->{compareIns} };
		my @Y_swapHS = @{ $self->{swapHS} };
		my @Y_swapIns = @{ $self->{swapIns} };

		my $filename = $dir{task_2}.$self->{name};
	
		open(my $fh, ">", $filename."_X.txt") or die $!;
		
		foreach (@X){
			say $fh $_;
		}
		close $fh;
		
		open(my $fh1, ">", $filename."_YcompareHS.txt") or die $!;
		open(my $fh2, ">", $filename."_YswapHS.txt") or die $!;
		open(my $fh3, ">", $filename."_YcompareIns.txt") or die $!;
		open(my $fh4, ">", $filename."_YswapIns.txt") or die $!;
		
		foreach my $i(0..scalar @Y_compareHS - 1){
			say $fh1 $Y_compareHS[$i];
			say $fh2 $Y_swapHS[$i];
			say $fh3 $Y_compareIns[$i];
			say $fh4 $Y_swapIns[$i];
		}
		close $fh1;
		close $fh2;
		close $fh3;
		close $fh4;
	} elsif ($self->{task} eq "task_3") {
		if ( $self->{sig_fo} == 1){
			@X = @{ $self->{lenth} };
	
		} elsif ( $self->{sig_fm} == 1) {
			@X = @{ $self->{order} };
	
		}
		my @Y_compareQS = @{ $self->{compareQS} };
		my @Y_compareSel = @{ $self->{compareSel} };
		my @Y_swapQS = @{ $self->{swapQS} };
		my @Y_swapSel = @{ $self->{swapSel} };

		my $filename = $dir{task_3}.$self->{name};
		open(my $fh, ">", $filename."_X.txt") or die $!;
		
		foreach (@X){
			say $fh $_;
		}
		close $fh;
		
		open(my $fh1, ">", $filename."_YcompareQS.txt") or die $!;
		open(my $fh2, ">", $filename."_YswapQS.txt") or die $!;
		open(my $fh3, ">", $filename."_YcompareSel.txt") or die $!;
		open(my $fh4, ">", $filename."_YswapSel.txt") or die $!;
		
		foreach my $i(0..scalar @Y_compareQS - 1){
			say $fh1 $Y_compareQS[$i];
			say $fh2 $Y_swapQS[$i];
			say $fh3 $Y_compareSel[$i];
			say $fh4 $Y_swapSel[$i];
		}
		close $fh1;
		close $fh2;
		close $fh3;
		close $fh4;
	}
}
1;

