Cree una carpeta llamada `lib/rn/clases` en la cual voy a ir poniendo las clases que implemente para el TP. 
Las clases se crean dentro de un nuevo modulo llamado `Models`. Utilice monkey Patching para ir creando las clases dentro del modulo.

La clase `Note`, la cual se encuentra implementada en el archivo `notes.rb` ,es la clase que implementa toda la funcionalidad para crear, modificar, borrar... etc las notas. Los metodos de Note son todos metodos de clase, con el fin de que desde el archivo `commands/notes.rb` se puedan llamar a estos metodos sin necesidad de instanciar la clase Note.
Esta clase tiene un método de clase privado llamado `create_path` el cual recibe el nombre de una nota y retorna el path de esta. 
Para él manejo de notas solo hay que ingresar el nombre de la nota (sin extensión). Por ejemplo cuando creo una nota con el comando `bin/rn notes create notaNueva` (sin especificar el libro) me va a crear una nota con el siguiente path: `$HOME/.my_rns/global/notaNueva.rn`.

Para el manejo de archivos (es decir, las notas) usé la clase `File` la cual tiene metodos para leer archivos, borrarlos, renombrarlos, ver si existen, etc.

Para editar y crear las notas use la clase `TTY::Editor` la cual viene incluida en la gema `tty-editor`. Esta clase me permite abrir un archivo con el editor de texto que tenga configurado en mi maquina (En las variables de entorno $EDITOR y/o $VISUAL).

Para el listado de notas use una gema llamada `colorputs` la cual me permite colorear el texto que se imprime en la terminal. Los libros se imprimen de un color y las notas de otro.

Para el manejo de libros cree una clase llamada `Book` dentro del modulo  `Models`. 
Esta clase al igual que `Note` tiene todos metodos de clase.
En todos los metodos manejé excepciones, con el fin de atrapar errores como "El nombre del libro que se quiere crear ya existe" o "El libro que se quiere borrar no existe".
Esta clase tambien incluye un metodo llamado `create_path` el cual recibe el nombre del libro y retorana el path del libro.


Cree una clase llamada `Validator` en el archivo `clases/validator.rb` dentro del modulo `Models`. Está clase tiene algunos métodos (en general de validacion) que van a usar tanto la clase `Note` como la clase `Book`. Por ejemplo el metodo `validate_name` el cual recibe un nombre (de nota o de libro) y me retorna si el nombre es valido o si posee caracteres invalidos. Para simplificar hice que los nombres solamente puedan tener letras y numeros.
Esta clase tiene un metodo llamado `my_rns` el cual me retorna el path del cajon de notas. Por defecto el cajón se encuentra en `$HOME/.my_rns`. 


En el archivo `bin/rn` (el cual se ejecuta cada vez que se ingresa un comando) agregue unas sentencias las cuales crean el cajon de notas `.my_rns` en caso de que no exista y el libro `.my_rns/global` en caso de que no exista.



