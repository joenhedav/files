unit listados;

interface
uses
    crt,arch_estancias,arch_provincias;

procedure nombre(var arch:f_estancia);
procedure piscina(var arch:f_estancia);
procedure provincia(var arch:f_estancia);

implementation
uses
    busquedas;

procedure provincia(var arch:f_estancia);
var
    estancia:reg_estancia;
    i,j:integer;
    codigo:string;
begin
    abrir_estancia(arch);
    clrscr;gotoxy(23,3);writeln('Ingrese el codigo de la provincia:');
    gotoxy(57,3);readln(codigo);
    i:=busqueda_cod_pcia(arch,codigo);
    if i=-1 then
        begin
            clrscr;gotoxy(20,6);textcolor(12);writeln('No hay una provincia con este codigo.');pulsartecla;
            textcolor(15);
        end
    else
        begin
            gotoxy(23,3);writeln('Listado de las estancias que pertenecen a la provincia con el codigo ',codigo);
            for j:=0 to filesize(arch)-1 do
                begin
                    leer_estancia(arch,estancia,j);
                    if (estancia.estado) and (estancia.domicilio.cpcia=codigo) then
                        begin
                            mostrar_estancia(estancia);
                        end;
                end;
        end;
    close(arch);
end;

procedure piscina(var arch:f_estancia);
var
    estancia:reg_estancia;
    i:integer;
begin
    abrir_estancia(arch);
    gotoxy(23,3);
    writeln('Listado de las estancias que poseen piscina:');
    for i:=0 to filesize(arch)-1 do  
        begin
            leer_estancia(arch,estancia,i);
            if (estancia.estado) and (estancia.piscina='s') or (estancia.piscina= 'S') then
                begin
                    mostrar_estancia(estancia);
                end;
        end;
    close(arch);
end;

procedure nombre(var arch:f_estancia);{listado por nombre ordenado alfabeticamente}
var
    i:integer;
    estancia:reg_estancia;
begin
    ordenar(arch);
    abrir_estancia(arch);
    gotoxy(23,3);writeln('Listado ordenado alfabeticamente por nombre de la estancia:');
    begin
        for i:=0 to filesize(arch)-1 do
            begin
                leer_estancia(arch,estancia,i);
                if estancia.estado then
                    begin
                        mostrar_estancia(estancia);
                    end;
            end;                
    end;
    close(arch);
end;

end.



