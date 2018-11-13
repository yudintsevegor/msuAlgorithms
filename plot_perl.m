function plot_perl(mode)

    str_1 = './task_1/points/';
    str_2 = './task_2/points/';
    str_3 = './task_3/points/';
    
if (mode == 1)
	X = dlmread(strcat(str_1, 'fix_text_X.txt'));
	Y_1 = dlmread(strcat(str_1, 'fix_text_Ybf.txt'));
	Y_2 = dlmread(strcat(str_1, 'fix_text_Ybm.txt'));

	fig = figure(1);
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
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the length of the text at a fixed string')
	xlabel('Lenth of Text')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_1, 'fix_string'), '-dpng');
	legend('bf','bm')

elseif (mode == 2)
    x = 0:100:4000;
    y = x.*log(x)/log(2);
    
	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_order_YswapHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_order_YswapIns.txt'));

	fig = figure(1);
	%plot(X, Y_1, "*",X, Y_2, "o");
    %plot(X, Y_1, X, Y_2);
	plot(X, log(Y_1), X, log(Y_2));
	title('The dependence of the number of operations on the length of the string at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_swap'), '-dpng');
	legend('HeapSort','Insertion')

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_order_YcompareHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_order_YcompareIns.txt'));

	fig = figure(2);
	%plot(X, Y_1, "*",X, Y_2, "o");
	%plot(X, Y_1, X, Y_2);
    plot(X, log(Y_1), X, log(Y_2));
	title('The dependence of the number of operations on the length of the massive at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_compare'), '-dpng');
	legend('HeapSort','Insertion')
	
	X = dlmread(strcat(str_2, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_massive_YswapHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_massive_YswapIns.txt'));

	fig = figure(3);
	%plot(X, Y_1, "*",X, Y_2, "o");
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, 'fix_massive_swap'), '-dpng');
	legend('HeapSort','Insertion')

	X = dlmread(strcat(str_2, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_massive_YcompareHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_massive_YcompareIns.txt'));

	fig = figure(4);
	%plot(X, Y_1, "*",X, Y_2, "o");
	%plot(X, log(Y_1), X, log(Y_2));
    plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, 'fix_massive_compare'), '-dpng');
	legend('HeapSort','Insertion')
    
 	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YswapIns.txt'));

	fig = figure(5);
	plot(X, Y);
	title('The dependence of the number of operations on the length of the string at a fixed order(Insertion)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_swapIns'), '-dpng');
	
    
	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YswapHS.txt'));
   
	fig = figure(6);
	plot(X, Y, x ,y,'o');
    %plot(X, Y);
	title('The dependence of the number of operations on the length of the massive at a fixed order(HS)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_swapHS'), '-dpng');
    
    X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YcompareIns.txt'));

	fig = figure(7);
	plot(X, Y);
	title('The dependence of the number of operations on the length of the string at a fixed order(Insertion)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_compareIns'), '-dpng');
	
    
	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YcompareHS.txt'));
   
	fig = figure(8);
	plot(X, Y, x ,y,'o');
    %plot(X, Y);
	title('The dependence of the number of operations on the length of the massive at a fixed order(HS)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, 'fix_order_compareHS'), '-dpng');
    
    
  
elseif (mode == 3)
	%{
    X = dlmread(strcat(str_3, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_order_YswapQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_order_YswapSel.txt'));

	fig = figure(1);
	%plot(X, Y_1, "*",X, Y_2, "o");
	%plot(X, Y_1, X, Y_2);
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
    %plot(X, Y_1, X, Y_2);
    title('The dependence of the number of operations on the length of the massive at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_3, 'fix_order_compare'), '-dpng');
	%legend('QuickSort','Selection')
	%}
	X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_massive_YswapQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_massive_YswapSel.txt'));

	fig = figure(3);
	%plot(X, Y_1, "*",X, Y_2, "o");
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_3, 'fix_massive_swap'), '-dpng');
	legend('QuickSort','Selection')

	X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_massive_YcompareQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_massive_YcompareSel.txt'));

	fig = figure(4);
	%plot(X, Y_1, "*",X, Y_2, "o");
	%plot(X, log(Y_1), X, log(Y_2));
    plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_3, 'fix_massive_compare'), '-dpng');
	legend('QuickSort','Selection')
    
    X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'Operations.txt'));
    %Y_2 = dlmread(strcat(str_3, 'fix_massive_YswapQS.txt'));
    fig = figure(5);
	%plot(X, Y_1, "*",X, Y_2, "o");
    %plot(X, Y_1, X, Y_2);
    plot(X, Y_1);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(ALL)')
	grid on;
	print(fig, strcat(str_3, 'operations'), '-dpng');
    
    X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'Time.txt'));
    %Y_2 = dlmread(strcat(str_3, 'fix_massive_YswapQS.txt'));
    fig = figure(6);
	%plot(X, Y_1, "*",X, Y_2, "o");
    %plot(X, Y_1, X, Y_2);
    plot(X, Y_1);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Time')
	grid on;
	print(fig, strcat(str_3, 'time'), '-dpng');
    
    
    X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_massive_YcompareQS.txt'));
    Y_2 = dlmread(strcat(str_3, 'fix_massive_YswapQS.txt'));
    fig = figure(7);
	%plot(X, Y_1, "*",X, Y_2, "o");
    plot(X, Y_1, X, Y_2);
    %plot(X, Y_1);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_3, 'operations separeted'), '-dpng');
    legend('compare','swap');

end
