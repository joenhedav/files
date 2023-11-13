unit busquedas;

interface

uses
    crt,arch_estancias,arch_provincias;

function busqueda_id_estancia(var arch:f_estancia;buscado:string):integer;
function busqueda_dni(var arch:f_estancia;buscado:integer):integer;
function busqueda_nomape(var arch:f_estancia;buscado:string):integer;
function busqueda_cod_pcia(var arch:f_estancia;buscado:string):integer; {para el listado}
function buscar_cod_pcia(var arch:f_provincia;buscado:string):integer; {para buscar en el alta provincia}
function buscar_denom_pcia(var arch:f_provincia;buscado:string):integer; {alta provincia}

implementation

function busqueda_id_estancia(var arch:f_estancia;buscado:string):integer;
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while not(eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            if estancia.id=buscado then
                begin
                    encontrado:=true;
                end;
        end;
    if encontrado then
        busqueda_id_estancia:=filepos(arch) - 1
    else
        busqueda_id_estancia:=-1;
end;

function busqueda_nomape(var arch:f_estancia;buscado:string):integer;
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while (not eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            if estancia.dueno.nom_ape = buscado then
                begin
                    encontrado:=true;
                end;
        end;
        if encontrado then
            busqueda_nomape:=filepos(arch) - 1
        else
            busqueda_nomape:=-1;
end;

function busqueda_dni(var arch:f_estancia;buscado:integer):integer;
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while (not eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            if estancia.dueno.dni = buscado then
                begin
                    encontrado:=true;
                end;
        end;
        if encontrado then
            busqueda_dni:=filepos(arch) - 1
        else
            busqueda_dni:=-1;
end;

function busqueda_cod_pcia(var arch:f_estancia;buscado:string):integer; {listado}
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while(not eof(arch))and(not encontrado) do
        begin
            read(arch,estancia);
            if estancia.domicilio.cpcia=buscado then
                begin
                    encontrado:=true;
                end;
        end;
        if encontrado then
            busqueda_cod_pcia:=filepos(arch) - 1
        else
            busqueda_cod_pcia:=-1;
end;

function buscar_cod_pcia(var arch:f_provincia;buscado:string):integer; {alta provincia}
var
    provincia:reg_provincia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while (not eof(arch)) and (not encontrado) do 
        begin
            read(arch,provincia);
            if provincia.cod=buscado then
                begin
                    encontrado:=true;
                end;
        end;
    if encontrado then
        buscar_cod_pcia:=filepos(arch) - 1
    else
        buscar_cod_pcia:=-1;
end;

function buscar_denom_pcia(var arch:f_provincia;buscado:string):integer; {se usa en el alta provincia}
var
    encontrado:boolean;
    provincia:reg_provincia;
begin
    encontrado:=false;
    seek(arch,0);
    while (not eof(arch)) and (not encontrado) do 
        begin
            read(arch,provincia);
            if provincia.denom = buscado then
                begin
                    encontrado:=true;
                end;
        end;
    if encontrado then
        buscar_denom_pcia:=filepos(arch) - 1
    else
        buscar_denom_pcia:=-1;
end;

end.

