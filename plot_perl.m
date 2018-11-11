function plot_perl(mode)

    str_1 = './task_1/';
    str_2 = './task_2/';
    str_3 = './task_3/';
    
if (mode == 1)
	X = dlmread(strcat(str_1, 'fix_text_X.txt'));
	Y_1 = dlmread(strcat(str_1, 'fix_text_Ybf.txt'));
	Y_2 = dlmread(strcat(str_1, 'fix_text_Ybm.txt'));

	fig = figure(1);
	%plot(X, Y_1, "*",X, Y_2, "o");
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the length of the string at a fixed text')
	xlabel('Lenth of the string')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_1, 'fix_text'), '-dpng');
	legend('bf','bm')

	X = dlmread(strcat(str_1, 'fix_string_X.txt'));
	Y_1 = dlmread(strcat(str_1, 'fix_string_Ybf.txt'));
	Y_2 = dlmread(strcat(str_1, 'fix_string_Ybm.txt'));

	fig = figure(2);
	%plot(X, Y_1, "*",X, Y_2, "o");
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the length of the text at a fixed string')
	xlabel('Lenth of Text')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_1, 'fix_string'), '-dpng');
	legend('bf','bm')

elseif (mode == 2)
	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_order_YswapHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_order_YswapIns.txt'));

	fig = figure(1);
	%plot(X, Y_1, "*",X, Y_2, "o");
	plot(X, log(Y_1), X, log(Y_2));
	title('The dependence of the number of operations on the length of the string at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_swap'), '-dpng');
	legend('HeapSort','Insection')

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_order_YcompareHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_order_YcompareIns.txt'));

	fig = figure(2);
	%plot(X, Y_1, "*",X, Y_2, "o");
	plot(X, log(Y_1), X, log(Y_2));
	title('The dependence of the number of operations on the length of the massive at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_compare'), '-dpng');
	legend('HeapSort','Insection')

elseif (mode == 3)
	X = dlmread(strcat(str_3, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_order_YswapQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_order_YswapSel.txt'));

	fig = figure(1);
	%plot(X, Y_1, "*",X, Y_2, "o");
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the length of the string at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_3, 'fix_order_swap'), '-dpng');
	legend('QuickSort','Selection')

	X = dlmread(strcat(str_3, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_order_YcompareQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_order_YcompareSel.txt'));

	fig = figure(2);
	%plot(X, Y_1, "*",X, Y_2, "o");
	%plot(X, log(Y_1), X, log(Y_2));
    plot(X, Y_1, X, Y_2);
    title('The dependence of the number of operations on the length of the massive at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_3, 'fix_order_compare'), '-dpng');
	legend('QuickSort','Selection')
end
