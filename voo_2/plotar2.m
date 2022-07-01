
clear all; 
close all;

dados = load('teste_voando_4.txt');

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
        CH3(i) = (CH3_raw(i) - 1500) / 15;
    elseif CH3_raw(i) < 1492
        CH3(i) = (CH3_raw(i) - 1500) /50;
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

figure;
subplot(4,1,1);
plot(t, CH2, t,angle_pitch);
axis([0 t(end) -20 20]);
grid on;

subplot(4,1,2);
plot(t,CH1,t,angle_roll); 
axis([0 t(end) -20 20]);
grid on;

subplot(4,1,3);
plot(t,CH3, t, altitude_z, t, velocidade_z ); 
%legend('ch3', 'altitude', 'velocidade')
axis([0 t(end) -10 100]);
grid on;


subplot(4,1,4);
plot(t,CH4, t, gyro_yaw ); 
axis([0 t(end) -20 20]);
grid on;

