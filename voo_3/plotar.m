
clear all; 
close all;

dados = load('teste_voando_5.txt');

dt = 10/1000; %10ms - 100Hz
t = 0:dt:(length(dados)*dt)-dt;
angle_pitch = dados(:,1)'; % Posição em [cm]
angle_roll  = dados(:,2)'; %Aceleração em [int]
gyro_yaw = dados(:,3)';
CH1_raw = dados(:,4)';
CH2_raw = dados(:,5)';
CH3_raw = dados(:,6)';
CH4_raw = dados(:,7)';
altitude_z = dados(:,8)';
velocidade_z = dados(:,9)';

for i=1:length(dados) %Loop Criar
    if CH2_raw(i) > 1508
        CH2(i) = (CH2_raw(i) - 1508) / 15;
    elseif CH2_raw(i) < 1492
        CH2(i) = (CH2_raw(i) - 1492) / 15;
    else
        CH2(i) = 0;
    end
    
    if CH1_raw(i) > 1508
        CH1(i) = (CH1_raw(i) - 1508) / 15;
    elseif CH1_raw(i) < 1492
        CH1(i) = (CH1_raw(i) - 1492) / 15;
    else
        CH1(i) = 0;
    end
    
     if CH3_raw(i) > 1508
        CH3(i) = (CH3_raw(i) - 1508) / 15;
    elseif CH3_raw(i) < 1492
        CH3(i) = (CH3_raw(i) - 1492) / 15;
    else
        CH3(i) = 0;
    end
    
    if CH4_raw(i) > 1508
        CH4(i) = (CH4_raw(i) - 1508) / 15;
    elseif CH4_raw(i) < 1492
        CH4(i) = (CH4_raw(i) - 1492) / 15;
    else
        CH4(i) = 0;
    end
end

yaw = zeros(length(dados));

for i=2:length(dados) %
    yaw(i) = yaw(i-1) + gyro_yaw(i) * dt;
end
    
a=0;
b=t(end);
offset_roll = 0.0
offset_pitch = 0

figure;

subplot(2,1,1);
plot(t, CH2-offset_pitch,'--');
hold on;
plot(t, angle_pitch-offset_pitch);
axis([a b -15 15]);
grid on;
title('Resposta de Orientação (Exp. 3)');
ylabel('Orientação [°]');
legend('\theta_d = CH2 * \kappa_c','\theta (Arfagem)');

subplot(2,1,2);
plot(t,CH1 - offset_roll,'--');
hold on;
plot(t, angle_roll - offset_roll ); 
axis([a b -15 15]);
ylabel('Orientação [°]');
xlabel('Tempo [s]');
legend('\phi_d = CH1 * \kappa_c','\phi (Rolagem)');
grid on;

% figure;
% 
% subplot(2,1,1);
% plot(t,CH3, t, velocidade_z ); 
% axis([a b -50 100]);
% grid on;
% 
% subplot(2,1,2);
% plot(t,CH4, t, gyro_yaw ); 
% axis([a b -15 15]);
% grid on;
% 
