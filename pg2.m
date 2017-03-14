%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analisis Eliminacion Selectiva de Armonicos
% Dibuja una señal cuadrada modificando los angulos de disparo
% GSIEP - Julio 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modificar SOLO las primeras lineas comentadas

Fs = 10000;       % Frecuencia de muestreo
fa = 60;          % Frecuencia de la señal
N = 60;         % Periodos de la señal a ver
%Fse = 100;       % Frecuencia max para mostrar el espectro

% a1 = 11.169924172563107;     % Angulo de Disparo 1 Mio 2
% a2 = 27.683362173690846;     % Angulo de Disparo 2
% a3 = 33.599973194424038;     % Angulo de Disparo 3
% a4 = 54.213083171476896;     % Angulo de Disparo 4
% a5 = 56.160000106032818;     % Angulo de Disparo 5

a1 = 12.170532507465893;     % Angulo de Disparo 1 mio DEF
a2 = 30.769930030487135;     % Angulo de Disparo 2
a3 = 36.875536946849422;     % Angulo de Disparo 3
a4 = 60.983108925136563;     % Angulo de Disparo 4
a5 = 62.643239796786368;     % Angulo de Disparo 5

% Prueba sin modulacion

% a1 = 90;     % Angulo de Disparo 1 Rashid
% a2 = 90;     % Angulo de Disparo 2
% a3 = 90;     % Angulo de Disparo 3
% a4 = 90.00;     % Angulo de Disparo 4
% a5 = 90.00;     % Angulo de Disparo 5

% Fin de prueba sin modulaci�n

Vmax = 1;       % Valor Maximo de Salida
Vmin = 0;       % Valor Minimo de Salida

Ts = 1/Fs;
LEN = fix(Fs/fa); 

Vo = zeros(LEN/2,1);

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

Vodef = (Vodef);

figure()  % Plot de la señal en tiempo
plot((1:N*LEN)*Ts*fa*360,Vodef);

NFFT = 2^nextpow2(N*LEN); % Proxima Potencia de 2
Y = fft(Vodef,NFFT)/N/LEN;
f = Fs/2*linspace(0,1,NFFT/2+1);

Yo = 2*abs(Y(1:NFFT/2+1));
figure()    % Plot del espectro
plot(f(1:fix(length(f)/5)+1),Yo(1:fix(length(f)/5)+1))
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
