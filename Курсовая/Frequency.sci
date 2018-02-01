function [] = Frequency(Hs,tau,Amp)
    //S = jw
    //Исследуемый отрезок частот
    w = linspace(0,4,100);
    Values = freq(numer(Hs), denom(Hs), %i*w);
    
    //АЧХ
    A = sqrt(real(Values)^2 + imag(Values)^2);
    figure()
    plot2d(w, A);

    //Находим полосу пропускания цепи
    Level = 0.707*1;
    xpts = [0 10];
    ypts = [Level Level];
    title('АЧХ и полоса пропускания')
    plot2d(xpts, ypts,5);
    
    //ФЧХ
    for i = 1:100
        if real(Values(i)) > 0
            Fr(i) = atan(imag(Values(i))/real(Values(i)));
        else
            if imag(Values(i)) >= 0
                Fr(i) = atan(imag(Values(i))/real(Values(i))) + %pi;    
            else
                Fr(i) = atan(imag(Values(i))/real(Values(i))) - %pi;
            end
        end
    end
    figure()
    title('ФЧХ')
    plot2d(w, Fr);
    figure()
    max = 0;
    //Нахождение и построение амплитудных спектров входного и выходного сигналов
    //Амплитудные спектры
    y = linspace(0,4, 100)
    y_fr = linspace(0,4,100)
    //w = linspace(0,4,100)
    max1 = 0;
    for j = 1:100
        F1 = (1-exp(-tau*%i*w(j)))*Amp*%i*w(j)/((%i*w(j))^2+(%pi/tau)^2)
        y(j) = abs(F1)
        y_fr(j) = atan(imag(F1)/real(F1))
        if max1 < y(j)
            max1 = y(j)
        end
        //j = j + 1
    end
    max2 = linspace(0.1*max1,0.1*max1,100)
    plot2d(w,y)
    plot2d(w,max2)
    title('Амплитудный спектр входного сигнала')
    figure()
    plot(w, y.*A)
    title('Амплитудный спектр выходного сигнала')
    //Фазовые спектры
    //for j = 1:100
      //  F1 = (1-exp(-tau*%i*w(j)))*Amp*%i*w(j)/((%i*w(j))^2+(%pi/tau)^2)
        //y_fr(j) = atan(imag(F1)/real(F1))
        //j = j + 1
    //end
    figure()
    plot2d(w,y_fr);
    title('Фазовый спектр входного сигнала')
    figure()
    
    plot(w, y_fr'+Fr)
    title('Фазовый спектр выходного сигнала')
endfunction
