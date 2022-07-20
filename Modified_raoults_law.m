%Given Data taken from question of Temperature, x1experimental and y1experimental
T_given=[130.06,127.79,127.01,125.17,124.30,123.33,122.68,122.24,120.94,118.43,116.46,113.80,112.58,111.15,108.94,107.68,105.35,102.64,99.89,97.86,95.49,94.37,94.37,95.30,96.40,97.40,98.50,99.01,99.46];
x_1exp=[.0088,.0146,.0237,.0248,.0318,.0349,.0370,.0412,.0490,.0540,.0630,.0832,.0871,.1028,.1132,.1227,.1380,.1752,.2150,.2614,.3067,.3831,.9976,.9982,.9987,.9991,.9995,.9997,.9998];
y_1exp=[.0700,.1347,.1692,.2186,.2548,.2600,.2667,.2877,.3266,.3778,.4299,.4939,.5158,.5564,.5881,.6051,.6580,.6915,.7246,.7511,.8008,.8050,.8050,.8370,.8794,.9100,.9490,.9718,.9833];

%Varying x1 from 0 to 1 with a gap of 0.01 in order to get other variables
x_1=linspace(0,1,101);

%Given Data for the question
    A_1=8.07131;
    B_1=1730.630;
    C_1=233.426;
    A_2=8.46706;
    B_2=2174.869;
    C_2=257.780;
    A_12=1.2935;
    A_21=5.8737;
    a_1=5.536;
    b_1=0.03049;
    a_2=22.38;
    b_2=0.1388;
    R=0.0831441;

%Taking size of the variable array same as the size of x1 
    gamma_1=zeros(size(x_1));
    gamma_2=zeros(size(x_1));
    T=zeros(size(x_1));
    y_1=zeros(size(x_1));

%Iterations for finding different y_1(i) and Temperature
    for i=1:101
        gamma_1(i)=exp(A_12*(A_21*(1-x_1(i))/(A_12*x_1(i)+A_21*(1-x_1(i))))^2);
        gamma_2(i)=exp(A_21*(A_12*(1-x_1(i))/(A_12*x_1(i)+A_21*(1-x_1(i))))^2);
        f=@(T) 760-x_1(i)*gamma_1(i)*10^(A_1-(B_1/(T+C_1)))*exp((b_1-((a_1)/(R*(T+273))))*1/(R*(T+273))*(10^(A_1-(B_1/(T+C_1)))-760)*1/750)-(1-x_1(i))*gamma_2(i)*10^(A_2-(B_2/(T+C_2)))*exp((b_2-((a_2)/(R*(T+273))))*1/(R*(T+273))*(10^(A_2-(B_2/(T+C_2)))-760)*1/750);
        T(i)=fzero(f,0);
        y_1(i)=((x_1(i)*gamma_1(i)*10^(A_1-(B_1/(T(i)+C_1))))/760)*exp((b_1-((a_1)/(R*(T(i)+273))))*1/(R*(T(i)+273))*(10^(A_1-(B_1/(T(i)+C_1)))-760)*1/750);
    end
     
%A=[T ;x_1 ; y_1];
%for plotting graphs
     tiledlayout(1,2);
     nexttile;
     plot(x_1,y_1);axis square;    %x1 and y1 plot 
     hold on
     plot(x_1exp,y_1exp,'.');      %x1(experimental) and y1(experimental) plot
     hold off
     title('Y1-X1 PLOT')
     xlabel('x1-mole fraction in liquid phase') 
     ylabel('y1-mole fraction in gaseous phase') 
     legend({'y1-x1plot calculated','y1-x1 plot experimental(Given)'})
     nexttile;
     plot(x_1,T);axis square;      %x1 and T plot
     hold on
     plot(y_1,T);                  %y1 and T plot
     plot(x_1exp,T_given,'.');     %x1(experimental) and T(given) graph
     plot(y_1exp,T_given,'.');     %y1(experimental) and T(given) graph
     hold off
     title('T-x-y plot')
     xlabel('x1-y1') 
     ylabel('Temperature in Celsius') 
     legend({'T-x1 plot calculated','T-y1 plot calculated','T-x1 experimental','T-y1 experimental'})