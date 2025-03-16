% Dane wejściowe
freq_z = 10; % Przykładowa częstotliwość do znalezienia w GHz
theta = 35; % kąt pod który antena jest uniesiona względem horyzontu.
Ho = 1; % punkt początkowy trasy nad poziomem morza (antena)
Do = 22.5;

% Definicja opadów deszczu w mm/h dla odpowiednich częstotliwości
P = [1, 0.1, 0.01, 0.001];

% Definicja opadów deszczu dla odpowiadających Rp
Rp = [3, 15, 49, 102]; % Przykładowe natężenie opadów deszczu (mm/h)

% Szukanie indeksu dla częstotliwości freq_z
index = find(freq == freq_z);

if ~isempty(index)
    % Pobieranie wartości alfa i beta dla częstotliwości freq_z
    alfa_z = alfa(index);
    beta_z = beta(index);

    % Inicjalizowanie tablicy na wartości tłumienia dla różnych P
    A_RPD = zeros(size(P));

    for i = 1:length(P)
        % Szukanie odpowiedniej wartości Rp dla aktualnego P
        [~, index_Rp] = min(abs(P - P(i)));

        % Obliczam d, c, b, u
        d = 3.8 - 0.6 * log(Rp(index_Rp));
        c = 0.026 - 0.03 * log(Rp(index_Rp));
        b = 2.3 * power(Rp(index_Rp), -0.17);
        u = (log(b * exp(c * d))) / d;

        % Obliczanie tłumienia A_RPD dla aktualnego P i częstotliwości freq_z
        if all(d < D & D < Do)
            A_RPD(i) = alfa_z * power(Rp(index_Rp), beta_z) * ((exp(u * beta_z * d) - 1) / (u * beta_z)) - ((power(b, beta_z) * exp(c * beta_z * d)) / (c * beta_z)) + ((power(b, beta_z) * exp(c * beta_z * D)) / (c * beta_z));
        elseif d > D
            A_RPD(i) = alfa_z * power(Rp(index_Rp), beta_z) * ((exp(u * beta_z * d) - 1) / (u * beta_z));
        elseif all(D == 0 & theta == 90)
            A_RPD(i) = (Hp(index_Rp) - Ho) * alfa_z * power(Rp(index_Rp), beta_z);
        end
    end

    % Wygenerowanie wykresu
    semilogx(P, A_RPD, 'LineWidth', 2);
    xlabel('Natężenie opadów deszczu (%)');
    ylabel('Tłumienie A(dB)');
    title(['Wykres tłumienia dla f=10Ghz i zmiennych opadow ']);
    grid on;
else
    disp('Brak danych dla podanej częstotliwości.');
end
