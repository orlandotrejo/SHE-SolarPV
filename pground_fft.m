% Sandbox para graficar el espectro armonico de una señal usando FFT
% ENTRADAS: Señales a graficar en frecuencia x o z en este ejemplo
% SALIDAS: Gráfico de la FFT

Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = 1000;                     % Length of signal
t = (0:L-1)*T;                % Time vector

x = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t); 
y = x;
% z = 0.5 + 0.5*square(2*pi*50*t);
% y = z;

NFFT = 2^nextpow2(L); 
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
