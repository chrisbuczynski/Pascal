{Program napisany w ramach zajęć na studiach matematematycznych - Wstęp do Informatyki}

{Badanie rozwiązań równania kwadratowego zmiennej rzeczywistej
w postaci ogólnej ax^2 + bx + c = 0}

var a,b,c,delta,x0,x1,x2:real;
begin
  write('Podaj wartosc wspolczynnika a: ');
  read(a);
  write('Podaj wartosc b: ');
  read(b);
  write('Podaj wartosc c: ');
  read(c);
  if a<>0 then
     delta:=b*b-4*a*c
  else
     writeln('Rownanie nie jest kwadratowe, bo a=0');
  if delta<0 then 
     writeln('Rownanie nie ma pierwiastkow rzeczywistych, bo delta < 0')
  else begin
         if delta=0 then begin
            x0:=(-b)/(2*a);
            writeln('Rownanie ma jeden (podwojny) pierwiastek rzeczywisty rowny: ', x0 :10:3);
         end
         else begin
            x1:=(-b)-(sqrt(delta))/(2*a);
            x2:=(-b)+(sqrt(delta))/(2*a);
            write ('Rownanie ma dwa pierwiastki rczeczywiste rowne: ');
            write(' ',x1 :10:3);
            write(' oraz: ', x2 :10:3);
         end
  end;
end.

{Krzysztof Buczyński}