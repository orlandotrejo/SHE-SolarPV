%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analisis Eliminacion Selectiva de Armonicos
% Dibuja una señal cuadrada modificando los angulos de disparo
% GSIEP - Julio 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modificar SOLO las primeras lineas comentadas

Fs = 100000;       % Frecuencia de muestreo
fa = 60;          % Frecuencia de la señal
N = 100;         % Periodos de la señal a ver
%Fse = 100;       % Frecuencia max para mostrar el espectro

a1 = 06.2565;
a2 = 18.6933;
a3 = 26.1450;
a4 = 47.1421;
a5 = 50.1944;

% a1 = 90;     % Angulo de Disparo 1 Rashid
% a2 = 90;     % Angulo de Disparo 2
% a3 = 90;     % Angulo de Disparo 3
% a4 = 90.00;     % Angulo de Disparo 4
% a5 = 90.00;     % Angulo de Disparo 5

Vmax = 1;       
Vmin = 0;       
Ts = 1/Fs;
LEN = fix(Fs/fa); 

Vo = zeros(fix(LEN/2),1);

for i=1:LEN/2

    if (i<LEN*a1/360)
        Vo(i)=Vmin;
    elseif (i<LEN*a2/360)
        Vo(i)=Vmax;
    elseif (i<LEN*a3/360)
        Vo(i)=Vmin;
    elseif (i<LEN*a4/360)
        Vo(i)=Vmax;
    elseif (i<LEN*a5/360)
        Vo(i)=Vmin;
    elseif (i<LEN*(180-a5)/360)
        Vo(i)=Vmax;
    elseif (i<LEN*(180-a4)/360)
        Vo(i)=Vmin;
    elseif (i<LEN*(180-a3)/360)
        Vo(i)=Vmax;    
    elseif (i<LEN*(180-a2)/360)
        Vo(i)=Vmin;
    elseif (i<LEN*(180-a1)/360)
        Vo(i)=Vmax;    
    else
        Vo(i)=Vmin;
    end

end

Vo2 = 1-Vo;
Voc = [Vo;Vo2];
Vodef = Voc;

for j=1:N-1
    Vodef=cat(1,Vodef,Voc);
end

Vodef = 2*(Vodef-0.5);

figure()  % Plot de la señal en tiempo
plot((1:N*(LEN))*Ts*fa*360,Vodef);

NFFT = 2^nextpow2(N*LEN); % Proxima Potencia de 2
Y = fft(Vodef,NFFT)/N/LEN;
f = Fs/2*linspace(0,1,NFFT/2+1);

Yo = 2*abs(Y(1:NFFT/2+1));
figure()    % Plot del espectro
plot(f(1:fix(length(f)/5)+1),Yo(1:fix(length(f)/5)+1))
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
