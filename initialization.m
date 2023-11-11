% 这个函数初始化第一批搜索代理
function Positions=initialization(SearchAgents_no,dim,ub,lb)

%     随机分布
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
        random_points=Positions;
    end
    
    %均匀分布
%         x_step = (ub(1) - lb(1)) / 4;
%         y_step = (ub(2) - lb(2)) / 4;
%         z_step = (ub(3) - lb(3)) / 4;
%         [X, Y, Z] = meshgrid(lb(1)+x_step:x_step:ub(1)-x_step, lb(2)+y_step:y_step:ub(2)-y_step, lb(3)+z_step:z_step:ub(3)-z_step);
%         points = [X(:), Y(:), Z(:)];
%         Positions = points;        
%         random_indices = randperm(size(Positions, 1), SearchAgents_no);
%         random_points = Positions(random_indices, :);
        
        figure();
        plot3([lb(1), ub(1), ub(1), lb(1), lb(1)], [lb(2), lb(2), ub(2), ub(2), lb(2)], [lb(3), lb(3), lb(3), lb(3), lb(3)], 'k-', 'LineWidth', 2);
        hold on;
        plot3([lb(1), ub(1), ub(1), lb(1), lb(1)], [lb(2), lb(2), ub(2), ub(2), lb(2)], [ub(3), ub(3), ub(3), ub(3), ub(3)], 'k-', 'LineWidth', 2);
        plot3([ub(1), ub(1)], [lb(2), lb(2)], [lb(3), ub(3)], 'k-', 'LineWidth', 2);
        plot3([ub(1), ub(1)], [ub(2), ub(2)], [lb(3), ub(3)], 'k-', 'LineWidth', 2);
        plot3([lb(1), lb(1)], [ub(2), ub(2)], [lb(3), ub(3)], 'k-', 'LineWidth', 2);
        plot3([lb(1), lb(1)], [lb(2), lb(2)], [lb(3), ub(3)], 'k-', 'LineWidth', 2);
        scatter3(random_points(:, 1), random_points(:, 2), random_points(:, 3), 'filled');
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        title('基于MIN-MAX算法的VLP系统');
        grid on;
        axis equal;

        % 设置坐标轴范围
        xlim([-1 6]);
        ylim([-1 6]);
        zlim([-1 3]);

        % 设置轴刻度
        set(gca, 'XTick', -1:6);
        set(gca, 'YTick', -1:6);
        set(gca, 'ZTick', 0:3);
        % 设置网格线
        grid on;
        % 设置视角
        view(3);
