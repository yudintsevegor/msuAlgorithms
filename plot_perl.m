function plot_perl(mode)

    str_1 = '~/Perl/MSU_algorithms/task_1/';
    str_2 = '~/Perl/MSU_algorithms/task_2/';
    str_3 = '~/Perl/MSU_algorithms/task_3/';
    
if (mode == 1)
   
     X = dlmread(strcat(str_1, 'fix_text_X.txt'));
     Y_1 = dlmread(strcat(str_1, 'fix_text_Y1.txt'));
     Y_2 = dlmread(strcat(str_1, 'fix_text_Y2.txt'));
     
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
     Y_1 = dlmread(strcat(str_1, 'fix_string_Y1.txt'));
     Y_2 = dlmread(strcat(str_1, 'fix_string_Y2.txt'));
 
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

end