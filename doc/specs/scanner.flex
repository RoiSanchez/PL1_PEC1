package compiler.lexical;

import compiler.syntax.sym;
import compiler.lexical.Token;
import es.uned.lsi.compiler.lexical.ScannerIF;
import es.uned.lsi.compiler.lexical.LexicalError;
import es.uned.lsi.compiler.lexical.LexicalErrorManager;

// incluir aqui, si es necesario otras importaciones

%%
 
%public
%class Scanner
%char
%line
%column
%cup
%unicode


%implements ScannerIF
%scanerror LexicalError

// incluir aqui, si es necesario otras directivas

%{
  LexicalErrorManager lexicalErrorManager = new LexicalErrorManager ();
  private int commentCount = 0;

  private Token createToken(int tokenIdType) {
    Token token = new Token(tokenIdType);
    token.setLine (yyline + 1);
    token.setColumn (yycolumn + 1);
    token.setLexema (yytext ());
    return token;
  }

%}



  
COMENTARIO_LINEA="//".*\n
ESPACIO_BLANCO=[ \t\r\n\f]
fin = "fin"{ESPACIO_BLANCO}


%%
/*
-> COMENTARIOS
-> PALABRAS RESERVADAS
-> DELIMITADORES
-> OPERADORES ARITMÉTICOS
-> OPERADORES RELACIONALES
-> OPERADORES LÓGICOS
-> IDENTIFICADORES
-> ESPACIO EN BLANCO
*/

<YYINITIAL> 
{
    {COMENTARIO_LINEA} {
                            return createToken(sym.COMMENT);
                        }
    "+"                {  
                           return createToken(sym.PLUS);
                        }




    // incluir aqui el resto de las reglas patron - accion
    "procedure" 	{
			   Token token = new Token(1);
                           token.setLine (yyline + 1);
                           token.setColumn (yycolumn + 1);
                           token.setLexema (yytext ());
           			       return token;
			}

   {ESPACIO_BLANCO}	{}

{fin} {}
    
    // error en caso de coincidir con ning�n patr�n
	[^]     
                        {                                               
                           LexicalError error = new LexicalError ();
                           error.setLine (yyline + 1);
                           error.setColumn (yycolumn + 1);
                           error.setLexema (yytext ());
                           lexicalErrorManager.lexicalError (error);
                        }
    
}


                         


