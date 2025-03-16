% Dane wejściowe
Rp_z = 35; % Przykładowe natężenie opadów deszczu (mm/h)
D = 10; % Przykładowa odległość pomiędzy antenami w km
theta = 35; % kąt pod który antena jest uniesiona względem horyzontu.
Ho = 1; % punkt początkowy trasy nad poziomem morza (antena)
Do = 22.5;

% Definicja częstotliwości w GHz
freq = [1,4,5,6,7.5,10,12.5,15,17.5,20,25,30,35,40,50,60,70,80,90,100]; 

% Wartości alfa i beta dla odpowiadających częstotliwości
alfa = [0.00015,0.00080,0.00138,0.00250,0.00482,0.0125,0.0228,0.0357,0.0524,0.0699,0.113,0.170,0.242,0.325,0.485,0.650,0.780,0.875,0.935,0.965];
beta = [0.95,1.17,1.24,1.28,1.25,1.18,1.142,1.12,1.105,1.10,1.09,1.075,1.04,0.99,0.90,0.84,0.79,0.753,0.730,0.715];

% Definicja opadów deszczu w mm/h dla odpowiednich częstotliwości
P = [1,0.1,0.01,0.001];

% Wygenerowanie krzywej tłumienia dla jednej drogi i zmiennej częstotliwości
A_RPD = zeros(size(freq)); % Inicjalizacja tablicy na wartości tłumienia

% Znalezienie najbliższej wartości opadów deszczu
[~, index2] = min(abs(Rp_z - 3)); % Zakładając Rp = 3

for i = 1:length(freq)
    if ~isempty(index2)
        d = 3.8 - 0.6 * log(Rp_z);
        c = 0.026 - 0.03 * log(Rp_z);
        b = 2.3 * power(Rp_z, -0.17);
        u = (log(b * exp(c * d))) / d;

        if all(d < D & D < Do)
            A_RPD(i) = alfa(i) * power(Rp_z, beta(i)) * ((exp(u * beta(i) * d) - 1) / (u * beta(i))) - ((power(b, beta(i)) * exp(c * beta(i) * d)) / (c * beta(i))) + ((power(b, beta(i)) * exp(c * beta(i) * D)) / (c * beta(i)));
        elseif d > D
            A_RPD(i) = alfa(i) * power(Rp_z, beta(i)) * ((exp(u * beta(i) * d) - 1) / (u * beta(i)));
        elseif all(D == 0 & theta == 90)
            A_RPD(i) = (Hp(index3) - Ho) * alfa(i) * power(Rp_z, beta(i));
        end
    end
end

% Wygenerowanie wykresu
plot(freq, A_RPD, 'LineWidth', 2);
xlabel('Częstotliwość (GHz)');
ylabel('Tłumienie A(dB)');
title('Wykres tłumienia dla D=10km i roznej częstotliwości');
grid on;
