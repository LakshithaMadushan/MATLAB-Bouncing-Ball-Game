close all;
clear all;
clc;

%  Show groun level and ball init level
rectangle('Position', [0 1.5 0.5 0], 'EdgeColor', 'c')
rectangle('Position', [0 0 10 0], 'EdgeColor', 'k')

%  Score Board
score = 0;
text(3, 2, 'Score: ', 'Color', 'black', 'FontSize', 12);
init_txt = text(3.5, 2, num2str(score), 'Color', 'black', 'FontSize', 12);

%  Command line inputs
while 1
    
    %  Plot the ball
    init_ball = plot_ball(0, 1.5);
    
    %  Hit Board
    [A, B, board] = hit_board(rand_num());
    
    user_input = input('To exit the game, enter x. \n To play the game, enter a shooting angle beteen -90 and 90 degree:', 's');
    
    if user_input == 'x'       %  Check user input == x 
        disp('Game exit'); 
        close all;
        clear all;
        break
    else
        
        new_num = str2num(user_input);
        
        if (isreal(new_num) && isscalar(new_num))     %  Check user input is valid number or not
            
            if ((str2num(user_input) >= -90) && (str2num(user_input) <= 90))       %  Check user input is between -90 & 90
                disp('Shooted the ball...');
                    delete(init_ball)
                    hitted_x = shoot_curve(new_num);
                                
                if (hitted_x >= A && hitted_x <= B)
                    % Adding score
                    score = score + 1;
                    score_board(init_txt, score);
                end
            else
                disp('Invalid angle...');
                delete(init_ball)
            end        
            
        elseif (imag(new_num) ~= 0)
            disp('Enter a real number (-90~99) rather than any complex number !!!');
            delete(init_ball)
        elseif ~(isscalar(new_num))
            disp('Enter a real number (-90~99) rather than any string !!!');
            delete(init_ball)
        end
        
    end
    pause(0.5)
    delete(board)
end

%  Hit Board function
function [x1, x2, board] = hit_board(b)
    if b == 1
        clr = 'r';
    elseif b == 2
        clr = 'g';
    elseif b == 3
        clr = 'y';
    else
        clr = 'b';
    end
    
    temp_rn = randperm(10,1);       %  To get more random position
    
    x1 = (b-1) + (temp_rn./10);
    x2 = x1 + 0.5;
    y1 = 0;
    
    %  plot(x, y, clr, 'LineWidth', 5);
    board = rectangle('Position',[x1, y1, 0.5, 0.05], 'FaceColor', clr, 'EdgeColor', 'k', 'LineWidth', 1);
    axis([0, 4, -1, 2.5]);
end

%  Score Board function
function score_board(txt, score)
    set(txt, 'String', num2str(score))
end

%  Random number function
function rn = rand_num()
    rn = randperm(3,1);
end

%  Plot the ball function
function pb = plot_ball(x,y)  
    %  plot(x, y, 'ro', 'markerfacecolor', 'r','MarkerSize', 15);
    pb = rectangle('Position', [x y 0.1 0.1], 'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'k', 'LineWidth',1);
    axis([0, 4, -1, 2.5]);
end

%  Shoot the curve function
function hit_x = shoot_curve(ang)

    % constants and initial values
    g = 9.8;            % acceleration of gravity 
    v0 = 4;             % initial velocity
    th = ang.*pi./180;  % radians, launch angle
    y0 = 1.5;           % initial height (m)
    x0 = 0;             % initial position (m)
    val=0;

    [vx0,vy0] = pol2cart(th,v0);     %  transforms corresponding elements of the polar coordinate arrays theta and rho to two-dimensional Cartesian

    t = linspace(0,max(roots([-g./2, vy0, y0])),100);       % y = linspace(x1,x2,n) generates n points. The spacing between the points is (x2-x1)/(n-1).

    x = x0 + vx0.*t;
    y = y0 + vy0.*t - 0.5 .* g .* t .^2;
    
    axis equal
    while 1
        val=val+1;
        if val == 100
            break;
        end
         
        % hold on;        %  To hold the graph
        % plot(x(val), y(val), 'c.', 'markerfacecolor', 'c','MarkerSize', 5);
        axis([0, 4, -1, 2.5]);
        my = plot_ball(x(val), y(val));
        pause(0.005);
        
        if val == 99
            pause(0.5)
            delete(my)
        else
            delete(my)
        end
        
    end
    axis([0, 4, -1, 2.5]);
    hit_x = x(100);
end




