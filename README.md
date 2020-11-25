# Circuitos digitales II: Diseño de la capa de transmisión de un PCIe

Este repositorio contiene los códigos de Verilog diseñados para emular el funcionamiento de la capa de transacción de un PCIe. Cada componente se realiza por separado y luego se unen las piezas. 


Para correr los módulos individuales se puede usar make directamente en el directorio de cada uno, si se corre make en el directorio general, se obtiene la simulación de todo el conjunto pegado.

Para correr las distintas pruebas se usan los comandos:

Prueba llenado
~~~
make full_logic_llenado
~~~

Prueba errores
~~~
make full_logic_errores
~~~

Prueba único tipo de dato camino VC0 y D0
~~~
make full_logic_unicodato
~~~

Prueba único tipo de dato camino VC1 y D1
~~~
make full_logic_unicodato_uno
~~~

Prueba de umbrales
~~~
make full_logic_umbrales
~~~