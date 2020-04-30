function [path_figure, result_figure,Outline] = visualization(...
    AlgParams, Reference, VehicleParams, Vehicle_State, Control_State,...
    simulation_time)
% ·������Ч�����ӻ�����������Ч��������ǰ��ƫ��

% ���:
% path_figure           : ·������Ч����figure
% steer_figure          : ������ ǰ��ƫ�ǵ�figure

% ����:
% AlgParams             : ·�������㷨
% Reference             : ����·��
% VehicleParams         : ��������
% Vehicle_State         : ����״̬
% steer_state           : ǰ��ƫ��
% simulation_time       : ��ǰ����ʱ��

% 1. ��������·����������ʼλ��״̬
screen_size = get(groot, 'Screensize'); %��ȡ������ʾ���Ŀ�Ⱥ͸߶�
screen_width = screen_size(3);          %��Ļ���
screen_height = screen_size(4);         %��Ļ�߶�

path_figure = figure('name', 'Path Tracking', 'position',...
    [0, screen_height*1/7, screen_width/2, screen_height*3/4]);
hold on;
grid minor;
axis equal;
path_figure_title_name = set_title_name(AlgParams.type);
title(path_figure_title_name, 'fontsize', 15);  %����title����
xlabel('X(m)', 'fontsize', 15);         %x������
ylabel('Y(m)', 'fontsize', 15);         %y������

plot(Reference.cx, Reference.cy, 'r.', 'markersize',3,'DisplayName','Reference'); %�����켣���ӻ�
Outline = plot_car(VehicleParams, Vehicle_State, Control_State);    %������ʼλ�˿��ӻ�
% legend({'trajref', 'vehicle pose'}, 'fontsize', 12);        %ͼ��


% 2. ����ǰ��ƫ�ǧ������
result_figure = figure('name', 'Path Tracking', 'position',...
    [screen_width/2, screen_height*1/7, screen_width/2, screen_height*3/4]);
subplot(2,1,1);
hold on;
grid minor;
steer_figure_title_name = set_title_name(AlgParams.type);
title(steer_figure_title_name, 'fontsize', 15);
% steer_figure_xlimit = simulation_stop_time;
% steer_figure_ylimit = veh_params.max_steer_angle / pi * 180;
% axis([0, steer_figure_xlimit, -steer_figure_ylimit, steer_figure_ylimit]);
xlabel('time(s)','fontsize', 15);
ylabel('steer command(deg)', 'fontsize', 15);
plot(simulation_time, Control_State, 'b.', 'markersize', 15);
legend({'steer command'}, 'fontsize', 12);
subplot(2,1,2);
hold on;
grid minor;
error_figure_title_name = set_title_name(AlgParams.type);
title(error_figure_title_name, 'fontsize', 15);
xlabel('time(s)','fontsize', 15);
ylabel('error(m)', 'fontsize', 15);
[error, ~] = calc_nearest_point(Reference, Vehicle_State);
plot(simulation_time, error, 'b.', 'markersize', 15);
legend({'error'}, 'fontsize', 12);


    function title_name = set_title_name(path_tracking_alg)
    % ����ʹ�õ�·�����ٷ�������

    % ���:
    % title_name        : ��������

    % ����
    % path_tracking_alg : ·�������㷨
    % Pure Pursuit,Stanley,Kinematics MPC,Dynamics MPC
    switch (path_tracking_alg)
        % ������ѡ·�������㷨ָ��figure��title
        case 'Pure Pursuit'
            title_name = 'Path Tracking - Pure Pursuit';

        case 'Stanley'
            title_name = 'Path Tracking - Stanley';

        case 'Kinematics MPC'
            title_name = 'Path Tracking - Kinematics MPC';

        case 'Dynamics MPC'
            title_name = 'Path Tracking - Dynamics MPC';

        otherwise
            title_name = 'Error - No Algorithm';
            disp('There is no this path tracking algorithm!');
    end
    