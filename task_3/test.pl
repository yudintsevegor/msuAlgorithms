package main;

use 5.016;

my @a = (1 , 2 , 3);
say @a;

$a[0]++;
say @a;

my %dir = (
		task_1	=> "/home/yudintsev/Perl/MSU_algorithms/task_1/points/",
		task_2	=> "/home/yudintsev/Perl/MSU_algorithms/task_2/points/",
		task_3	=> "/home/yudintsev/Perl/MSU_algorithms/task_3/points/",
);

say $dir{task_1};


