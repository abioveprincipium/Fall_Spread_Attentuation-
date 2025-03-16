

Rp = 100; % Przykładowe natężenie opadów deszczu (mm/h)
D=30; %Przykładowa odległość pomiędzy antenami w km
freq_z = 100; % Przykładowa częstotliwość do znalezienia w GHz

Do=22.5;
d=3.8 - 0.6 * log(Rp);
c=0.026 - 0.03 * log(Rp);
b=2.3*power(Rp, -0.17);
u=(log(b*exp(c*d)))/d;

% Definicja częstotliwości w GHz
freq = [1,4,5,6,7.5,10,12.5,15,17.5,20,25,30,35,40,50,60,70,80,90,100]; 

% Wartości alpha i beta dla odpowiadających częstotliwości
alfa = [0.00015,0.00080,0.00138,0.00250,0.00482,0.0125,0.0228,0.0357,0.0524,0.0699,0.113,0.170,0.242,0.325,0.485,0.650,0.780,0.875,0.935,0.965];
beta = [0.95,1.17,1.24,1.28,1.25,1.18,1.142,1.12,1.105,1.10,1.09,1.075,1.04,0.99,0.90,0.84,0.79,0.753,0.730,0.715];

% Dla konkretnej częstotliwości, znajdowanie odpowiadające wartości alpha i beta

index = find(freq == freq_z);

if ~isempty(index)
    disp(['Wartość alpha dla częstotliwości ', num2str(freq_z), ': ', num2str(alfa(index))]);
    disp(['Wartość beta dla częstotliwości ', num2str(freq_z), ': ', num2str(beta(index))]);

    if (d<D)&&(D<Do)
        A_RPD = alfa(index)*power(Rp,beta(index))*((exp(u*beta(index)*d)-1)/(u*beta(index)))-((power(b,beta(index))*exp(c*beta(index)*d))/(c*beta(index)))+ ((power(b,beta(index))*exp(c*beta(index)*D))/(c*beta(index)));
    else
        A_RPD = alfa(index)*power(Rp,beta(index))*((exp(u*beta(index)*d)-1)/(u*beta(index)));
    end

else
    disp('Brak danych dla podanej częstotliwości.');
end

disp(['Tłumienie dla trasy Polski: ', num2str(A_RPD), ' dB']);

