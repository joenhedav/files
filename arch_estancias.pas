unit arch_estancias;

// notas
{se agrego unit de busquedas}

interface
type
    reg_estancia=record
        id,nombre,email,caract:string;
        tel:longint;
        capacidad:integer;
        piscina:char;
        dueno:record
            dni:integer;
            nom_ape:string;
        end;
        domicilio:record
            ciudad,calle,cpcia:string;
            num,piso,cp:integer;
        end;
        estado:boolean;
    end;
    f_estancia=file of reg_estancia;
const 
    nombre='estancias.dat';

procedure crear_estancia(var arch:f_estancia);
procedure abrir_estancia(var arch:f_estancia);
procedure leer_estancia(var arch:f_estancia;var reg:reg_estancia;indice:integer);
procedure guardar_estancia(var arch:f_estancia;reg:reg_estancia;indice:integer);
procedure mostrar_estancia(estancia:reg_estancia);
procedure alta_estancia(var arch:f_estancia);
procedure baja_estancia(var arch:f_estancia);
procedure modificar_estancia(var arch:f_estancia);
procedure consultar_estancia(var arch:f_estancia);
procedure ordenar(var arch:f_estancia); {orden alfabetico de las estancias}
procedure eliminar_estancia(var arch:f_estancia);
procedure pulsartecla;

implementation
uses
    crt,arch_provincias,busquedas;

procedure abrir_estancia(var arch:f_estancia);
begin
    assign(arch,nombre);
    {$I-}
        reset(arch);
    {$I+}
end;

procedure crear_estancia(var arch:f_estancia);
begin
    abrir_estancia(arch);
    if ioresult<>0 then
        begin
            rewrite(arch);
        end;
    close(arch);
end;

procedure leer_estancia(var arch:f_estancia;var reg:reg_estancia;indice:integer);
begin
    seek(arch,indice);
    read(arch,reg); {lee los datos del registro}
end;

procedure guardar_estancia(var arch:f_estancia;reg:reg_estancia;indice:integer); 
begin
    seek(arch,indice);
    write(arch,reg);
end;

procedure pulsartecla;
begin
    gotoxy(16,10);
    textcolor(15);
    writeln('- Pulse cualquier tecla para continuar -');
    readkey;
    clrscr
end;

procedure mostrar_estancia(estancia:reg_estancia); {muestra los datos de la estancia}
begin 
    with estancia do
        begin   
            gotoxy(20,5);writeln('Id de la estancia: ',estancia.id);
            gotoxy(20,6);writeln('Nombre de la estancia: ',estancia.nombre); 
            gotoxy(20,7);writeln('Nombre y Apellido del dueno: ',estancia.dueno.nom_ape);
            gotoxy(20,8);writeln('DNI del dueno: ',estancia.dueno.dni);
            gotoxy(20,9);writeln('Email: ',estancia.email);
            gotoxy(20,10);writeln('Teléfono: ',estancia.tel);
            gotoxy(20,11);writeln('Caracteristicas de la estancia: ',estancia.caract);
            gotoxy(20,12);writeln('Piscina: ',estancia.piscina);
            gotoxy(20,13);writeln('Capcidad que posee la estancia: ',estancia.capacidad);
            gotoxy(20,14);writeln('Ciudad: ',estancia.domicilio.ciudad); 
            gotoxy(20,15);writeln('Calle: ',estancia.domicilio.calle);
            gotoxy(20,16);writeln('Numero: ',estancia.domicilio.num);
            gotoxy(20,17);writeln('Piso: ',estancia.domicilio.piso);
            gotoxy(20,18);writeln('CP: ',estancia.domicilio.cp);
            gotoxy(20,21);writeln('- Pulse cualquier tecla para continuar -');readkey;clrscr;
        end;
end;

procedure alta_estancia(var arch:f_estancia);
var
    reg,estancia:reg_estancia; {reg lectura estancia escritura}
    archivo_provincia:f_provincia; {copia archivo}
    r_provincia:reg_provincia; {copia registro}
    i,x,j,validacion:integer;
    opcion:char;
begin
    clrscr;
    abrir_estancia(arch);
    abrir_provincia(archivo_provincia);
    textcolor(15);
    gotoxy(25,5);writeln('Ingrese los datos de la estancia a dar de alta');
    gotoxy(23,7);writeln('Id:');
    gotoxy(23,8);writeln('Nombre de la estancia:'); 
    gotoxy(23,9);writeln('DNI del dueno:');
    gotoxy(23,10);writeln('Nombre y Apellido del dueno:');
    gotoxy(23,11);writeln('Email:');
    gotoxy(23,12);writeln('Tel:');
    gotoxy(23,13);writeln('¿Tiene piscina? s/n:');
    gotoxy(23,14);writeln('Capacidad:');
    gotoxy(23,15);writeln('Caracteristicas:');
    gotoxy(23,16);writeln('Ciudad:');
    gotoxy(23,17);writeln('Calle:');
    gotoxy(23,18);writeln('Numero:');
    gotoxy(23,19);writeln('Piso:');
    gotoxy(23,20);writeln('CP:');
    gotoxy(26,7);readln(estancia.id);
    i:=busqueda_id_estancia(arch,estancia.id);
    if i=-1 then {no lo encontro}
        begin
            gotoxy(45,8);readln(estancia.nombre);
            repeat
                gotoxy(37,9);
                writeln('               ');
                gotoxy(37,9);
                {$I-}
                    readln(estancia.dueno.dni);
                {$I+}
                validacion:=ioresult();
                if validacion=0 then
                    begin
                        x:=busqueda_dni(arch,estancia.dueno.dni);
                        if (x=-1) then
                            begin
                                gotoxy(51,10);readln(estancia.dueno.nom_ape);
                                break;
                            end
                        else
                            begin
                                textcolor(14);
                                gotoxy(20,22);writeln('ya existe una persona con el DNI ingresa su nombre y apellido');
                                delay(3000);
                                gotoxy(20,22);writeln('                                                             ');
                                textcolor(15);
                                repeat
                                    gotoxy(51,10);
                                    writeln('                                   ');
                                    gotoxy(51,10);
                                    readln(estancia.dueno.nom_ape);
                                    j:=busqueda_nomape(arch,estancia.dueno.nom_ape);
                                    if (j=-1) then
                                        begin
                                            textcolor(12);
                                            gotoxy(20,22);writeln('El nombre y apellido ingresado no coincide con el DNI, intente nuevamente.');
                                            delay(3000);
                                            gotoxy(20,22);writeln('                                                                          ');
                                            textcolor(15);
                                        end;
                                until(j<>-1);
                            end;
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,22);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,22);writeln('                                                             ');
                        textcolor(15);
                    end;
            until (validacion=0);
            gotoxy(29,11);readln(estancia.email);
            repeat
                gotoxy(27,12);
                writeln('                       ');
                gotoxy(27,12);
                {$I-}readln(estancia.tel);{$I+}
                validacion:=ioresult();
                if validacion=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,22);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,22);writeln('                                                           ');
                        textcolor(15);
                    end;
            until(validacion=0);
            repeat
                gotoxy(43,13);
                writeln('                       ');
                gotoxy(43,13);
                {$I-}readln(estancia.piscina);{$I+}
                validacion:=ioresult();
                if (validacion=0) and (estancia.piscina = 'S') or (estancia.piscina = 's') or (estancia.piscina = 'N') or (estancia.piscina = 'n')  then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,22);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,22);writeln('                                                           ');
                        textcolor(15);
                    end;
            until(false);
            repeat
                gotoxy(33,14);
                writeln('                       ');
                gotoxy(33,14);
                {$I-}readln(estancia.capacidad);{$I+}
                validacion:=ioresult();
                if (validacion=0) then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,22);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,22);writeln('                                                             ');
                        textcolor(15);
                    end;
            until(validacion=0);
            gotoxy(39,15);readln(estancia.caract);
            gotoxy(30,16);readln(estancia.domicilio.ciudad);
            gotoxy(29,17);readln(estancia.domicilio.calle);
            repeat
                gotoxy(30,18);
                writeln('                       ');
                gotoxy(30,18);
                {$I-}readln(estancia.domicilio.num);{$I+}
                validacion:=ioresult();
                if validacion=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,22);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,22);writeln('                                                           ');textcolor(15);
                    end;
            until(validacion=0);
            repeat
                gotoxy(28,19);
                writeln('                           ');
                gotoxy(28,19);
                {$I-}readln(estancia.domicilio.piso);{$I+}
                validacion:=ioresult();
                if validacion=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,22);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,22);writeln('                                                           ');textcolor(15);
                    end;
            until(validacion=0);
            repeat
                gotoxy(26,20);
                writeln('                           ');
                gotoxy(26,20);
                {$I-}readln(estancia.domicilio.cp);{$I+}
                validacion:=ioresult();
                if validacion=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,22);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(3000);
                        gotoxy(20,22);writeln('                                                           ');textcolor(15);
                    end;
            until(validacion=0);
            {cargar datos de la provincia}
            alta_provincia(archivo_provincia,r_provincia);
            estancia.domicilio.cpcia:=r_provincia.cod;
            estancia.estado:=true;
            guardar_estancia(arch,estancia,filesize(arch));
            guardar_provincia(archivo_provincia,r_provincia,filesize(archivo_provincia));
            clrscr;
            textcolor(10);gotoxy(20,6);writeln('La estancia fue dada de alta.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,reg,i);
            if reg.estado then
                begin
                    clrscr;
                    gotoxy(20,6);textcolor(14);writeln('La estancia con ese id ya existe.');textcolor(15);
                    pulsartecla;
                end
            else
                begin
                    clrscr;
                    gotoxy(20,6);textcolor(lightblue);writeln('La estancia existe, pero fue dada de baja.');
                    gotoxy(26,8);textcolor(15);writeln('¿Desea darla de alta? s/n');
                    repeat
                        opcion:=readkey;
                    until opcion in ['s','n','S','N'];
                    if (opcion = 's') or (opcion = 'S') then
                        begin
                            leer_estancia(arch,estancia,i);
                            estancia.estado:=true;
                            seek(arch,i);
                            write(arch,estancia);
                            clrscr;
                            gotoxy(20,6);textcolor(10);writeln('La estancia fue dada de alta.');textcolor(15);
                            pulsartecla;
                        end;
                    if (opcion ='n') or (opcion = 'N') then
                        begin
                            clrscr;
                            gotoxy(20,6);textcolor(12);writeln('La estancia no fue dada de alta.');textcolor(15);
                            pulsartecla;
                        end;
                end;
        end;
    close(arch);
    close(archivo_provincia);
end;

procedure baja_estancia(var arch:f_estancia);
var
    estancia:reg_estancia;
    id:string;
    i:integer;
begin
    clrscr;
    textcolor(15);
    abrir_estancia(arch);
    gotoxy(23,3);writeln('Id de la estancia a dar de baja:');gotoxy(55,3);readln(id);
    i:=busqueda_id_estancia(arch,id);
    if i=-1 then
        begin
            clrscr;
            gotoxy(20,6);textcolor(12);writeln('No existe una estancia con ese id.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,estancia,i);
            if estancia.estado then
                begin
                    estancia.estado:=false;
                    i:=filepos(arch) - 1;
                    guardar_estancia(arch,estancia,i);
                end;
            clrscr;
            gotoxy(20,6);textcolor(10);writeln('La estancia fue dada de baja.');textcolor(15);
            pulsartecla;
        end;
    close(arch);
end;

procedure modificar_estancia(var arch:f_estancia);
var
    id,opcion:string;
    estadio:char;
    i,x,validacion:integer;
    estancia:reg_estancia;
begin
    abrir_estancia(arch);
    clrscr;
    gotoxy(20,3);writeln('Id de la estancia a modificar:');gotoxy(50,3);readln(id);
    i:=busqueda_id_estancia(arch,id);
    if i=-1 then
        begin
            clrscr;
            gotoxy(20,6);textcolor(12);writeln('No existe una estancia con ese id.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,estancia,i);
            if estancia.estado then
                begin
                    clrscr;
                    gotoxy(25, 3);
                    writeln('Elija el campo a modificar:');
                    gotoxy(23,6);writeln('1 Nombre de la estancia');
                    gotoxy(23,7);writeln('2 DNI del dueno'); 
                    gotoxy(23,8);writeln('3 Nombre y Apellido del dueno');
                    gotoxy(23,9);writeln('4 Email');
                    gotoxy(23,10);writeln('5 Tel.');
                    gotoxy(23,11);writeln('6 ¿Tiene piscina? s/n');
                    gotoxy(55,6);writeln('7 Capacidad');
                    gotoxy(55,7);writeln('8 Caracteristicas');
                    gotoxy(55,8);writeln('9 Ciudad');
                    gotoxy(55,9);writeln('10 Calle');
                    gotoxy(55,10);writeln('11 Numero');
                    gotoxy(55,11);writeln('12 Piso');
                    gotoxy(55,12);writeln('13 CP');
                    repeat
                        gotoxy(52,3);readln(opcion);
                        gotoxy(52,3);writeln('              ');
                        case opcion of
                            '1':
                                begin
                                    clrscr;
                                    gotoxy(23,5);writeln('Nombre de la estancia:');
                                    gotoxy(45,5);readln(estancia.nombre);
                                end;
                            '2':
                                begin
                                    clrscr;
                                    gotoxy(23,5);writeln('DNI del dueno:');
                                    repeat
                                        gotoxy(37,5);
                                        writeln('                   ');
                                        gotoxy(37,5);
                                        {$I-}
                                            readln(estancia.dueno.dni);
                                        {$I+}
                                        validacion:=ioresult();
                                        if validacion = 0 then
                                            begin
                                                x:=busqueda_dni(arch,estancia.dueno.dni);
                                                if (x<>-1) then
                                                    begin
                                                        textcolor(12);
                                                        gotoxy(20,7);writeln('ya existe una persona con este DNI');
                                                        delay(3000);
                                                        gotoxy(20,7);writeln('                                  ');
                                                        textcolor(15);
                                                    end;
                                            end
                                        else
                                            begin
                                                textcolor(12);
                                                gotoxy(20,7);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                                delay(3000);
                                                gotoxy(20,7);writeln('                                                           ');
                                                textcolor(15);
                                            end;
                                    until(validacion=0) and (x=-1);
                                end;
                            '3':
                                begin
                                    clrscr;
                                    gotoxy(23,5);writeln('Nombre y Apellido del dueno:');
                                    gotoxy(51,5);readln(estancia.dueno.nom_ape);
                                end;
                            '4':
                                begin
                                    clrscr;
                                    gotoxy(23,5);writeln('Email:');gotoxy(29,5);readln(estancia.email);
                                end;
                            '5':
                                begin
                                    clrscr;gotoxy(23,5);writeln('Tel.:');
                                    repeat
                                        gotoxy(28,5);
                                        writeln('                       ');
                                        gotoxy(28,5);
                                        {$I-}
                                            readln(estancia.tel);
                                        {$I+}
                                        validacion:=ioresult();
                                        if (validacion=0) then
                                            begin
                                                break;
                                            end
                                        else
                                            begin
                                                textcolor(12);
                                                gotoxy(20,7);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                                delay(3000);
                                                gotoxy(20,7);writeln('                                                           ');
                                                textcolor(15);
                                            end;
                                    until (validacion=0);
                                end;
                            '6':
                                begin
                                    clrscr;gotoxy(23,5);writeln('¿La estancia posee piscina? s/n:');
                                    repeat
                                        gotoxy(55,5);
                                        writeln('                       ');
                                        gotoxy(55,5);
                                        {$I-}
                                            readln(estancia.piscina);
                                        {$I+}
                                        validacion:=ioresult();
                                        if (validacion=0) and (estancia.piscina='S') or (estancia.piscina='s') or (estancia.piscina='N') or (estancia.piscina='n') then
                                            begin
                                                break;
                                            end
                                        else
                                            begin
                                                textcolor(12);
                                                gotoxy(20,7);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                                delay(3000);
                                                gotoxy(20,7);writeln('                                                           ');
                                                textcolor(15);
                                            end;
                                    until(false);
                                end;
                            '7':
                                begin
                                    clrscr;gotoxy(23,5);writeln('Capacidad:');
                                    repeat
                                        gotoxy(33,5);
                                        writeln('                       ');
                                        gotoxy(33,5);
                                        {$I-}
                                            readln(estancia.capacidad);
                                        {$I+}
                                        validacion:=ioresult();
                                        if (validacion=0) then
                                            begin
                                                break;
                                            end
                                        else
                                            begin
                                                textcolor(12);
                                                gotoxy(20,7);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                                delay(3000);
                                                gotoxy(20,7);writeln('                                                           ');
                                                textcolor(15);
                                            end;
                                    until(validacion=0);
                                end;
                            '8':
                                begin
                                    clrscr;gotoxy(23,5);writeln('Caracteristicas:');gotoxy(39,5);readln(estancia.caract);
                                end;
                            '9':
                                begin
                                    clrscr;gotoxy(23,5);writeln('Ciudad:');gotoxy(30,5);readln(estancia.domicilio.ciudad);
                                end;
                            '10':
                                begin
                                    clrscr;gotoxy(23,5);writeln('Calle:');gotoxy(29,5);readln(estancia.domicilio.calle);
                                end;
                            '11':
                                begin
                                    clrscr;gotoxy(23,5);writeln('Numero:');
                                    repeat
                                        gotoxy(31,5);
                                        writeln('                       ');
                                        gotoxy(31,5);
                                        {$I-}
                                            readln(estancia.domicilio.num);
                                        {$I+}
                                        validacion:=ioresult();
                                        if (validacion=0) then
                                            begin
                                                break;
                                            end
                                        else
                                            begin
                                                textcolor(12);
                                                gotoxy(20,7);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                            end;
                                    until(validacion=0);
                                end;
                           '12':
                                begin
                                    clrscr;gotoxy(23,5);writeln('Piso:');
                                    repeat
                                        gotoxy(28,5);
                                        writeln('                       ');
                                        gotoxy(28,5);
                                        {$I-}
                                            readln(estancia.domicilio.piso);
                                        {$I+}
                                        validacion:=ioresult();
                                        if (validacion=0) then
                                            begin
                                                break;
                                            end
                                        else
                                            begin
                                                textcolor(12);
                                                gotoxy(20,7);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                            end;
                                    until(validacion=0);
                                end;
                           '13':
                                begin
                                    clrscr;gotoxy(23,5);writeln('CP:');
                                    repeat
                                        gotoxy(26,5);
                                        writeln('                       ');
                                        gotoxy(26,5);
                                        {$I-}
                                            readln(estancia.domicilio.cp);
                                        {$I+}
                                        validacion:=ioresult();
                                        if (validacion=0) then
                                            begin
                                                break;
                                            end
                                        else
                                            begin
                                                textcolor(12);
                                                gotoxy(20,7);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                            end;
                                    until(validacion=0);
                                end;
                        end;
                    until(opcion='1') or (opcion='2') or (opcion='3') or (opcion='4') or (opcion='5') or (opcion='6') or (opcion='7') or (opcion='8') or (opcion='9') or (opcion='10')                     or (opcion='11') or (opcion='12') or (opcion='13');
                    i:=filepos(arch) - 1;
                    guardar_estancia(arch,estancia,i);
                    clrscr;
                    gotoxy(20,6);textcolor(10);writeln('El campo fue modificado correctamente.');
                    textcolor(15);
                    pulsartecla;
                end
            else
                begin
                    clrscr;
                    gotoxy(20,6);textcolor(lightblue);writeln('La estancia existe, pero fue dada de baja.');
                    gotoxy(26,8);textcolor(15);writeln('¿Desea darla de alta? s/n');
                    repeat
                        estadio:=readkey;
                    until estadio in ['s','n','S','N'];
                    if (estadio = 's') or (estadio = 'S') then
                        begin
                            leer_estancia(arch,estancia,i);
                            estancia.estado:=true;
                            seek(arch,i);
                            write(arch,estancia);
                            clrscr;
                            gotoxy(20,6);textcolor(10);writeln('La estancia fue dada de alta.');textcolor(15);
                            pulsartecla;
                        end;
                    if (estadio ='n') or (estadio = 'N') then
                        begin
                            clrscr;
                            gotoxy(20,6);textcolor(12);writeln('La estancia no fue dada de alta.');textcolor(15);
                            pulsartecla;
                          end; 
                end;
        end;
    close(arch);
end;

procedure consultar_estancia(var arch:f_estancia);
var
    estancia:reg_estancia;
    id:string;
    i:integer;
begin
    abrir_estancia(arch);
    clrscr;
    textcolor(15);
    gotoxy(20,3);writeln('Id de la estancia a consultar:');gotoxy(50,3);readln(id);
    i:=busqueda_id_estancia(arch,id);
    if i=-1 then
        begin
            clrscr;
            gotoxy(20,6);textcolor(12);writeln('No existe una estancia con ese id.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,estancia,i);
            if estancia.estado then
                begin
                    clrscr;
                    gotoxy(20,3);writeln('Los datos de la estancia consultada son los siguientes:');
                    mostrar_estancia(estancia);
                end
            else
                begin
                    clrscr;
                    gotoxy(13,6);textcolor(14);writeln('La estancia fue dada de baja, debe darla de alta.');textcolor(15);
                    pulsartecla;
                end;
        end;
    close(arch);
end;

procedure ordenar(var arch:f_estancia);
var
    estancia,aux_estancia,tmp:reg_estancia;
    i,j:integer;
begin
    abrir_estancia(arch); 
    for i:= 0 to filesize(arch)-1 do // iteraciones (cantidad de registros en el archivo)
        begin
            seek(arch,i);
            read(arch,estancia);
            for j:=filesize(arch)-1 downto i do // compara cada registro con los registros anteriores
                begin
                    seek(arch,j);
                    read(arch,aux_estancia);
                    if estancia.nombre>aux_estancia.nombre then
                        begin
                            tmp:=estancia;
                            estancia:=aux_estancia;
                            aux_estancia:=tmp;
                            seek(arch,i);
                            write(arch,estancia);
                            seek(arch,j);
                            write(arch,aux_estancia);
                        end;
                end;
        end;
    close(arch);
end;

procedure eliminar_estancia(var arch:f_estancia);
begin
    erase(arch);
end;

end.
