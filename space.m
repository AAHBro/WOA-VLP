function space(lb,ub,TN,searchSpace_position,Positions,Best_pos,ledPositions,FIRST)
figure(1);

        % 绘制两个特定点
        x = searchSpace_position(1);
        y = searchSpace_position(2);
        z = searchSpace_position(3);
        x2 =Best_pos(1);
        y2 =Best_pos(2);
        z2 =Best_pos(3);
        point1 = [x, y, z];  % 第一个点的坐标
        point2 = [x2, y2, z2]; 
%         figure(1);
        hold on;
        
        scatter3(point1(1), point1(2), point1(3), 'filled', 'MarkerFaceColor', 'r');
        scatter3(point2(1), point2(2), point2(3), 'filled', 'MarkerFaceColor', 'g');
        scatter3(TN(1), TN(2), TN(3), 'filled', 'MarkerFaceColor', 'b');
        text(point1( 1), point1(2), point1(3), sprintf('SP'), 'FontSize', 10, 'FontWeight', 'bold');
        text(point2(1), point2(2), point2(3), sprintf('BP'), 'FontSize', 10);
        text(TN(1), TN(2), TN(3), sprintf('TN'), 'FontSize', 10, 'FontWeight', 'bold');
        
%         scatter3(FIRST(1,1), FIRST(1,2), FIRST(1,3), 'filled', 'MarkerFaceColor', 'y');
%         text(FIRST(1,1), FIRST(1,2), FIRST(1,3), sprintf('F1'), 'FontSize', 10, 'FontWeight', 'bold');
                
%         scatter3(FIRST(3,1), FIRST(3,2), FIRST(3,3), 'filled', 'MarkerFaceColor', 'm');
%         text(FIRST(3,1)+0.3, FIRST(3,2), FIRST(3,3), sprintf('F3'), 'FontSize', 10 );
        
        scatter3(ledPositions(1), ledPositions(2), ledPositions(3), 'filled', 'MarkerFaceColor', 'k');
        text(ledPositions(1), ledPositions(2), ledPositions(3), sprintf('led'), 'FontSize', 10, 'FontWeight', 'bold');
   
        
        %8ge 八个顶点
        vertices = [
            lb(1) lb(2) lb(3);
            lb(1) ub(2) lb(3);
            ub(1) ub(2) lb(3);
            ub(1) lb(2) lb(3);
            lb(1) lb(2) ub(3);
            lb(1) ub(2) ub(3);
            ub(1) ub(2) ub(3);
            ub(1) lb(2) ub(3)
        ];

        % 定义立方体的边
        edges = [
            1 2;2 3;3 4;4 1;5 6;6 7;7 8;8 5;1 5;2 6;3 7;4 8
        ];

%         % 绘制立方体
        patch('Vertices', vertices, 'Faces', edges, 'FaceColor', 'green', 'EdgeColor', 'black');
        
        % 设置坐标轴标签
        xlabel('X');
        ylabel('Y');
        zlabel('Z');

        % 设置坐标轴范围
        xlim([-1 6]);
        ylim([-1 6]);
        zlim([0 3]);

        % 设置轴刻度
        set(gca, 'XTick', -1:6);
        set(gca, 'YTick', -1:6);
        set(gca, 'ZTick', 0:5);
        % 设置网格线
        grid on;
        % 设置视角
        view(3);
        
%         for i = 1:size(vertices, 1)
%             text(vertices(i, 1), vertices(i, 2), vertices(i, 3), sprintf('V%d', i), 'FontSize', 8, 'FontWeight', 'bold');
%         end
        
        % 启动交互式旋转
        rotate3d on;         