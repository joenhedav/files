unit menu;

interface
uses
    crt,arch_estancias,arch_provincias,listados;

procedure principal;
procedure abmc;
procedure listados;
procedure borrar;

implementation

var
    file_estancia:f_estancia;
    file_provincia:f_provincia;

procedure principal;
var
    opcion:char;
begin
    crear_estancia(file_estancia);
    crear_provincia(file_provincia);
    repeat
        clrscr;
        textcolor(15);
        gotoxy(22,3);writeln(' ~ Menu Principal ~ ');
        gotoxy(26,5);writeln('1 ABMC');
        gotoxy(26,6);writeln('2 Listados');
        gotoxy(26,7);writeln('3 Borrar archivos');
        gotoxy(26,8);writeln('4 Salir');
        gotoxy(24,10);writeln('Elija una opcion');
        repeat
            opcion:=readkey;
        until opcion in ['1'..'4'];
        clrscr;
        case opcion of
        '1':abmc;
        '2':listados;
        '3':borrar
        end
    until opcion ='4';
    if opcion='4' then
        begin
            clrscr;
            halt;
        end;
end;    

procedure abmc;
var
   opcion:char;
begin
    repeat
        clrscr;
        textcolor(15);
        gotoxy(29,4);writeln('~ Menu ABMC ~');
        gotoxy(23,6);writeln('1 Dar de alta una estancia');
        gotoxy(23,7);writeln('2 Dar de baja una estancia');
        gotoxy(23,8);writeln('3 Modificar una estancia');
        gotoxy(23,9);writeln('4 Consultar una estancia');
        gotoxy(23,10);writeln('5 Volver al menu principal');
        gotoxy(27,12);writeln('ELija una opcion');
        repeat
            opcion:=readkey;
        until opcion in ['1'..'5'];
        clrscr;
        case opcion of
        '1':alta_estancia(file_estancia); 
        '2':baja_estancia(file_estancia);
        '3':modificar_estancia(file_estancia);
        '4':consultar_estancia(file_estancia);
        end
    until opcion='5';
    if opcion='5' then
        begin
            principal;
        end;
end;

procedure listados;
var
    opcion:char;
begin
    repeat 
        clrscr;
        textcolor(15);
        gotoxy(30,4);writeln('~ Menu Listados ~');
        gotoxy(23,6);writeln('1 Listado de estancias por nombre');
        gotoxy(23,7);writeln('2 Listado de estancias por provincia');
        gotoxy(23,8);writeln('3 Estancias que poseen piscinas');
        gotoxy(23,9);writeln('4 Volver al menu principal');
        gotoxy(30,11);writeln('Elija una opcion');
        repeat
            opcion:=readkey;
        until opcion in ['1'..'4'];
        clrscr;
        case opcion of
        '1':nombre(file_estancia);
        '2':provincia(file_estancia); {provincia}
        '3':piscina(file_estancia);
        end
    until opcion='4';
    if opcion='4' then
        begin
            principal;
        end;
end;

procedure borrar;
var
    opcion:char;
begin
        clrscr;
        textcolor(15);
        gotoxy(23,3);writeln('¿Desea borrar los archivos? s/n');
        repeat
            opcion:=readkey;
        until opcion in ['s','n'];
        if opcion = 's' then
            begin
                eliminar_estancia(file_estancia);
                eliminar_provincia(file_provincia);
                clrscr;
                gotoxy(23,3);writeln('Borrando archivos..');
                delay(1500);
                gotoxy(23,3);writeln('Operacion realizada con exito.');
                delay(1000);
                principal;
            end
        else
            begin
                principal;
            end;
end;
end.
