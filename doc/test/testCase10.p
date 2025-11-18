{ Control de flujo repeat }

program prueba;



var
        x,y,z,w: integer;


begin

        write ("CONTROL FLUJO REPEAT");


	
        x:=0;
	    write("x(012345):");
        repeat 		
		  write(x);
		  x:=x+1;
	    until (x>5);

end.
