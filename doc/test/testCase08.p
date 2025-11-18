// subprogramas 

program prueba;

type
       unoAdiez = set of 1..10;
	 dosAcinco = set of 2..5;



var
        z: integer;


procedure imprimeIncrementa (x:integer);

  
        begin
            x:= x+1;     
	    write(x);       
        end;

begin

      write ("SUBPROGRAMAS PROCEDIMIENTOS");
 

      z:=1;
      write("z(2):");
      imprimeIncrementa (z);

end.
