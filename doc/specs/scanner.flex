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
%state YYEND

%implements ScannerIF
%scanerror LexicalError

// incluir aqui, si es necesario otras directivas

%{
  LexicalErrorManager lexicalErrorManager = new LexicalErrorManager ();
  private int commentCount = 0;
  private int constCount = 0;
  private int typeCount = 0;
  private int varCount = 0;


  private Token createToken(int tokenIdType) {
    Token token = new Token(tokenIdType);
    token.setLine (yyline + 1);
    token.setColumn (yycolumn + 1);
    token.setLexema (yytext ());
    return token;
  }

  private void addLexicalError(){
    addLexicalError("");
  }

  private void addLexicalError(String msg){
      String completeMsg = "ERROR: %s.";
      LexicalError error = new LexicalError (String.format(completeMsg, msg));
      error.setLine (yyline + 1);
      error.setColumn (yycolumn + 1);
      error.setLexema (yytext ());

      lexicalErrorManager.lexicalError (error);
  }



%}

COMENTARIO_LINEA="//".*\n
ESPACIO_BLANCO=[ \t\r\n\f]
DIGITO_POSITIVO=[1-9]
DIGITO=[0-9]
NUMERO_INICIA_CERO ="0"{DIGITO_POSITIVO}({DIGITO}*)
NUMERO=("0" | {DIGITO_POSITIVO}({DIGITO}*))
fin = "end."{ESPACIO_BLANCO}


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
  "const"  {
                    if(constCount == 0){
                      constCount++;
                      return createToken(sym.CONST);
                    } else {
                        addLexicalError ("La palabra reservada const tan solo puede aparecer una vez");
                    }
                }
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
  "type" {
             if(typeCount == 0){
               typeCount++;
               return createToken(sym.TYPE);
             } else {
                 addLexicalError ("La palabra reservada type tan solo puede aparecer una vez");
             }
         }
  "until"  { return createToken(sym.UNTIL); }
  "var"  {
          if(varCount == 0){
            varCount++;
            return createToken(sym.VAR);
          } else {
              addLexicalError ("La palabra reservada var tan solo puede aparecer una vez");
          }
      }
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
  "="  { return createToken(sym.EQUAL); }
  /* *******************************
  OPERADORES ARITMETICOS
  ******************************** */
  "+" { return createToken(sym.PLUS); }
  "-" { return createToken(sym.MINUS); }
  "*" { return createToken(sym.MULTI); }
  /* *******************************
  OPERADORES RELACIONALES
  ******************************** */
  ">" { return createToken(sym.GREATER_THAN); }
  "<>" { return createToken(sym.NOT_EQUAL); }
  /* *******************************
  Operadores asignación
  ******************************** */
  ":=" { return createToken(sym.ASSIGN); }
  /* *******************************
  Operadores especiales
  ******************************** */
  "IN" { return createToken(sym.IN); }
  /* *******************************
  IDENTIFICADORES
  ******************************** */
  {NUMERO_INICIA_CERO} {
          addLexicalError ("Un número de varios dígitos no puede comenzar por 0");
      }
  {NUMERO} {
          return createToken(sym.NUMERO);
      }

    // incluir aqui el resto de las reglas patron - accion


   {ESPACIO_BLANCO}	{}

{fin} {
          yybegin(YYEND);
          return createToken(sym.END);
      }
    
    // error en caso de coincidir con ningún patrón
	[^]
                        {                                               
                           addLexicalError ("Lexema que no coincide con ningún patrón esperado");
                        }

}

<YYEND> {


 {ESPACIO_BLANCO}	{}
 // error en caso de coincidir con ningún patrón

 [^] {
                                 addLexicalError ("No puede contener texto una vez finalizado el programa");
                              }

}


