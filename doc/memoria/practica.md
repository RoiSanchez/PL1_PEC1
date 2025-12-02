# Analizador léxico

## Directivas de código

Para simplificar el código y evitar el código duplicado se han generado los métodos createToken y addLexicalError. 
De esta forma tenemos el código de creación de tokens y de manejo de errores centralizada.

## Controles de error

Se controlan que las secciones principales const, type y var no se repiten. Estas palabras reservadas tan solo pueden 
aparecer una vez.

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

Test11 - Ejemplo que debe dar error por tener dos secciones var.
Test12 - Ejemplo que debe dar error por tener dos secciones type.
Test13 - Ejemplo que debe dar error por tener dos secciones const.
Test14 - Ejemplo para comprobar que un número con varios dígitos que comienza por 0 lo detecta como erróneo, combinándolo con otros números correctos.
Test15 - Ejemplo que debe dar error al introducir sentencia tras final de programa
Test16 - Ejemplo que contiene un comentario de varias líneas
Test17 - Ejemplo con comentario de línea dentro comentario multilinea
Test17 - Ejemplo con comentario anidado