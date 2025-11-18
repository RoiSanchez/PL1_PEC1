// subprogramas  funciones

program prueba;



var
        z,v: integer;


function incrementa (x:integer):integer;

var
        y:integer;

        begin
	    x:=x+1;
      
            incrementa:=x;

        end;

begin

        write ("SUBPROGRAMAS FUNCIONES");
 

        z:=1;
        v:= incrementa (z);

        write("v(2):");
        write(v);
	

end.
