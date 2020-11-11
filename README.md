## Información general
Creé una carpeta llamada **lib/rn/clases** en la cual voy a ir poniendo las clases que implemente para el TP. Las clases se crean dentro de un nuevo módulo llamado **Models**. Utilicé monkey Patching para ir creando las clases dentro de este módulo.
En el archivo **bin/rn** (el cual se ejecuta cada vez que se ingresa un comando) agregue unas sentencias las cuales crean el cajón de notas **.my_rns** en caso de que no exista y el libro .**my_rns/global** en caso de que no exista.

## Notas
La clase **Note**, la cual se encuentra implementada en el archivo `notes.rb` ,es la que implementa toda la funcionalidad para realizar el CRUD de las notas. Los métodos de **Note** son todos métodos de clase, con el fin de que desde el archivo `commands/notes.rb` se puedan llamar a estos métodos sin necesidad de instanciar la clase **Note**. Esta clase tiene un método de clase privado llamado **create_path** el cual recibe el nombre de una nota y retorna el path de esta. Para él manejo de notas solo hay que ingresar el nombre de la nota (sin extensión). Por ejemplo cuando creo una nota con el comando `bin/rn notes create notaNueva` (sin especificar el libro) me va a crear una nota con el siguiente path: `$HOME/.my_rns/global/notaNueva.rn`.

Para el manejo de archivos (es decir, las notas) usé la clase **File** la cual tiene métodos para leer archivos, borrarlos, renombrarlos, ver si existen, etc.

Para editar y crear las notas use la clase **TTY::Editor** la cual viene incluida en la gema **tty-editor**. Esta clase me permite abrir un archivo con el editor de texto que tenga configurado en mi máquina (En las variables de entorno **$EDITOR** y/o **$VISUAL**).

Para el listado de notas use una gema llamada **colorputs** la cual me permite colorear el texto que se imprime en la terminal. Los libros se imprimen de un color y las notas de otro.

## Libros
Para el manejo de libros creé una clase llamada **Book** dentro del módulo **Models**. Esta clase al igual que **Note** tiene todos métodos de clase. En todos los métodos manejé excepciones, con el fin de atrapar errores como "El nombre del libro que se quiere crear ya existe" o "El libro que se quiere borrar no existe". Esta clase también incluye un método llamado **create_path** el cual recibe el nombre del libro y retorna el path del libro.

## Validator
Creé una clase llamada **Validator** en el archivo `clases/validator.rb` dentro del módulo **Models**. Está clase tiene algunos métodos (en general de validación) que van a usar tanto la clase **Note** como la clase **Book**. Por ejemplo el método **validate_name** el cual recibe un nombre (de nota o de libro) y me retorna si el nombre es válido o si posee caracteres inválidos. Para simplificar hice que los nombres solamente puedan tener letras y números. Esta clase tiene un método de clase llamado **my_rns** el cual me retorna el path del cajón de notas. Por defecto el cajón se encuentra en `$HOME/.my_rns`.




