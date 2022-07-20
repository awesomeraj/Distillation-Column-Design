Xf = input('Mole fraction of more volatile compound in feed= ');
Xd = input('Mole fraction of more volatile compound in distilate= ');
Xw = input('Mole fraction of more volatile compound in bottom= ');
R = input('Reflux ratio = ');
a = input('Relative volatility = ');
x = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
y = x;
plot(x,y);
hold on;
xlabel('Mole fraction of more volatile liquid');
ylabel('Mole fraction of less volatile vapour');
x1=linspace(0,1) ;
y1=(a*x1)./(1+(a-1)*x1) ;
plot(x1, y1);
hold on;
plot([0 Xd],[Xd/(R+1) Xd]);
hold on;
plot([Xd,Xd],[Xd,0]);
hold on;
plot([Xf,Xf],[1,0]);
hold on;
plot([Xw,Xw],[Xw,0]);
hold on;
c = Xd/(R+1);
syms X Y
eq1 = (Xd-c)*X - Xd*Y + c*Xd == 0;
eq2 = X == Xf;
sol = solve([eq1, eq2], [X, Y]);
xSol = sol.X;
ySol = sol.Y;
hold on;
plot([Xw xSol],[Xw ySol]);
hold on;
ax = zeros(1,1) ;
ay = zeros(1,1) ;
ax(1) = Xd;
ay(1) = Xd;
i=2;
while ax(i-1)>Xw
    if (mod(i,2)==0)
        ay(i) = ay(i-1) ;
        ax(i) = ay(i) / (a + (1-a)*ay(i));
        i = i+1;
    elseif mod(i,2)~=0
        ax(i) = ax(i-1) ;
        if ax(i) >= Xf
           ay(i) = ((Xd-c)*ax(i) + c*Xd) / Xd  ;
        else 
            ay(i) = (ax(i)*(ySol-Xw)-Xw*ySol + Xw*xSol)/(xSol-Xw);
        end
        i = i+1;
    end
end
fprintf('No. of plates = %d',(i-1) /2);
plot(ax,ay);
hold on;
plot([ax(i-1) ax(i-1)], [ay(i-1) 0]);
y3 = (a*Xf) / (1+(a-1)*Xf) ;

m = (Xd-y3) / (Xd - Xf);

fprintf('Minimum reflux ratio =%d',m/(1-m));