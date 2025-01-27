program cuatroEnLinea;

uses crt;

type
  vector = array[1..7] of char;
  matriz = array[1..7, 1..5] of char;
var
  head: vector;
  field: matriz;
  piece: char;
  _x: shortInt;
  _y: shortInt;
  key: char;
  player1: String;
  player2: String;
{______________________________________________________________________________}
procedure intro();
{escritura en pantalla de las opciones}
begin
  gotoXY(2, 6); write('Bienvenido a Cuatro En Linea:'); delay(1000);
  gotoXY(2, 8); write('-Presiona "c" para cargar un juego.'); delay(1000);
  gotoXY(2, 9); write('-Presiona "j" para empezar el juego.'); delay(1000);
  gotoXY(2, 10); write('-Presiona "a" para obtener ayuda.'); delay(1000);
  gotoXY(2, 11); write('-Presiona "s" para salir.'); delay(1000);
end;
{______________________________________________________________________________}
procedure clearScreen();
{limpieza del espacio interno en los bordes}
var
  x: byte;
  y: byte;
begin
  {limpieza del espacio interno del marco de arriba}
  for x := 2 to 43 do begin
    for y := 6 to 14 do begin
      gotoXY(x, y);
      write(' ');
    end;
    writeLn;
  end;
  {limpieza del espacio interno del marco de abajo}
  for x := 2 to 43 do begin
    gotoXY(x, 17); write(' ');
  end;
end;
{______________________________________________________________________________}
procedure paint();
{pintura de las piezas de toda la pantalla}
var
  x,y:Byte;
begin
  {pintura de las piezas de la matriz}
  for x := 1 to 7 do
    for y := 1 to 5 do begin
      if (field[x, y] = 'x') then begin
        gotoXY(x+19, y+8);
        textcolor(lightblue);
        write('x');
        textcolor(7);
      end;
      if (field[x, y] = 'o') then begin
        gotoXY(x+19, y+8);
        textcolor(lightred);
        write('o');
        textcolor(7);
      end;
    end;
  {pintura de las piezas del vector}
  for x := 1 to 7 do begin
    if (head[x] = 'x') then begin
      gotoXY(x+19, y+2);
      textcolor(lightblue);
      write('x');
      textcolor(7);
    end;
    if (head[x] = 'o') then begin
      gotoXY(x+19, y+2);
      textcolor(lightred);
      write('o');
      textcolor (7);
    end;
  end;
end;
{______________________________________________________________________________}
procedure writeMenu();
{escritura del titulo y del menu}
begin
  writeLn('Cuatro en linea');
  writeLn('ÚÄÄÄÄÄÄÄÄÄ¿', 'ÚÄÄÄÄÄÄÄÄÄ¿', 'ÚÄÄÄÄÄÄÄÄÄ¿', 'ÚÄÄÄÄÄÄÄÄÄ¿');
  writeLn('³  Cargar ³', '³  Jugar  ³', '³  Ayuda  ³', '³  Salir  ³');
  writeLn('ÀÄÄÄÄÄÄÄÄÄÙ', 'ÀÄÄÄÄÄÄÄÄÄÙ', 'ÀÄÄÄÄÄÄÄÄÄÙ', 'ÀÄÄÄÄÄÄÄÄÄÙ');
end;
{______________________________________________________________________________}
procedure writeBorder();
{escritura de los bordes}
begin
  {escritura del borde de arriba}
  gotoXY(1, 05); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  gotoXY(1, 06); write('³'); gotoXY(44, 06); write('³');
  gotoXY(1, 07); write('³'); gotoXY(44, 07); write('³');
  gotoXY(1, 08); write('³'); gotoXY(44, 08); write('³');
  gotoXY(1, 09); write('³'); gotoXY(44, 09); write('³');
  gotoXY(1, 10); write('³'); gotoXY(44, 10); write('³');
  gotoXY(1, 11); write('³'); gotoXY(44, 11); write('³');
  gotoXY(1, 12); write('³'); gotoXY(44, 12); write('³');
  gotoXY(1, 13); write('³'); gotoXY(44, 13); write('³');
  gotoXY(1, 14); write('³'); gotoXY(44, 14); write('³');
  gotoXY(1, 15); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  {escritura del borde de abajo}
  gotoXY(1, 16); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  gotoXY(1, 17); write('³'); gotoXY(44, 17); write('³');
  gotoXY(1, 18); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
end;
{______________________________________________________________________________}
procedure writeField();
{escritura del tablero y las piezas}
var
  spacer: string;
  x, y: byte;
begin
  clrScr();
  spacer := '                  ';
  writeMenu();
  writeLn();
  writeLn(spacer, 'şşşşşşşşş');
  {escritura del vector (head)}
  write(spacer, 'ş');
  for x := 1 to 7 do
    write(head[x]);
  writeLn('ş');
  {escritura de la matriz (field)}
  writeLn(spacer, 'şşşşşşşşş');
  for y := 1 to 5 do begin
    write(spacer, 'ş');
    for x := 1 to 7 do
      write(field[x, y]);
    writeLn('ş');
  end;
  writeLn(spacer, 'şşşşşşşşş');
  paint();
  writeBorder();
end;
{______________________________________________________________________________}
procedure movePiece(var key: char; var _x: shortInt);
{movimiento de la pieza}
var x: byte;
begin
  {movimiento de la pieza}
  for x := 1 to 7 do
    head[x] := ' ';
  case key of
    '8': ;
    '6': _x := _x+1;
    '4': _x := _x-1;
    '2':
  end;
  {limites}
  if (_x < 1) then
    _x := 1;
  if (_x > 7) then
    _x := 7;
end;
{______________________________________________________________________________}
procedure down(var _x: byte);
{caida de la pieza}
var
  _y: byte;
begin
  _y := 1;
  for _y := 1 to 5 do begin
    field[_x, _y] := piece;
    if (_y <> 1) then
      field[_x ,_y-1] := ' ';
    if ((field[_x, (_y+1)] = 'x') or (field[_x, (_y+1)] = 'o')) then
      break;
  end;
end;
{______________________________________________________________________________}
procedure changePiece(var piece: char);
var x: byte;
begin
  if (piece = 'o') then
    piece := 'x'
  else
    piece := 'o';
  _x := 1;
  _y := 1;
  for x := 1 to 7 do
    head[x] := ' ';
end;
{______________________________________________________________________________}
procedure evaluate(var stop: boolean);
{evaluacion de la matriz y determinacion de ganador}
var
  x, y: shortInt;
begin
  for x := 1 to 7 do
    for y := 1 to 7 do begin
      {algoritmo que evalua las columnas}
      if (y < 3) then
        if ((field[x, y] = 'x') or (field[x, y] = 'o')) then
          if (field[x, y] = field[x, y+1]) then
            if (field[x, y] = field[x, y+2]) then
              if (field[x, y] = field[x, y+3]) then
                stop := true;
      {algoritmo que evalua las filas}
      if (y < 5) then
        if ((field[y, x] = 'x') or (field[y, x] = 'o')) then
          if (field[y, x] = field[y+1, x]) then
            if (field[y, x] = field[y+2, x]) then
              if (field[y, x] = field[y+3, x]) then
                stop := true;
      {algoritmo que evalua las diagonales descendentes}
      if ((y < 5) and (x < 3)) then
        if ((field[y, x] = 'x') or (field[y, x] = 'o')) then
          if (field[y, x] = field[y+1, x+1]) then
            if (field[y, x] = field[y+2, x+2]) then
              if (field[y, x] = field[y+3, x+3]) then
                stop := true;
      {algoritmo que evalua las diagonales ascendentes}
      if ((y > 3) and (x < 3)) then
        if ((field[y, x] = 'x') or (field[y, x] = 'o')) then
          if (field[y, x] = field[y-1, x+1]) then
            if (field[y, x] = field[y-2, x+2]) then
              if (field[y, x] = field[y-3, x+3]) then
                stop := true;
    end;
end;
{______________________________________________________________________________}
procedure pascalPlay();
{random que juega contra player1}
begin
  repeat
    Randomize();
    _x := Random(7);
    _x := _x + 1;
    head[_x] := piece;
  until ((field[_x, 1] <> 'x') and (field[_x, 1] <> 'o'));
  key := '2';
  down(_x);
end;
{______________________________________________________________________________}
procedure loadPlayers(var player1: string; var player2: string);
{carga de los nombres de los jugadores}
begin
  cursorOn();
  clearScreen();
  gotoXY(2, 6); write('Jugador 1 ______________________ ');
  readLn(player1);
  gotoXY(2, 7); write('Jugador 2 ______________________ ');
  readLn(player2);
  cursorOff();
end;
{______________________________________________________________________________}
procedure help();
{escritura en pantalla de la ayuda}
begin
  clearScreen();
  gotoXY(02, 06); write('Ayuda de Cuatro En Linea:');
  gotoXY(02, 08); write('Primero presiona "j" para empezar el juego');
  gotoXY(02, 09); write('-Para jugar con pascal anotalo en jugador2');
  gotoXY(02, 10); write('-Para moverte presiona las teclas 4 y 6');
  gotoXY(02, 11); write('-Para dejarte caer presiona la tecla 2');
  gotoXY(02, 12); write('Al final aparecera el ganador y los puntos');
  gotoXY(02, 13); write('Al salir si el juego se corta se guardara.');
  gotoXY(21, 14); write('Poligon Teknologies (R)');
  readKey();
end;
{______________________________________________________________________________}
procedure saveGame();
{almacenamiento del juego en disco}
type
  document = text;
var
  _root: document;
  x,y: byte;
begin
  assign(_root, 'C:\4inLine.txt');
  rewrite(_root);
  for x := 1 to 7 do
    for y := 1 to 5 do
      writeLn(_root, field[x, y]);
  writeLn(_root, player1);
  writeLn(_root, player2);
  close(_root);
end;
{______________________________________________________________________________}
procedure saveScores(var player1: string; scoreX: byte; player2: string; scoreO: byte);
{almacenamiento de los ultimos 16 nombres y puntajes}
type
  document = file of string;
  vector = array[1..16] of string;
var
  _root: document;
  scores: vector;
  y: byte;
  strScoreX, strScoreO: string;
  score: string;
  spacer: string;
begin
  spacer := ' ';
  str(scoreX, strScoreX);
  str(scoreO, strScoreO);
  player1 := player1 + spacer + strScoreX;
  player2 := player2 + spacer + strScoreO;
  assign(_root, 'C:\4inLine.dat');
                                                                                {$I-}
  reset(_root);
  close(_root);
                                                                                {$I+}
  if (IOresult <> 0) then begin
    rewrite(_root);
    for y := 1 to 16 do
      write(_root, spacer);
    close(_root);
  end;
  
  reset(_root);
  y := 0;
  while not EOF(_root) do begin
    read(_root, score);
    if (score <> spacer) then begin
      y := y + 1;
      scores[y] := score;
    end;
  end;

  close(_root);
  erase(_root);

  for y := 1 to 14 do
    scores[y] := scores[y+2];

  rewrite(_root);
  for y:= 1 to 14 do
    write(_root, scores[y]);
  write(_root, player1);
  write(_root, player2);
  close(_root);
end;
{______________________________________________________________________________}
procedure play();
{desarrollo del juego}
var
  scoreX: byte;
  scoreO: byte;
  gameOver: boolean;
  stop: boolean;
begin
  stop := false;
  gameOver := false;
  _x := 1;
  _y := 1;
  repeat
    if (stop = true) then
      gameOver := true;
    head[_x] := piece;
    writeField();
    key := readKey();
    case Key of
      '4', '6': movePiece(key, _x);
      '2': begin
        if not ((field[_x, _y] = 'x') or (field[_x, _y] = 'o')) then begin
          if (stop = False) then begin
            down(_x);
            evaluate(stop);
            changePiece(piece);
            if (player2 = 'pascal') then begin
              if (stop = False) then begin
                pascalPlay();
                evaluate(stop);
                changePiece(piece);
              end;
            end;
          end;
        end;
      end;
      'C', 'c': ;
      'A', 'a': help();
      'S', 's': begin saveGame(); exit; end;
      'J', 'j': ;
    end;
  until (gameOver = true);

  {escritura de datos de los jugadores---------------------------------}
  scoreX := 100;
  scoreO := 100;
  for _y := 1 to 5 do
    for _x := 1 to 7 do begin
      if (field[_x, _y] = 'x') then
        scoreX := scoreX - 5;
      if (field[_x, _y] = 'o') then
        scoreO := scoreO - 5;
    end;
  if (piece = 'o') then begin
    scoreX := scoreX + 50;
    gotoXY(2, 17); write('El ganador es ', player1, '    ', scoreX, ' - ', scoreO);
  end else begin
    scoreO := scoreO + 50;
    gotoXY(2, 17); write('El ganador es ', player2, '    ', scoreO, ' - ', scoreX);
  end;
  saveScores(player1, scoreX, player2, scoreO);
  {--------------------------------------------------------------------}
end;
{______________________________________________________________________________}
procedure newGame();
{preparacion de la matriz para un nuevo juego}
begin
  LoadPlayers(player1, player2);
  for _y := 1 to 5 do
    for _x := 1 to 7 do
      field[_x, _y] := ' ';
  piece := 'x';
  play();
end;
{______________________________________________________________________________}
procedure loadGame();
{carga de un juego guardado y preparacion de la matriz para este}
type
  document = text;
var
  _root: document;
  x, y: byte;
  xPieces, oPieces: byte;
begin
  clearScreen();
 
  assign(_root, 'C:\4inLine.txt');
                                                                                {$I-}
  reset(_root);
                                                                                {$I+}
  if (IOresult = 0) then begin
    for x := 1 to 7 do
      for y := 1 to 5 do
        readLn(_root, field[x, y]);
    readLn(_root, player1);
    readLn(_root, player2);
    close(_root);
    erase(_root);
  
    xPieces := 0;
    oPieces := 0;
 
    for x := 1 to 7 do
      for y:=1 to 5 do begin
        if (field[x, y] = 'x') then
          xPieces := xPieces + 1;
        if (field[x, y] = 'o') then
          oPieces := oPieces + 1;
      end;
  
      if (xPieces = oPieces) then
        piece := 'x'
      else
        piece := 'o';
      play();
  end
  else begin
    gotoXY(2, 17); write('No hay juegos guardados.');
  end;
end;
{______________________________________________________________________________}
{programa principal}
begin
  clrScr();
  cursorOff();
  writeMenu();
  writeBorder();
  intro();
  repeat
    key := readKey();
    case key of
      'C', 'c': loadGame();
      'A', 'a': help();
      'S', 's': exit;
      'J', 'j': newGame();
    end;
  until ((key = 'S') or (key = 's'));
end.
