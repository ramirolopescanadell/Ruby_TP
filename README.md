## Información general
Creé una carpeta llamada **lib/rn/models** en la cual voy a ir poniendo las clases que implemente para el TP. Las clases se crean dentro de un nuevo módulo llamado **Models**. Utilicé monkey Patching para ir creando las clases dentro de este módulo.

## Notas
La clase **Note**, la cual se encuentra implementada en el archivo `notes.rb` ,es la que implementa toda la funcionalidad para realizar el CRUD de las notas. Los métodos de **Note** que se encargan de manejar una nota en especifico (creación, eliminación, etc) son métodos de instancia, y los métodos que se encargan de manejar varias notas (listado) son métodos de clase. Posee un método de instancia llamado **create_path** el cual recibe el nombre de una nota y retorna el path de esta. Para el manejo de notas solo hay que ingresar el nombre de la nota (sin extensión). Por ejemplo cuando creo una nota con el comando `bin/rn notes create notaNueva` (sin especificar el libro) me va a crear una nota con el siguiente path: `$HOME/.my_rns/global/notaNueva.rn`.
Las instancias de la clase **Note** tienen una variable **name** que representa el nombre de la nota y una variable **book** que representan el nombre del libro al que pertenece la nota.

Para el manejo de archivos (es decir, las notas) usé la clase **File** la cual tiene métodos para leer archivos, borrarlos, renombrarlos, ver si existen, etc.

Para editar y crear las notas use la clase **TTY::Editor** la cual viene incluida en la gema **tty-editor**. Esta clase me permite abrir un archivo con el editor de texto que tenga configurado en mi máquina (En las variables de entorno **$EDITOR** y/o **$VISUAL**).

Para el listado de notas use una gema llamada **colorputs** la cual me permite colorear el texto que se imprime en la terminal. Los libros se imprimen de un color y las notas de otro.

## Libros
Para el manejo de libros creé una clase llamada **Book** dentro del módulo **Models**. Esta clase al igual que **Note** tiene métodos de instancia para el manejo de un libro en especifico (creación, eliminación, etc) y métodos de clase para el manejo de varios libros (listado). En todos los métodos manejé excepciones, con el fin de atrapar errores como "El nombre del libro que se quiere crear ya existe" o "El libro que se quiere borrar no existe". Esta clase también incluye un método llamado **create_path** el cual recibe el nombre del libro y retorna el path del libro.
Las instancias de la clase **Book** tienen una variable **name** que representa el nombre del libro.

## Validator
Creé un módulo llamado **Validator** en el archivo `models/validator.rb` dentro del módulo **Models**. Este módulo tiene algunos métodos (en general de validación) que van a usar tanto la clase **Note** como la clase **Book**. Por ejemplo el método **validate_name** el cual recibe un nombre (de nota o de libro) y me retorna si el nombre es válido o si posee caracteres inválidos. Para simplificar hice que los nombres solamente puedan tener letras y números. 
Este módulo tiene un método de clase llamado **my_rns** el cual me retorna el path del cajón de notas. Por defecto el cajón se encuentra en `$HOME/.my_rns`.
Agregué unas sentencias las cuales crean el cajón de notas **.my_rns** en caso de que no exista y el libro .**my_rns/global** en caso de que no exista. 

## Exportación 
Las notas a exportar deben utilizar el formato de texto plano **Markdown**. Se exportan en formato HTML y se guardan en un directorio llamado **.my_exports** ubicado en el home al igual que el cajón de notas. Se respeta la estructura de directorios.

Para la exportación de notas creé un nuevo comando (Es decir una clase nueva que hereda de **Dry::CLI::Command**) dentro del archivo `commands/notes.rb`. 
Esta clase recibe 1 argumento opcional y 2 opciones: 
- **note** Es un argumento optativo que representa el nombre de la nota que se desea exportar.
- **--book** Es una opción que representa el nombre del libro del cual se desea exportar. 
- **--all**  Es una opción booleana que indica que se desea exportar el cajón de notas completo.

Como usar el comando:
- Sin ninguna opción ni argumento se exporta el libro global junto con sus notas.
- Con la opción **--all** se exportan todas las notas (dentro de sus libros) al directorio **.my_exports**.
- Si solo se envía el nombre de la nota como argumento (sin otra opción) se buscará la nota a exportar en el libro global.
- Si se envía el nombre de la nota como argumento y se especifica un libro con la opción **--book** entonces se exporta la nota de ese libro (dentro del libro).
- Si solamente se especifica el nombre del libro con la opción **--book** y no se pasa como argumento el nombre de una nota entonces se van a exportar todas las notas del libro especificado.

Para realizar la exportación cree un método de instancia en la clase **Models/Note** que se encarga de exportar una nota en específico.
Para exportar con las diferentes opciones creé una clase **Export** dentro del módulo **Models** que posee métodos de clase para realizar la exportación que se desee. Estos métodos utilizan el metodo de la clase **Models/Note** mencionado anteriormente.

Usé la clase **Redcarpet::Markdown** de la gema `redcarpet` para exportar las notas a archivos con extensión html.
