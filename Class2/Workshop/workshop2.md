### Workshop #2

# StreetView App

### Opis zadania

Celem zadania jest stworzenie aplikacji **CityScroller**. Aplikacja składa się z jednego ekranu, który cały zawiera `UIScrollView`. Wewnątrz ScrollView pojawiają się obok siebie losowe budynki.

W górnej części ekranu znajduje się *Księżyc* (analogiczny do kółka z poprzedniego zadania). Księżyc jest subview ScrollView, ale nie przewija się razem z nim (zostaje w jednym miejscu na ekranie) poziomo. W pionie przewija się normalnie (lub dla chętnych: z paralaksą). Księżyc można przestawiać, tak samo jak kropki w poprzednim zadaniu. Po przestawieniu, Księżyc przyczepia się do nowej pozycji i zostaje tam w czasie scrollowania.

ScrollView przewija się w pionie na wysokość najwyższego możliwego budynku (klasa `BuildingView` dostarcza taką informację), a w poziomie przewija się w nieskończoność. Nowe budynki są **doładowywane** w czasie scrollowania i **wyrzucane** kiedy znikają z ekranu.

### Wskazówki

1. Klasę `BuildingView` i inne przydatne narzędzia znajdziesz [tutaj](Assets).
2. Nie robimy mechanizmu dequeue w ramach tego zadania – nasza ulica będzie na tyle nieintuicyjna że wrócenie w to samo miejsce nie gwarantuje spotkania tego samego budynku 😉
3. Do zrobienia zachowania księżyca możesz użyć dokładnie takiego samego mechanizmu jak w poprzednim zadaniu do tworzenia przesuwalnych kółek.
4. Nie próbuj używać AutoLayoutu do tego typu zadań 😵

### Odpowiedzi

Odpowiedź (cały, spakowany w .zip folder projektu) wyślij mailem na adres [email](mailto:michal.dabrowski+workshop2@daftcode.pl) do końca najbliższej soboty: **31.03.2018, 23:59**.

Przypominam, że jest możliwość wykonania zadania w salce na MiMUW. Terminy to **czwartki w godzinach 10:00 - 16:00** oraz **piątki po 16:00**. Przyjdźcie w jednym z tych terminów – administratorzy uruchomią Wam system i będziecie mogli wykonać zadanie.
