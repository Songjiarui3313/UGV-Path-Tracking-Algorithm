function log = log_init(time_step, simulation_stop_time)
% log��ʼ��

% ���:
% log       : ��Ҫ��¼��log��Ϣ

% ����:
% time_step : ����ʱ�䲽��
% simulation_stop_time : ����ֹͣʱ��

log_size = simulation_stop_time / time_step;    %log��С

log.time = zeros(log_size, 1);      %����ʱ��log
log.steer_cmd = zeros(log_size, 1); %����ǰ��ƫ��log
log.veh_pose = zeros(log_size, 3);  %����λ��log
log.dist = zeros(log_size, 1);      %�������log

