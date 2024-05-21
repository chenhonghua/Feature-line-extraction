% ����.mat�ļ�
data = load('cap_33.mat');

% ���ʽṹ��
Training_data = data.Training_data;

% ��ȡcell����Ĵ�С
[num_cells, ~] = size(Training_data);

% ѭ������ÿ��cell  
for i = 1:num_cells
    % ��ȡ��ǰcell�е�struct
    current_struct = Training_data{i};
    
    % ��ȡ��ǰcell�е�down_sample_point,edge_points_label  
    down_sample_point = current_struct.down_sample_point;
    edge_points_label = double(current_struct.edge_points_label); % �� uint8 ����ת��Ϊ double ����
    
    % ��ȡ��һ����λ�����������ϵ��  
    nor_para = current_struct.nor_para;
    displacement = nor_para(1:3);
    scaling_factor = nor_para(4);
    
    % ��չ��ƥ�� down_sample_point �Ĵ�С
    scaling_factor_extended = repmat(scaling_factor, size(down_sample_point, 1), 1);
    displacement_extended = repmat(displacement', size(down_sample_point, 1), 1);
    
    % ����һ��
    down_sample_point_ori_spcace = down_sample_point .* scaling_factor_extended + displacement_extended; 
    
    % ƴ��
    pc_edge_points_label_ori_spcace = [down_sample_point_ori_spcace, edge_points_label];
    
    % ����txt
    save(['pc_edge_points_label_ori_spcace_' num2str(i) '.txt'], 'pc_edge_points_label_ori_spcace', '-ascii');
end

