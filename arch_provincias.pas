unit arch_provincias;

interface
type
    reg_provincia=record
        denom,cod:string;
        telmt:longint;
    end;
    f_provincia=file of reg_provincia;
const
    nombre='provincias.dat';

procedure crear_provincia(var arch:f_provincia);
procedure abrir_provincia(var arch:f_provincia);
procedure leer_provincia(var arch:f_provincia;var reg:reg_provincia;indice:integer);
procedure guardar_provincia(var arch:f_provincia;reg:reg_provincia;indice:integer);
procedure eliminar_provincia(var arch:f_provincia);
procedure alta_provincia(var arch:f_provincia;var reg:reg_provincia);

implementation
uses
    crt,busquedas;

procedure abrir_provincia(var arch:f_provincia);
begin
    assign(arch,nombre);
    {$I-}
        reset(arch);
    {$I+}
end;

procedure crear_provincia(var arch:f_provincia);
begin
    abrir_provincia(arch);
    if ioresult<>0 then
        begin
            rewrite(arch);
        end;
    close(arch);
end;

procedure leer_provincia(var arch:f_provincia;var reg:reg_provincia;indice:integer);
begin
    seek(arch,indice);
    read(arch,reg);
end;

procedure guardar_provincia(var arch:f_provincia;reg:reg_provincia;indice:integer);
begin
    seek(arch,indice);
    write(arch,reg);
end;

procedure alta_provincia(var arch:f_provincia;var reg:reg_provincia);
var
    i,x,validacion:integer;
begin
    clrscr;
    gotoxy(23,3);writeln('Ingrese los datos de la provincia donde se encuentra la estancia');
    gotoxy(23,5);writeln('Cod. Provincia:');
    gotoxy(23,6);writeln('Denoominacion:');
    gotoxy(23,7);writeln('Tel. Min. Turismo:');
    gotoxy(38,5);readln(reg.cod);
    i:=buscar_cod_pcia(arch,reg.cod);
    if i=-1 then
        begin
            repeat
                gotoxy(37,6);
                writeln('                     ');
                gotoxy(37,6);
                readln(reg.denom);
                x:=buscar_denom_pcia(arch,reg.denom);         
                if (x<>-1) then
                    begin
                        textcolor(12);
                        gotoxy(20,15);writeln('Esta provincia ya tiene un codigo asignado, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,15);writeln('                                                               '); 
                        textcolor(15); 
                    end;
            until(x=-1);
            repeat
                gotoxy(41,7);
                writeln('                      ');
                gotoxy(41,7);
                {$I-}readln(reg.telmt);{$I+}
                validacion:=ioresult();
                if validacion<>0 then
                    begin
                        textcolor(12);
                        gotoxy(20,10);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,10);writeln('                                                           ');
                        textcolor(15);
                    end
            until(validacion=0);
        end
    else
        begin
            clrscr;
            gotoxy(23,4);writeln('El id de la provincia ya existe, ingrese los datos restantes:');
            gotoxy(23,6);writeln('Denoominacion:');
            gotoxy(23,7);writeln('Tel. Min. Turismo:');
            repeat
                gotoxy(37,6);
                writeln('                     ');
                gotoxy(37,6);
                readln(reg.denom);
                x:=buscar_denom_pcia(arch,reg.denom);
                if (x=-1) then
                    begin
                        textcolor(12);
                        gotoxy(20,10);writeln('Esta no es la provincia que tiene este codigo, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,10);writeln('                                                                  ');
                        textcolor(15);
                    end;
            until(x<>-1);
            repeat
                gotoxy(41,7);
                writeln('                      ');
                gotoxy(41,7);
                {$I-}readln(reg.telmt);{$I+}
                validacion:=ioresult();
                if validacion<>0 then
                    begin
                        textcolor(12);
                        gotoxy(20,10);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,10);writeln('                                                           ');
                        textcolor(15);
                    end
            until(validacion=0);
        end;                                     
end;

procedure eliminar_provincia(var arch:f_provincia);
begin
    erase(arch);
end;
end.
