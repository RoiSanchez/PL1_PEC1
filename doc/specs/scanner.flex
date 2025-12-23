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
%caseless
%state END
%state COMMENT

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

%eof{
    if(commentCount != 0){
        addLexicalError ("Los comentarios no se han cerrado correctamente");
    }
%eof}

COMENTARIO_LINEA="//".*\n
COMENTARIO_ABRIR="{"
COMENTARIO_CERRAR="}"
ESPACIO_BLANCO=[ \t\r\n\f]
DIGITO_POSITIVO=[1-9]
DIGITO=[0-9]
NUMERO_INICIA_CERO ="0"{DIGITO_POSITIVO}({DIGITO}*)
NUMERO=("0" | {DIGITO_POSITIVO}({DIGITO}*))
STRING="\"".*"\""
IDENTIFICADR=[A-Za-z]([A-Za-z]|[0-9])*
fin = "end."


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
    {COMENTARIO_ABRIR} {
        System.out.print("YYINITIAL Abrir comentario");
        commentCount++;
        yybegin(COMMENT);
    }
    {COMENTARIO_LINEA} {}

    {STRING} {
        return createToken(sym.STRING);
      }
  /* *******************************
  PALABRAS RESERVADAS
  ******************************** */
  "begin" { return createToken(sym.BEGIN); }
  "boolean" { return createToken(sym.BOOLEAN); }
  "const"  {
                      return createToken(sym.CONST);
                }
  "else" { return createToken(sym.ELSE); }
  {fin} { return createToken(sym.END_PROGRAM); }
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
               return createToken(sym.TYPE);
         }
  "until"  { return createToken(sym.UNTIL); }
  "var"  {
            return createToken(sym.VAR);
      }
  "write"  { return createToken(sym.WRITE); }
  /* *******************************
    Operadores asignación
    ******************************** */
    ":=" { return createToken(sym.ASSIGN); }
  /* *******************************
  DELIMITADORES
  ******************************** */
  "\"" { return createToken(sym.DOUBLE_QUOTE); }
  "(" { return createToken(sym.PARENTHESIS_OPEN); }
  ")"  { return createToken(sym.PARENTHESIS_CLOSE); }
  "[" { return createToken(sym.RANGE_OPEN); }
  "]"  { return createToken(sym.RANGE_CLOSE); }
  "," { return createToken(sym.INT_LIST_DELIMITER); }
  ".."  { return createToken(sym.VALUE_RANGE_DELIMITER); }
  "."  { return createToken(sym.END_PROGRAM); }
  ";"  { return createToken(sym.END_SENTENCE); }
  ":"  { return createToken(sym.COLON); }
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

  {IDENTIFICADR} {
    return createToken(sym.IDENTIFICADOR);
  }
    // incluir aqui el resto de las reglas patron - accion


   {ESPACIO_BLANCO}	{}


    // error en caso de coincidir con ningún patrón
	[^]
                        {                                               
                           addLexicalError ("Lexema que no coincide con ningún patrón esperado");
                        }

}

<COMMENT> {
    {COMENTARIO_ABRIR} {
          System.out.println("YYCOMMENT Abrir comentario");
        commentCount++;
    }
    {COMENTARIO_CERRAR} {
        System.out.println("YYCOMMENT Cerrar comentario");
        commentCount--;
        if(commentCount < 1){
           System.out.println("YYCOMMENT Cambiar a YYINITIAL");
            yybegin(YYINITIAL);
        }
    }
    [^] {}
}

<END> {


 {ESPACIO_BLANCO}	{}
 // error en caso de coincidir con ningún patrón

 [^](\n|\f) {
    addLexicalError ("No puede contener texto una vez finalizado el programa");
 }

}


