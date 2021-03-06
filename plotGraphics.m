%{
    mode:
            1 - StringSearch
            2 - Sort I
            3 - Sort II
            4 - Recursion
            5 - Trees
            6 - Hashtables
%}

function plotGraphics(mode)
    
	str_1 = './StringSearch/points/';
	str_2 = './SortI/points/';
	str_3 = './SortII/points/';
	str_4 = './Recursion/points/';
	str_5 = './Trees/points/';
    str_6 = './Hashtables/points/';

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
	print(fig, strcat(str_1, '../pic/', 'fix_text'), '-dpng');
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
	print(fig, strcat(str_1, '../pic/',  'fix_string'), '-dpng');
	legend('bf','bm')

elseif (mode == 2)
	x = 0:100:4000;
	y = x.*log(x)/log(2);

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_order_YswapHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_order_YswapIns.txt'));

	fig = figure(1);
	plot(X, log(Y_1), X, log(Y_2));
	title('The dependence of the number of operations on the length of the string at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('log_2 from Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, '../pic/', 'fix_order_swap'), '-dpng');
	legend('HeapSort','Insertion')

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_order_YcompareHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_order_YcompareIns.txt'));

	fig = figure(2);
	plot(X, log(Y_1), X, log(Y_2));
	title('The dependence of the number of operations on the length of the massive at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('log_2 from Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, '../pic/', 'fix_order_compare'), '-dpng');
	legend('HeapSort','Insertion')

	X = dlmread(strcat(str_2, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_massive_YswapHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_massive_YswapIns.txt'));

	fig = figure(3);
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, '../pic/', 'fix_massive_swap'), '-dpng');
	legend('HeapSort','Insertion')

	X = dlmread(strcat(str_2, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_2, 'fix_massive_YcompareHS.txt'));
	Y_2 = dlmread(strcat(str_2, 'fix_massive_YcompareIns.txt'));

	fig = figure(4);
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, '../pic/', 'fix_massive_compare'), '-dpng');
	legend('HeapSort','Insertion')

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YswapIns.txt'));

	fig = figure(5);
	plot(X, Y);
	title('The dependence of the number of operations on the length of the string at a fixed order(Insertion)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2,'../pic/', 'fix_order_swapIns'), '-dpng');

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YswapHS.txt'));

	fig = figure(6);
	plot(X, Y, x ,y,'o');
	title('The dependence of the number of operations on the length of the massive at a fixed order(HS) and n*log_2(n)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_2, '../pic/', 'fix_order_swapHS'), '-dpng');

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YcompareIns.txt'));

	fig = figure(7);
	plot(X, Y);
	title('The dependence of the number of operations on the length of the string at a fixed order(Insertion)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, '../pic/', 'fix_order_compareIns'), '-dpng');

	X = dlmread(strcat(str_2, 'fix_order_X.txt'));
	Y = dlmread(strcat(str_2, 'fix_order_YcompareHS.txt'));

	fig = figure(8);
	plot(X, Y, x ,y,'o');
	title('The dependence of the number of operations on the length of the massive at a fixed order(HS) and n*log_2(n)')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_2, '../pic/',  'fix_order_compareHS'), '-dpng');

elseif (mode == 3)

	X = dlmread(strcat(str_3, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_order_YswapQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_order_YswapSel.txt'));

	fig = figure(1);
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the length of the string at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_3, '../pic/', 'fix_order_swap'), '-dpng');
	legend('QuickSort','Selection')

	X = dlmread(strcat(str_3, 'fix_order_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_order_YcompareQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_order_YcompareSel.txt'));

	fig = figure(2);
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the length of the massive at a fixed order')
	xlabel('Lenth of the massive')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_3,'../pic/',   'fix_order_compare'), '-dpng');
	legend('QuickSort','Selection')

	X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_massive_YswapQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_massive_YswapSel.txt'));

	fig = figure(3);
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(swap)')
	grid on;
	print(fig, strcat(str_3,'../pic/', 'fix_massive_swap'), '-dpng');
	legend('QuickSort','Selection')

	X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_massive_YcompareQS.txt'));
	Y_2 = dlmread(strcat(str_3,'fix_massive_YcompareSel.txt'));

	fig = figure(4);
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(compare)')
	grid on;
	print(fig, strcat(str_3, '../pic/', 'fix_massive_compare'), '-dpng');
	legend('QuickSort','Selection')

	X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3,'Operations.txt'));

	fig = figure(5);
	plot(X, Y_1);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations(ALL)')
	grid on;
	print(fig, strcat(str_3,'../pic/', 'operations'), '-dpng');
    
	X = dlmread(strcat(str_3, 'fix_massive_X.txt'));
	Y_1 = dlmread(strcat(str_3, 'fix_massive_YcompareQS.txt'));
	Y_2 = dlmread(strcat(str_3, 'fix_massive_YswapQS.txt'));

	fig = figure(6);
	plot(X, Y_1, X, Y_2);
	title('The dependence of the number of operations on the order of the array at a fixed massive')
	xlabel('Order')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_3, '../pic/', 'operations separeted'), '-dpng');
	legend('compare','swap');

elseif (mode == 4)

	X = dlmread(strcat(str_4, 'pointsSize.txt'));
	Y_1 = dlmread(strcat(str_4, 'pointsCalls.txt'));
	Y_2 = dlmread(strcat(str_4, 'pointsAll.txt'));
	Y_3 = dlmread(strcat(str_4, 'pointsUniq.txt'));

	fig = figure(1);
	plot(X, Y_1);
	title('The dependence of recursive calls  on the size of ChessBoard')
	xlabel('Size Of ChessBoard')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_4, '../pic/', 'recursiveCalls'), '-dpng');

	fig = figure(2);
	plot(X, Y_2);
	title('The dependence of number of positions(ALL) on the size of ChessBoard')
	xlabel('Size Of ChessBoard')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_4, '../pic/', 'positionsAll'), '-dpng');


	fig = figure(3);
	plot(X, Y_3);
	title('The dependence of number of positions(UNIQ) on the size of ChessBoard')
	xlabel('Size Of ChessBoard')
	ylabel('Number of operations')
	grid on;
	print(fig, strcat(str_4, '../pic/', 'positionsUNIQ'), '-dpng');

elseif (mode == 5)
    
   	xB = 0:1:21109;
	yB = 2.3*log(xB)/log(2);
    
    xAVL = 0:1:21094;
	yAVL = 1.2*log(xAVL)/log(2);
    
	X_1 = dlmread(strcat(str_5, 'lengthBT.txt'));
	X_2 = dlmread(strcat(str_5, 'lengthAVL.txt'));
	Y_1 = dlmread(strcat(str_5, 'compareBT.txt'));
	Y_2 = dlmread(strcat(str_5, 'compareAVL.txt'));

	fig = figure(1);
	plot(X_1, Y_1, 'o');
    hold on
    plot(xB, yB, 'LineWidth', 5);
    hold on
    title('The dependence of number of iterations on the size of BTree')
	xlabel('Size of tree')
	ylabel('Number of iterations(compare)')
	grid on;
	print(fig, strcat(str_5,'../pic/','compareBtree'), '-dpng');
    
    fig = figure(2);
    plot(X_2, Y_2, 'o');
    hold on
    plot(xAVL, yAVL, 'LineWidth', 5);
    hold on
	title('The dependence of number of iterations on the size of AVLTree')
	xlabel('Size of tree')
	ylabel('Number of iterations(compare)')
	grid on;
	print(fig, strcat(str_5, '../pic/', 'compareAVLtree'), '-dpng');

    elseif (mode == 6)
   
	Y_1 = dlmread(strcat(str_6, 'collisionMFC.txt'));
	X_1 = dlmread(strcat(str_6, 'occupancyMFC.txt'));
      
    Y_2 = dlmread(strcat(str_6, 'collisionMD5.txt'));
	X_2 = dlmread(strcat(str_6, 'occupancyMD5.txt'));
  
    fig = figure(1);
	plot(X_1, Y_1,'o', X_2, Y_2, 'o');
    title('The dependence of collisions on occupancy of Hashtable')
	xlabel('Occupancy of HashTable')
	ylabel('Collisions')
	grid on;
	print(fig, strcat(str_6,'../pic/','collisionsOccupancyMD5andMFC'), '-dpng');
    legend('MFC','MD5')

end
