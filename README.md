# Obliczanie tłumienia sygnału spowodowanego opadami deszczu na podstawie metody Crane'a

## Wprowadzenie
Projekt prezentuje obliczenia tłumienia sygnału mikrofalowego (1GHz — 10 GHz) wywołanego opadami deszczu, przeprowadzone na podstawie metody Crane'a. Wyniki obliczeń i generowane wykresy ilustrują, jak tłumienność zmienia się w zależności od intensywności opadów oraz innych parametrów, przyjmując rozkład opadów typowy dla północnej części Polski. Metoda Crane'a wykorzystuje empiryczny wzór:

*γ_R = k · R^α*



gdzie:
- *γ_R* – specyficzna tłumienność (w dB/km),
- *R* – intensywność opadów (w mm/h),
- *k* oraz *α* – współczynniki zależne od częstotliwości i polaryzacji sygnału.

Całkowitą tłumienność na trasie o długości *L* km uzyskuje się jako:

*A_R = γ_R · L*

## Instrukcje środowiska (MATLAB)
Aby uruchomić projekt w MATLAB:
1. Upewnij się, że masz zainstalowanego MATLABa (wersja R2018b lub nowsza).
2. Skopiuj wszystkie pliki projektu do jednego folderu.
3. Uruchom MATLABa i ustaw folder projektu jako bieżący katalog roboczy.
4. Uruchom wybrany skrypt
 
Wyniki obliczeń oraz wykresy pojawią się w oknie MATLABa.
## Opis plików
1. **wykresy_const_fallspread.m**:
- **Cel:** Generowanie wykresu tłumienności w zależności od częstotliwości przy stałych warunkach opadów.
- **Opis**: Skrypt oblicza wartości tłumienności wg metody Crane'a dla zadanych parametrów (np. intensywność opadów, odległość między antenami) i generuje wykres zależności *A_R* od częstotliwości.
2. **wykresy_const_freq.m**
- **Cel:** Generowanie wykresu tłumienności w funkcji intensywności opadów dla konkretnej częstotliwości.
- **Opis:** Skrypt iteruje po wartościach opadów deszczu, oblicza tłumienność dla ustalonej częstotliwości i przedstawia wyniki na wykresie, ukazując zmiany tłumienności w szerokim zakresie opadów.
3. **flat_path.m**
- **Cel:** Obliczanie tłumienności dla tras propagacji naziemnej po ścieżce płaskiej.
- **Opis:** Skrypt stosuje parametry typowe dla propagacji naziemnej, gdzie na podstawie ustalonych wartości natężenia opadów, odległości między antenami oraz częstotliwości, obliczana jest całkowita tłumienność *A_R*. Wyniki są wyświetlane w konsoli MATLABa.
4. **slant_path.m**
- **Cel:** Obliczanie tłumienności dla ścieżek skośnych (propagacja nachylona).
- **Opis:** Skrypt został zmodyfikowany tak, aby dotyczył wyłącznie tras skośnych. Uwzględnia on kąt uniesienia anteny *θ* i oblicza efektywną odledłość *D_slant* według wzoru:

*D_slant = (Hp - Ho) / tan(θ)*

Tłumienie dla ścieżek skośnych *A_s* oblicza się poprzez korektę tłumienia tras płaskich:

*A_S = A_RPD / cos(θ)*

Gdzie *A_RPD* jest tłumieniem obliczonym wg metody Crane'a dla tras płaskich.


## Legenda zmiennych
- **Rp**: Natężenie opadów deszczu [mm/h]. 
- **P**: Procentowe wystąpienie deszczu (prawdopodobieństwo opadów).
- **Hp**: Wysokość [km] nad poziomem morza, przy której temperatura spada do 0°C (dla Polski, przy szerokości 52°N).
- **D**: Odległość pomiędzy antenami (trasą transmisji) [km].
- **Do**: Maksymalna odległość lub wartość graniczna używana w niektórych obliczeniach [km].
- **freq**: Częstotliwość sygnału [GHz].
- **alfa**, **beta**: Współczynniki metody Crane'a, zależne od częstotliwości i polaryzacji.
- **theta**: Kąt uniesienia anteny względem horyzontu (w stopniach).
- **Ho**: Wysokość początkowa (antena) nad poziomem morza.
- **D_slant**: Efektywna odległość dla ścieżek skośnych.
## Licencja
Projekt jest udostępniany do użytku niekomercyjnego. Oznacza to, że możesz swobodnie przeglądać kod, jednak nie wolno wykorzystywać go w celach komercyjnych bez uzyskania odpowiedniej zgody.

## Kontakt
W przypadku pytań lub sugestii dotyczących projektu, proszę o kontakt poprzez zgłoszenia (issues) na GitHub.
