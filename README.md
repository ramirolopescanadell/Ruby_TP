## Información general
Mediante el generador scaffold creé los modelos, el CRUD y los controladores para manejar los **Libros**, las **Notas** y los **Usuarios**.

## Usuarios
Para el manejo de sesiones (Iniciar sesión, Cerrar sesión, registrarse, etc) usé la gema `devise`. Los usuarios poseen un **email** (único),una **contraseña** y varios libros. 

## Libros
Cada usuario posee un libro **Global** el cual se crea cuando el usuario se registra y no puede ser eliminado. El libro posee un **nombre** (único para un mismo usuario) y varias notas.  El nombre de los libros pueden tener un máximo de **30** caracteres 
Los libros pertenecen a un único usuario.
Los usuarios pueden crear, editar, eliminar y mostrar cada uno de sus libros. Al mostrar un libro se listan todas las notas que pertenecen a ese libro.

## Notas
Las notas poseen un **nombre** (único para un mismo libro) y un **contenido**. El nombre de las notas pueden tener un máximo de 30 caracteres.
Las notas pertenecen a un único libro.
Los usuarios pueden crear, editar, modificar y mostrar cada una de sus notas. Las notas se escriben utilizando el formato Markdown. Cuando se muestra el contenido de las notas este se formatea en formato HTML mediante la clase **Redcarpet::Markdown** de la gema `redcarpet` 

## Configuración
Se debe tener instalado lo siguiente:
* Ruby (2.7.1)
* SQLite3 (3.31.1)
* Node.js (10.19.0)
* Yarn (1.22.5)
* **rails (6.0.3.4)** (ejecutando `gem install rails`)

## Ejecución
Para crear y configurar la base de datos:
1. **rails db:create**
2. **rails db:migrate** 
3. **rails db:seed** 

Para levantar la aplicación:  
4. **rails server**

Al hacer “rails db:seed” se crean y guardan algunos datos en la base de datos. Se crean 5 usuarios con 3 libros y 5 notas por libro cada uno. El email y contraseña de los usuarios tiene el formato “`email<número>@hotmail.com`” y “`password<número>`”, por ejemplo el usuario 1 tendrá el email “`email1@hotmail.com`” y contraseña “`password1`”

## Interfaz
Las vistas principales son:
#### Books 
En esta vista se listan los libros del usuario logueado con las opciones de eliminar libro, mostrar notas del libro y editar título del libro.
#### Notes
En esta vista se listan todas las notas del usuario. Se muestran en formato HTML. Para cada nota se muestran las opciones para mostrar, editar o eliminarla.
Otras vistas son:
* **Create book**: Para crear un nuevo libro
* **Edit book**: Para editar un libro ya existente.
* **Create note**
* **Edit note**
* **Show Book**: Se muestra el nombre de un libro en específico y se listan las notas que pertenecen a ese libro.
* **Show note**: Se muestra el contenido de una nota en específico.
