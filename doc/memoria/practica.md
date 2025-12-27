# Analizador léxico

## Directivas de código

Para simplificar el código y evitar el código duplicado se han generado los métodos createToken y addLexicalError. 
De esta forma tenemos el código de creación de tokens y de manejo de errores centralizada.

## Controles de error

Se controla que no puede haber números de varios dígitos que empiezan por 0.

Se controla que no se introduce ningún caracter tras el fin de programa.

## Estados
 Se crea un estado para gestionar los comentarios de varias líneas y comentarios anidados.

## Macros
Se crea una macro para los números de forma que un número debe empezar por 0 o por un dígito positivo y secuencia de dígitos

## Sección reglas-acción

Se tiene en cuenta el orden de las reglas, por ejemplo, se le debe dar máxima prioridad a los comentarios 
y como segundo los strings para no detectar lexemas incorrectos. Esto se comprueba con el ejemplo de test testCase03.p.

## Casos de test adicionales

- Test11 - Ejemplo que debe dar error por tener dos secciones var.
- Test12 - Ejemplo que debe dar error por tener dos secciones type.
- Test13 - Ejemplo que debe dar error por tener dos secciones const.
- Test14 - Ejemplo para comprobar que un número con varios dígitos que comienza por 0 lo detecta como erróneo, combinándolo con otros números correctos.
- Test15 - Ejemplo que debe dar error al introducir sentencia tras final de programa
- Test16 - Ejemplo que contiene un comentario de varias líneas
- Test17 - Ejemplo con comentario de línea dentro comentario multilinea
- Test18 - Ejemplo con comentario anidado
- Test19 - Ejemplo con funcion con dos parámetros de un tipo (integer) y otra de otro tipo (boolean)
- Test20 - Ejemplo con dos funciones
- Test21 - Ejemplo con procedure y función
- Test22 - Ejemplo con funcion sin parámetros y con seccion de constantes
- Test23 - Ejemplo con llamada a función sin parámetros
- test24 - Ejemplo con llamada a función con varios parámetros o con parámetro numérico o booleano o cadena de texto
- Test25 - Ejemplo con dos variables declaradas del mismo tipo en líneas distintas
- Test26 - Ejemplo que debe dar error por tener asignado a una constante una expresion.
- Test27 - Ejemplo que debe dar error por tener asignado expresiones a ejemplos de tipo conjunto
- Test28 y 29 - Ejemplo que debe dar error por asignaciones erróneas de conjunto
- Test30 - Ejemplo con la unión de 3 conjuntos.
- Test31 - Ejemplo con 3 definiciones de variables de un tipo conjunto en 1 sola linea
- Test32 - Ejemplo de funcion con seccion de constantes, tipos y variables
- Test33 - Ejemplo que debe dar error por orden incorrecto de type const y var en definicion de función

SIGUIENTE EJEMPLO A HACER PROCEDURE CON TYPE CONST Y VAR