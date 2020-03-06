function [xc,yc,error]=RRR(xa,ya,xb,yb,lac,lbc,modo)
%Función para resolver la posición del punto C de la diada RRR
%
%Calcular lab
    lab=sqrt((xb-xa)^2+(yb-ya)^2);
%Casos a estudiar
    if lab<1e-8 && lac==lbc %Circunferencias identicas
        %Definir el error
            error=0;
        %Calcular la posición de C
            xc=xa+lac;
            yc=ya;
    elseif lab>=lac+lbc %Circunferencias demasiado alejadas
        %Calcular el error
            error=(lab-lac-lbc)/2;
        %Calcular el ángulo que forma AB con el semieje X
            theta=atan2(yb-ya,xb-xa);
        %Calcular la posición de C
            xc=xa+(lac+error)*cos(theta);
            yc=ya+(lac+error)*sin(theta);
    elseif lac>=lab+lbc %Circunferencia con centro en B en el interior de la circunferencia con centro en A
        %Calcular el error
            error=(lac-lab-lbc)/2;
        %Calcular el ángulo que forma AB con el semieje X
            theta=atan2(yb-ya,xb-xa);
        %Calcular la posición de C
            xc=xa+(lac-error)*cos(theta);
            yc=ya+(lac-error)*sin(theta);
    elseif lbc>=lab+lac %Circunferencia con centro en A en el interior de la circunferencia con centro en B
        %Calcular el error
            error=(lbc-lab-lac)/2;
        %Calcular el ángulo que forma AB con el semieje X
            theta=atan2(yb-ya,xb-xa);
        %Calcular la posición de C
            xc=xa+(lac+error)*cos(theta+pi);
            yc=ya+(lac+error)*sin(theta+pi);
    else %Circunferencias se cortan en dos puntos
        %Definir el error
            error=0;
        %Calcular el ángulo que forma AB con el semieje X
            theta=atan2(yb-ya,xb-xa);
        %Calcular el angulo entre la recta AC y la AB
            beta=acos(-((lbc.^2-lac.^2-lab.^2)./(2*lac.*lab)));
        %Calcular la posición y velocidad de C
            if modo==1
                %Calcular la posición
                    xc=xa+lac*cos(theta+beta);
                    yc=ya+lac*sin(theta+beta);
            elseif modo==2
                %Calcular la posición
                    xc=xa+lac*cos(theta-beta);
                    yc=ya+lac*sin(theta-beta);
            else
                xc=NaN;
                yc=NaN;
                error=NaN;
                disp('Unknown orientation');
            end
    end