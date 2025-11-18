# Analizador léxico

## Directivas de código

Para simplificar el código y evitar el código duplicado se han generado los métodos createToken y addLexicalError. 
De esta forma tenemos el código de creación de tokens y de manejo de errores centralizada.

## Controles de error

Se controlan que las secciones principales const, type y var no se repiten. Estas palabras reservadas tan solo pueden 
aparecer una vez.

## Casos de test adicionales

Test11 - Ejemplo que debe dar error por tener dos secciones var.
Test12 - Ejemplo que debe dar error por tener dos secciones type.
Test13 - Ejemplo que debe dar error por tener dos secciones const.