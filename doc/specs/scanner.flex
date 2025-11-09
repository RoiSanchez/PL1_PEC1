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


  /* *******************************
  PALABRAS RESERVADAS
  ******************************** */
  "begin" { return createToken(sym.BEGIN); }
  "boolean" { return createToken(sym.BOOLEAN); }
  "const" { return createToken(sym.CONST); }
  "else" { return createToken(sym.ELSE); }
  "end" { return createToken(sym.END); }
  "false" { return createToken(sym.FALSE); }
  "function" { return createToken(sym.FUNCTION); }
  "if"  { return createToken(sym.IF); }
  "integer"  { return createToken(sym.INTEGER); }
  "of"  { return createToken(sym.OF); }
  "or"  { return createToken(sym.OR); }
  "procedure"  { return createToken(sym.PROCEDURE); }
  "program"  { return createToken(sym.PROGRAM); }
  "repeat"  { return createToken(sym.REPEAT); }
  "set"  { return createToken(sym.SET); }
  "then"  { return createToken(sym.THEN); }
  "true"  { return createToken(sym.TRUE); }
  "type"  { return createToken(sym.TYPE); }
  "until"  { return createToken(sym.UNTIL); }
  "var"  { return createToken(sym.VAR); }
  "write"  { return createToken(sym.WRITE); }
  /* *******************************
  DELIMITADORES
  ******************************** */
  "\"" { return createToken(sym.DOUBLE_QUOTE); }
  "(" { return createToken(sym.PARAM_EXPR_OPEN); }
  ")"  { return createToken(sym.PARAM_EXPR_CLOSE); }
  "[" { return createToken(sym.RANGE_OPEN); }
  "]"  { return createToken(sym.RANGE_CLOSE); }
  "," { return createToken(sym.INT_LIST_DELIMITER); }
  ".."  { return createToken(sym.VALUE_RANGE_DELIMITER); }
  "."  { return createToken(sym.END_PROGRAM); }
  ";"  { return createToken(sym.END_SENTENCE); }
  ":"  { return createToken(sym.DECLARATE_VAR_CTA_PARAM); }
  "="  { return createToken(sym.ASSIGN_VALUE_VAR_CTE); }
/* *******************************
  OPERADORES ARITMETICOS
  ******************************** */

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


                         


