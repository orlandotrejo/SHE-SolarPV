% Resolver las ecuaciones de SHE

% Valores iniciales:
m = 0.515; % Factor de Modulacion

a1=20*pi/180; a2=30*pi/180; a3=50*pi/180; a4=70*pi/180; a5=80*pi/180;
% a1=10*pi/180; a2=30*pi/180; a3=50*pi/180; a4=70*pi/180; a5=80*pi/180;
T = [(2+m*pi)/4 0.5 0.5 0.5 0.5]';

for i=1:100

F = [cos(1*a1)-cos(1*a2)+cos(1*a3)-cos(1*a4)+cos(1*a5);...
     cos(3*a1)-cos(3*a2)+cos(3*a3)-cos(3*a4)+cos(3*a5);...
     cos(5*a1)-cos(5*a2)+cos(5*a3)-cos(5*a4)+cos(5*a5);...
     cos(7*a1)-cos(7*a2)+cos(7*a3)-cos(7*a4)+cos(7*a5);...
     cos(9*a1)-cos(9*a2)+cos(9*a3)-cos(9*a4)+cos(9*a5)];
 
dF = [-1*sin(1*a1) 1*sin(1*a2) -1*sin(1*a3) 1*sin(1*a4) -1*sin(1*a5);...
      -3*sin(3*a1) 3*sin(3*a2) -3*sin(3*a3) 3*sin(3*a4) -3*sin(3*a5);...
      -5*sin(5*a1) 5*sin(5*a2) -5*sin(5*a3) 5*sin(5*a4) -5*sin(5*a5);...
      -7*sin(7*a1) 7*sin(7*a2) -7*sin(7*a3) 7*sin(7*a4) -7*sin(7*a5);...
      -9*sin(9*a1) 9*sin(9*a2) -9*sin(9*a3) 9*sin(9*a4) -9*sin(9*a5)];

dalpha = (inv(dF))*(T-F);

a1 = a1 + dalpha(1);
a2 = a2 + dalpha(2);
a3 = a3 + dalpha(3);
a4 = a4 + dalpha(4);
a5 = a5 + dalpha(5);

alpha = 180/pi*[a1;a2;a3;a4;a5]

if ((dalpha>(-1e-5)) & (dalpha<(1e-5)))
    break;
end

end

ao = 180/pi*[a1; a2; a3; a4; a5]
