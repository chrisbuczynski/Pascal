{Program napisany w ramach zajêæ na studiach matematematycznych - Wstêp do Informatyki}

{OPIS PROJEKTU: Napisa³em program Snake jako czêœæ æwiczeñ laboratoryjnych na przedmiocie podstaw informatyki podczas moich studiów. 
Tworzenie tego programu umo¿liwi³o mi praktyczne zastosowanie poznanych koncepcji programowania oraz zdobycie umiejêtnoœci w obszarze algorytmów i struktur danych. 
Projekt ten pozwoli³ mi równie¿ lepiej zrozumieæ proces tworzenia gier komputerowych i zastosowanie podstawowych technik programistycznych w praktyce.}



program snake;
uses wincrt,graph;
var i,j,k,t,xw,yw,dw,jedzonko_x,jedzonko_y,ile_x,ile_y,punkty:integer;
    jedzonko:array[1..2,1..30] of integer;
    bonus:array[1..2,1..5] of integer;
    z,o:char;
    waz:array[1..2,1..31] of integer;
    wylosowac:boolean;
    s:string;

BEGIN

  Writeln('Witaj w grze snake. Oto kilka zasad: ');
  writeln;
  writeln('1. Zbieraj wezem male, niebieskie kwadraciki(jedzonko), ktore dadza ci punkty (po 1) oraz wyd³uza wêza o jeden.');
  writeln;
  writeln('2. Zbieraj wezem male, roznokolorowe kwadraciki (bonusy), ktore dadza ci punkty (po 10, 20, 30, 40 odpowiednio w rundach 1, 2, 3, 4) oraz skroca weza o jeden.');
  writeln;
  Writeln('3. Uwazaj na kolizje ze scianami oraz na "samougryzienie" sie przez weza. Kolizja taka skutkuje porazka i zamknieciem gry.');
  writeln;
  Writeln('4. Do nastepnej rundy przechodzisz, gdy dlugosc twojego weza przekroczy 25.');
  writeln;
  writeln('5. Po zjedzeniu kazdego "jedzonka" waz przyspiesza. Przyspieszenie zalezy tez od rundy i w czwartej jest najwieksze.');
  writeln;
  Writeln('6. Sterowanei: a-lewo, d-prawo, s-dol, w-gora, x-wyjscie z gry.');


  detectgraph(k,t);
  initgraph(k,t,'');
  setbkcolor(WHITE);

                                                    //    RUNDA 1
  cleardevice;
  setcolor(BLUE);
  outtextxy(30,10,'Punkty: 0');
  outtextxy(130,10,'Runda: 1');
  setfillstyle(1,Brown);
  ile_x:=getmaxx div 20;
  ile_y:=getmaxy div 20;
  for i:=0 to ile_x-1 do begin
    bar(20*i,40,20*i+20,60);
    bar(20*i,ile_y*20-20,20*i+20,ile_y*20);
  end;
  for i:=1 to ile_y-4 do begin
    bar(0,i*20+40,20,i*20+60);
    bar(ile_x*20-20,40+i*20,ile_x*20,20*i+60);
  end;


  setfillstyle(9,Blue);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do 
    if ((jedzonko[1][i]=jedzonko_x) and (jedzonko[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      jedzonko[1][i]:=jedzonko_x;
      jedzonko[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=30);

  setfillstyle(5,red);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do 
    if ((bonus[1][i]=jedzonko_x) and (bonus[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      bonus[1][i]:=jedzonko_x;
      bonus[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=5);


  punkty:=0;
  dw:=1;
  xw:=20*((getmaxx div 20) div 2);
  yw:=20*((getmaxy div 20) div 2);
  waz[1][1]:=xw;
  waz[2][1]:=yw;

repeat
        if keypressed then z:=readkey;
        case z of
             'w':begin
               yw:=yw-20;
               o:=z;
             end;
             'a':begin
               xw:=xw-20;
               o:=z
             end;
             's':begin
               yw:=yw+20;
               o:=z;
             end;
             'd':begin
               xw:=xw+20;
               o:=z;
             end;
end;



if ((z<>'w') and (z<>'a') and (z<>'s') and(z<>'d') and (z<>'x')) then z:=o;
             
        setfillstyle(1,WHITE);
        bar(waz[1][dw],waz[2][dw],waz[1][dw]+20,waz[2][dw]+20);
        setfillstyle(1,GREEN);

        for i:=dw downto 2 do begin
          waz[1][i]:=waz[1][i-1];
          waz[2][i]:=waz[2][i-1];
        end;

        waz[1][1]:=xw;
        waz[2][1]:=yw;

        for i:=1 to dw do
            bar(waz[1][i],waz[2][i],waz[1][i]+20,waz[2][i]+20);
        
          for i:=1 to 30 do begin
          if (waz[1][1]=jedzonko[1][i]) and (waz[2][1]=jedzonko[2][i]) then begin
          dw:=dw+1;
          punkty:=punkty+1;
          jedzonko[1][i]:=-1;
          jedzonko[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);

          end;
          end;
          
          for i:=1 to 5 do begin
          if (waz[1][1]=bonus[1][i]) and (waz[2][1]=bonus[2][i]) then begin
          if dw>1 then dw:=dw-1;
          punkty:=punkty+10;
          bonus[1][i]:=-1;
          bonus[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);
          end;
          end;

            ile_x:=getmaxx div 20;
            ile_y:=getmaxy div 20;
          if((xw<20) or (xw>= ile_x*20-20) or (yw<60) or (yw>= ile_y*20-20)) then z:='x';
          
          for i:=2 to dw do
              if((waz[1][1]=waz[1][i]) and (waz[2][1]=waz[2][i])) then z:='x';
              
              if z='x' then closegraph;

delay(100 - i);

                                                   //    RUNDA 2
until (dw>25);

  cleardevice;
  setcolor(BLUE);
  outtextxy(30,10,'Punkty: 80');
  outtextxy(130,10,'Runda: 2');
  setfillstyle(1,Brown);
  ile_x:=getmaxx div 20;
  ile_y:=getmaxy div 20;
  for i:=0 to ile_x-1 do begin
    bar(20*i,40,20*i+20,60);
    bar(20*i,ile_y*20-20,20*i+20,ile_y*20);
  end;
  for i:=1 to ile_y-4 do begin
    bar(0,i*20+40,20,i*20+60);
    bar(ile_x*20-20,40+i*20,ile_x*20,20*i+60);
  end;
  bar(600,120,620,600);



  setfillstyle(9,BLUE);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do
    if ((jedzonko[1][i]=jedzonko_x) and (jedzonko[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      jedzonko[1][i]:=jedzonko_x;
      jedzonko[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=30);
  
  setfillstyle(6,brown);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do 
    if ((bonus[1][i]=jedzonko_x) and (bonus[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      bonus[1][i]:=jedzonko_x;
      bonus[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=5);
  
  punkty:=80;
  dw:=1;
  xw:=20*((getmaxx div 20-35) div 2);
  yw:=20*((getmaxy div 20-15) div 2);
  waz[1][1]:=xw;
  waz[2][1]:=yw;

 repeat
        if keypressed then z:=readkey;
        case z of
             'w':begin
               yw:=yw-20;
               o:=z;
             end;
             'a':begin
               xw:=xw-20;
               o:=z
             end;
             's':begin
               yw:=yw+20;
               o:=z;
             end;
             'd':begin
               xw:=xw+20;
               o:=z;
             end;
end;



if ((z<>'w') and (z<>'a') and (z<>'s') and(z<>'d') and (z<>'x')) then z:=o;
             
        setfillstyle(1,WHITE);
        bar(waz[1][dw],waz[2][dw],waz[1][dw]+20,waz[2][dw]+20);
        setfillstyle(1,GREEN);

        for i:=dw downto 2 do begin
          waz[1][i]:=waz[1][i-1];
          waz[2][i]:=waz[2][i-1];
        end;

        waz[1][1]:=xw;
        waz[2][1]:=yw;

        for i:=1 to dw do
            bar(waz[1][i],waz[2][i],waz[1][i]+20,waz[2][i]+20);
        
          for i:=1 to 30 do begin
          if (waz[1][1]=jedzonko[1][i]) and (waz[2][1]=jedzonko[2][i]) then begin
          dw:=dw+1;
          punkty:=punkty+1;
          jedzonko[1][i]:=-1;
          jedzonko[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);

          end;
          end;
          
          for i:=1 to 5 do begin
          if (waz[1][1]=bonus[1][i]) and (waz[2][1]=bonus[2][i]) then begin
          if dw>1 then dw:=dw-1;
          punkty:=punkty+20;
          bonus[1][i]:=-1;
          bonus[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);
                                                     
          end;
          end;

          ile_x:=getmaxx div 20;
          ile_y:=getmaxy div 20;
          if((xw<20) or (xw>= ile_x*20-20) or (yw<60) or (yw>= ile_y*20-20)) then z:='x';

          if ((xw>=600) and (xw<=610) and (yw>=120) and (yw<=590))
          then z:='x';

          for i:=2 to dw do
              if((waz[1][1]=waz[1][i]) and (waz[2][1]=waz[2][i])) then z:='x';
              
              if z='x' then closegraph;

delay(100 - 2*(i-1));

until(dw>25);                                                //    RUNDA 3

  cleardevice;
  setcolor(BLUE);
  outtextxy(30,10,'Punkty: 210');
  outtextxy(130,10,'Runda: 3');
  setfillstyle(1,Brown);
  ile_x:=getmaxx div 20;
  ile_y:=getmaxy div 20;
  for i:=0 to ile_x -1 do begin
    bar(20*i,40,20*i+20,60);
    bar(20*i,ile_y*20-20,20*i+20,ile_y*20);
  end;
  for i:=1 to ile_y-4 do begin
    bar(0,i*20+40,20,i*20+60);
    bar(ile_x*20-20,40+i*20,ile_x*20,20*i+60);
  end;
  bar(600,100,620,640);
  bar(200,400,1000,420);

  setfillstyle(9,BLUE);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do 
    if ((jedzonko[1][i]=jedzonko_x) and (jedzonko[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      jedzonko[1][i]:=jedzonko_x;
      jedzonko[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=30);

  setfillstyle(1,yellow);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do 
    if ((bonus[1][i]=jedzonko_x) and (bonus[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      bonus[1][i]:=jedzonko_x;
      bonus[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=5);


  punkty:=210;
  dw:=1;
  xw:=20*((getmaxx div 20-35) div 2);
  yw:=20*((getmaxy div 20-15) div 2);
  waz[1][1]:=xw;
  waz[2][1]:=yw;

 repeat
        if keypressed then z:=readkey;
        case z of
             'w':begin
               yw:=yw-20;
               o:=z;
             end;
             'a':begin
               xw:=xw-20;
               o:=z
             end;
             's':begin
               yw:=yw+20;
               o:=z;
             end;
             'd':begin
               xw:=xw+20;
               o:=z;
             end;
end;



if ((z<>'w') and (z<>'a') and (z<>'s') and(z<>'d') and (z<>'x')) then z:=o;
             
        setfillstyle(1,WHITE);
        bar(waz[1][dw],waz[2][dw],waz[1][dw]+20,waz[2][dw]+20);
        setfillstyle(1,GREEN);

        for i:=dw downto 2 do begin
          waz[1][i]:=waz[1][i-1];
          waz[2][i]:=waz[2][i-1];
        end;

        waz[1][1]:=xw;
        waz[2][1]:=yw;

        for i:=1 to dw do
            bar(waz[1][i],waz[2][i],waz[1][i]+20,waz[2][i]+20);
        
          for i:=1 to 30 do begin
          if (waz[1][1]=jedzonko[1][i]) and (waz[2][1]=jedzonko[2][i]) then begin
          dw:=dw+1;
          punkty:=punkty+1;
          jedzonko[1][i]:=-1;
          jedzonko[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);

          end;
          end;
          
          for i:=1 to 5 do begin
          if (waz[1][1]=bonus[1][i]) and (waz[2][1]=bonus[2][i]) then begin
          if dw>1 then dw:=dw-1;
          punkty:=punkty+30;
          bonus[1][i]:=-1;
          bonus[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);

          end;
          end;

          ile_x:=getmaxx div 20;
          ile_y:=getmaxy div 20;
          if((xw<20) or (xw>= ile_x*20-20) or (yw<60) or (yw>= ile_y*20-20)) then z:='x';

          
          if ((xw>=600) and (xw<=610) and (yw>=100) and (yw<640))  then z:='x';
          
          if ((xw>=200) and (xw<=990) and (yw>=400) and (yw<=410)) then z:='x';

              for i:=2 to dw do
              if((waz[1][1]=waz[1][i]) and (waz[2][1]=waz[2][i])) then z:='x';
              
              if z='x' then closegraph;

delay(100 - 3*(i-1));


until (dw>25);
                                                          //    RUNDA 4
cleardevice;
  setcolor(BLUE);
  outtextxy(30,10,'Punkty: 390');
  outtextxy(130,10,'Runda: 4');
  setfillstyle(1,Brown);
  ile_x:=getmaxx div 20;
  ile_y:=getmaxy div 20;
  for i:=0 to ile_x -1 do begin
    bar(20*i,40,20*i+20,60);
    bar(20*i,ile_y*20-20,20*i+20,ile_y*20);
  end;
  for i:=1 to ile_y-4 do begin
    bar(0,i*20+40,20,i*20+60);
    bar(ile_x*20-20,40+i*20,ile_x*20,20*i+60);
  end;
  bar(600,100,620,640);
  bar(200,400,1000,420);

  setfillstyle(9,BLUE);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do 
    if ((jedzonko[1][i]=jedzonko_x) and (jedzonko[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      jedzonko[1][i]:=jedzonko_x;
      jedzonko[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=30);

  setfillstyle(8,green);
  randomize;
  ile_x:=getmaxx div 20-2;
  ile_y:=getmaxy div 20-6;
  i:=0;
  repeat
    wylosowac:=false;
    jedzonko_x:=20+(random(ile_x)*20);
    jedzonko_y:=60+(random(ile_y)*20);
    for j:=0 to i do 
    if ((bonus[1][i]=jedzonko_x) and (bonus[2][i]=jedzonko_y)) then wylosowac:=true;
    if (wylosowac=false) then begin
      i:=i+1;
      bonus[1][i]:=jedzonko_x;
      bonus[2][i]:=jedzonko_y;
      bar(jedzonko_x,jedzonko_y,jedzonko_x+20,jedzonko_y+20);
    end;
  until (i=5);


  punkty:=390;
  dw:=1;
  xw:=20*((getmaxx div 20-35) div 2);
  yw:=20*((getmaxy div 20-15) div 2);
  waz[1][1]:=xw;
  waz[2][1]:=yw;

 repeat
        if keypressed then z:=readkey;
        case z of
             'w':begin
               yw:=yw-20;
               o:=z;
             end;
             'a':begin
               xw:=xw-20;
               o:=z
             end;
             's':begin
               yw:=yw+20;
               o:=z;
             end;
             'd':begin
               xw:=xw+20;
               o:=z;
             end;
end;



if ((z<>'w') and (z<>'a') and (z<>'s') and(z<>'d') and (z<>'x')) then z:=o;
             
        setfillstyle(1,WHITE);
        bar(waz[1][dw],waz[2][dw],waz[1][dw]+20,waz[2][dw]+20);
        setfillstyle(1,GREEN);

        for i:=dw downto 2 do begin
          waz[1][i]:=waz[1][i-1];
          waz[2][i]:=waz[2][i-1];
        end;

        waz[1][1]:=xw;
        waz[2][1]:=yw;

        for i:=1 to dw do
            bar(waz[1][i],waz[2][i],waz[1][i]+20,waz[2][i]+20);
        
          for i:=1 to 30 do begin
          if (waz[1][1]=jedzonko[1][i]) and (waz[2][1]=jedzonko[2][i]) then begin
          dw:=dw+1;
          punkty:=punkty+1;
          jedzonko[1][i]:=-1;
          jedzonko[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);

          end;
          end;
          
          for i:=1 to 5 do begin
          if (waz[1][1]=bonus[1][i]) and (waz[2][1]=bonus[2][i]) then begin
          if dw>1 then dw:=dw-1;
          punkty:=punkty+40;
          bonus[1][i]:=-1;
          bonus[2][i]:=-2;
          str(punkty,s);
          setfillstyle(1,WHITE);
          bar(90,0,120,20);
          outtextxy(90,10,s);

          end;
          end;

          ile_x:=getmaxx div 20;
          ile_y:=getmaxy div 20;
          if((xw<20) or (xw>= ile_x*20-20) or (yw<60) or (yw>= ile_y*20-20)) then z:='x';
          
          if ((xw>=600) and (xw<=610) and (yw>=100) and (yw<640))  then z:='x';
          
          if ((xw>=200) and (xw<=990) and (yw>=400) and (yw<=410)) then z:='x';

              for i:=2 to dw do
              if((waz[1][1]=waz[1][i]) and (waz[2][1]=waz[2][i])) then z:='x';
              
              if z='x' then closegraph;

delay(120 - 4*(i-1));


until(dw>25);


   readkey;
   closegraph;

END.

{Krzysztof Buczyñski}