// subprogramas  funciones

program prueba;



var
        z,v: integer;


function uno ():integer;
    const numUno = 1;
    begin
        uno:= numUno;
    end;

begin

        write ("SUBPROGRAMAS FUNCIONES");
        func(1);
        func(false);
        func(true);
        func("cadena de texto");
        uno(5,2,tercerParam);

        z:=1;
        write("v(2):");
        write(v);

end.
