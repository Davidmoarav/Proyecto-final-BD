<?php
$file = 'usuarios.json';

// Procesar el formulario de registro
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = htmlspecialchars($_POST["nombre"]);
    $apellido = htmlspecialchars($_POST["apellido"]);
    $correo = htmlspecialchars($_POST["correo"]);
    $usuario = htmlspecialchars($_POST["usuario"]);
    $contraseña = htmlspecialchars($_POST["contraseña"]);
    $confirmar_contraseña = htmlspecialchars($_POST["confirmar-contraseña"]);

    // Verificar que las contraseñas coincidan
    if ($contraseña === $confirmar_contraseña) {
        // Leer los datos actuales del archivo
        $usuarios = file_exists($file) ? json_decode(file_get_contents($file), true) : array();

        // Verificar si el usuario o correo ya existen
        foreach ($usuarios as $usuario_registrado) {
            if ($usuario_registrado['usuario'] === $usuario) {
                echo "<p class='text-center mt-3 text-danger'>El nombre de usuario ya está registrado.</p>";
                exit();
            }

            if ($usuario_registrado['correo'] === $correo) {
                echo "<p class='text-center mt-3 text-danger'>El correo electrónico ya está registrado.</p>";
                exit();
            }
        }

        // Crear un array con los datos del usuario
        $nuevo_usuario = array(
            'nombre' => $nombre,
            'apellido' => $apellido,
            'correo' => $correo,
            'usuario' => $usuario,
            'contraseña' => password_hash($contraseña, PASSWORD_DEFAULT) // Guardar la contraseña de forma segura
        );

        // Agregar el nuevo usuario
        $usuarios[] = $nuevo_usuario;

        // Guardar los datos actualizados en el archivo
        file_put_contents($file, json_encode($usuarios));

        // Después de registrar al usuario, redirigir a la página de inicio de sesión
        header("Location: index.php");
        exit(); // Asegúrate de que no haya más código después de la redirección
    } else {
        echo "<p class='text-center mt-3 text-danger'>Las contraseñas no coinciden.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center mt-5">Formulario de Registro</h2>
        <form action="registro.php" method="post">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="apellido">Apellido:</label>
                <input type="text" id="apellido" name="apellido" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="correo">Correo:</label>
                <input type="email" id="correo" name="correo" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="usuario">Usuario:</label>
                <input type="text" id="usuario" name="usuario" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="contraseña">Contraseña:</label>
                <input type="password" id="contraseña" name="contraseña" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="confirmar-contraseña">Confirmar Contraseña:</label>
                <input type="password" id="confirmar-contraseña" name="confirmar-contraseña" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Registrarse</button>
        </form>
        <p class="text-center mt-3">¿Ya tienes cuenta? <a href="index.php">Inicia sesión aquí</a></p>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
