// tipos estructurados CONJUNTOS operaciones

program prueba;

type
        unoAdiez = set of 1..10;
	    dosAcinco = set of 2..5;
        error3 = set of 1..f(1);
        error2 = set of 1..2+3;
var
       conj1 : unoAdiez;

begin
        write ("CONJUNTOS OPERACIONES");

	conj1:=[2..4];
	conj2:=[3..7];
	conj3:=conj1+conj2;
	
	write ("IN(true):");
	if ((2 IN conj3) or (6 IN conj3)) then
		write("true");
	else
		write("false");
	
end.
