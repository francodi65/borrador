valores= 100000;
x=randsrc(1,valores,[-3 -1 1 3]);

noise= randn(1,valores);
SNRdb= 0:1:9;
SNR = 10.^(SNRdb/10);
desvio=1./sqrt(2*SNR);

for i=1:length(desvio)
    N0(i,:)= noise*desvio(i);
    y(i,:)= x+N0(i,:);
end

errores= zeros(length(desvio),1);

for i=1:length(desvio)
    for j=1:length(x)
        if y(i,j)<-2;
            y(i,j)=-3;
        end
        if (y(i,j)>-2 && y(i,j)<0);
            y(i,j)=-1;
        end
        if (y(i,j)>0 && y(i,j)<2);
            y(i,j)=1;
        end
        if y(i,j)>2;
            y(i,j)=3;
        end
        if (y(i,j)~=x(j));
            errores(i,1)= errores(i,1)+1;
        end
    end
    Pe(i)= errores(i)/length(x);
end
figure
semilogy(SNRdb,Pe,'b:o');
hold on
semilogy(SNRdb,0.75*erfc(sqrt(SNR)),'k');
grid on
title('Curva SER')
xlabel('SNR dB')
ylabel('Probabilidad de error')




    