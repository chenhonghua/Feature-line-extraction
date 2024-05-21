% 加载.mat文件
data = load('cap_33.mat');

% 访问结构体
Training_data = data.Training_data;

% 获取cell数组的大小
[num_cells, ~] = size(Training_data);

% 循环遍历每个cell  
for i = 1:num_cells
    % 获取当前cell中的struct
    current_struct = Training_data{i};
    
    % 获取当前cell中的down_sample_point,edge_points_label  
    down_sample_point = current_struct.down_sample_point;
    edge_points_label = double(current_struct.edge_points_label); % 将 uint8 类型转换为 double 类型
    
    % 获取归一化的位移坐标和缩放系数  
    nor_para = current_struct.nor_para;
    displacement = nor_para(1:3);
    scaling_factor = nor_para(4);
    
    % 扩展以匹配 down_sample_point 的大小
    scaling_factor_extended = repmat(scaling_factor, size(down_sample_point, 1), 1);
    displacement_extended = repmat(displacement', size(down_sample_point, 1), 1);
    
    % 反归一化
    down_sample_point_ori_spcace = down_sample_point .* scaling_factor_extended + displacement_extended; 
    
    % 拼接
    pc_edge_points_label_ori_spcace = [down_sample_point_ori_spcace, edge_points_label];
    
    % 保存txt
    save(['pc_edge_points_label_ori_spcace_' num2str(i) '.txt'], 'pc_edge_points_label_ori_spcace', '-ascii');
end

