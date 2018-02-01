function [] = f_2(A,B,C,D,tau,Ampl)
     perem_sost_1 = 0
     perem_sost_2 = 0
     perem_sost_1n = 0
     perem_sost_2n = 0
     f_1=zeros(1,3*tau*100)
     x = linspace(0, 3*tau, 3*100*tau )
     y = linspace(0, 3*tau, 3*100*tau )
     i = 2;
     while i < 3*tau*100 do
        f_1(1,i)=Ampl*cos(%pi*x(i)/tau)*Heaviside(x(i))-Ampl*cos(%pi*x(i)/tau)*Heaviside(x(i)-tau)
        y(i)=(C(1)*perem_sost_1+C(2)*perem_sost_2+D(1)*f_1(1,i))
        perem_sost_1n = perem_sost_1 + 0.01*(A(1,1)*perem_sost_1+A(1,2)*perem_sost_2+B(1,1)*f_1(1,i-1))
        perem_sost_2n = perem_sost_2+0.01*(A(2,1)*perem_sost_1+A(2,2)*perem_sost_2+B(2,1)*f_1(1,i-1))
        perem_sost_1 = perem_sost_1n
        perem_sost_2 = perem_sost_2n
        i = i+1
     end
     figure()
     plot(x, f_1,x,y)
     title('Входной и выходной сигналы')
endfunction
