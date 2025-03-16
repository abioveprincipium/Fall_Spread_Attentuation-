% Uwaga: Fragmenty dotyczące tras płaskich zostały zakomentowane, aby skrypt dotyczył wyłącznie ścieżek skośnych.

% Parametry wejściowe
Rp_z = 35;        % Przykładowe natężenie opadów deszczu (mm/h)
% D = 30;         % Stała wartość D dla ścieżek skośnych

freq_z = 10;      % Przykładowa częstotliwość do analizy w GHz
P_z = 0.001;      % Przykładowy procent opadów

theta = 35;       % Kąt, pod którym antena jest uniesiona względem horyzontu (stopnie)
Ho = 1;           % Punkt początkowy trasy nad poziomem morza (antena)
% Do = 22.5;        % Maksymalna odległość (km) - nieużywana w wersji dla ścieżek skośnych

% Dane opadów i parametrów środowiskowych:
Rp = [3,15,49,102];          % Przykładowe natężenie opadów deszczu (mm/h)
P  = [1,0.1,0.01,0.001];      % Procent wystąpienia deszczu
Hp = [1.3,2.7,3.4,4.6];       % Wysokość [km] nad poziomem morza, gdzie temperatura spada do 0°C

% Definicja częstotliwości w GHz
freq = [1,4,5,6,7.5,10,12.5,15,17.5,20,25,30,35,40,50,60,70,80,90,100];

% Wartości alfa i beta (współczynniki metody Crane'a) dla odpowiadających częstotliwości
alfa = [0.00015,0.00080,0.00138,0.00250,0.00482,0.0125,0.0228,0.0357,0.0524,0.0699,0.113,0.170,0.242,0.325,0.485,0.650,0.780,0.875,0.935,0.965];
beta = [0.95,1.17,1.24,1.28,1.25,1.18,1.142,1.12,1.105,1.10,1.09,1.075,1.04,0.99,0.90,0.84,0.79,0.753,0.730,0.715];

% Znalezienie indeksu dla zadanej częstotliwości:
index = find(freq == freq_z);
% Znalezienie najbliższych wartości opadów deszczu i procentu opadów:
[~, index2] = min(abs(Rp - Rp_z));
[~, index3] = min(abs(P - P_z));

if ~isempty(index)
    % Obliczenia pomocnicze wg metody Crane'a:
    d = 3.8 - 0.6 * log(Rp(index2));
    c = 0.026 - 0.03 * log(Rp(index2));
    b = 2.3 * power(Rp(index2), -0.17);
    u = (log(b * exp(c * d))) / d;

    % Dla ścieżek skośnych obliczamy efektywną odległość (D_slant) na podstawie różnicy wysokości i kąta nachylenia
    D_slant = (Hp(index3) - Ho) / tand(theta);  % [km]

    % -- Poniższy blok dotyczący tras płaskich został zakomentowany --
    %{
    if all(d < D & D < Do)
        A_RPD = alfa(index)*power(Rp(index2), beta(index)) * ((exp(u*beta(index)*d)-1)/(u*beta(index))) ...
                - ((power(b, beta(index)) * exp(c*beta(index)*d))/(c*beta(index))) ...
                + ((power(b, beta(index)) * exp(c*beta(index)*D))/(c*beta(index)));
        disp(['Tłumienie dla trasy płaskich Polski1: ', num2str(A_RPD), ' dB']);
    elseif all(D == 0 & theta == 90)
        A_RPD = (Hp(index3)-Ho)*alfa(index)*power(Rp(index2), beta(index));
        disp(['Tłumienie dla trasy płaskich Polski3: ', num2str(A_RPD), ' dB']);
    else
        A_RPD = alfa(index)*power(Rp(index2), beta(index)) * ((exp(u*beta(index)*d)-1)/(u*beta(index)));
        disp(['Tłumienie dla trasy płaskich Polski2: ', num2str(A_RPD), ' dB']);
    end
    %}

    % Dla ścieżek skośnych wykorzystujemy domyślną formułę (od gałęzi else) i przeliczamy tłumienie na trasę skośną.
    A_RPD = alfa(index) * power(Rp(index2), beta(index)) * ((exp(u * beta(index) * d) - 1) / (u * beta(index)));

    % Przeliczenie tłumienia dla ścieżki skośnej.
    % Stosujemy korektę: As = A_RPD / cosd(theta)
    As = A_RPD / cosd(theta);

    % Wyświetlenie wyników:
    disp(['Wartość alfa dla częstotliwości ', num2str(freq_z), ' GHz: ', num2str(alfa(index))]);
    disp(['Wartość beta dla częstotliwości ', num2str(freq_z), ' GHz: ', num2str(beta(index))]);
    disp(['Efektywna odległość dla ścieżki skośnej: ', num2str(D_slant), ' km']);
    disp(['Tłumienie dla ścieżek skośnych: ', num2str(As), ' dB']);
else
    disp('Brak danych dla podanej częstotliwości.');
end
