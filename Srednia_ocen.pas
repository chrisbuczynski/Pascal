{Program napisany w ramach zajęć na studiach matematematycznych - Wstęp do Informatyki}

{Oblicza średnią arytmetyczną z podanych stopni 1,2,3,4,5,6.}

var
  ilosc_ocen, i, suma, ocena: integer;
  srednia: real;
  poprawna: boolean;

begin
  writeln('Podaj ilosc ocen:');
  readln(ilosc_ocen);
  
  suma := 0;

  writeln('Podaj ', ilosc_ocen, ' ocen:');
  for i := 1 to ilosc_ocen do
  begin
    repeat
      readln(ocena);
      // Sprawdź czy ocena mieści się w zakresie od 1 do 6
      poprawna := (ocena >= 1) and (ocena <= 6);
      if not poprawna then
        writeln('Podana ocena jest nieprawidlowa. Stopien to 1,2,3,4,5 albo 6. Wprowadz ocene ponownie:');
    until poprawna;
    suma := suma + ocena;
  end;
  
  srednia := suma / ilosc_ocen;
  
  writeln('Srednia arytmetyczna podanych ocen wynosi: ', srednia:0:2);
end.

{Krzysztof Buczyński}