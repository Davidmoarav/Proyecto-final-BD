<?php
session_start();

// Ruta del archivo donde se guardan los usuarios
$file = 'usuarios.json';

// Verificar si el archivo existe y si su contenido es un arreglo
if (file_exists($file)) {
    $usuarios = json_decode(file_get_contents($file), true); // Decodificar el archivo JSON a un arreglo

    // Si no es un arreglo válido, inicializarlo como un arreglo vacío
    if (!is_array($usuarios)) {
        $usuarios = [];
    }
} else {
    // Si el archivo no existe, inicializar como un arreglo vacío
    $usuarios = [];
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $usuario = htmlspecialchars($_POST["usuario"]);
    $contraseña = htmlspecialchars($_POST["contraseña"]);

    // Buscar el usuario en el arreglo
    $usuario_encontrado = false;
    foreach ($usuarios as $usuario_registrado) {
        if ($usuario_registrado['usuario'] == $usuario && password_verify($contraseña, $usuario_registrado['contraseña'])) {
            $_SESSION['usuario'] = $usuario; // Guardar el nombre de usuario en la sesión
            $usuario_encontrado = true;
            break;
        }
    }

    // Si el usuario se encuentra y la contraseña es correcta
    if ($usuario_encontrado) {
        // Redirigir a la página principal (main.php)
        header("Location: main.php");
        exit();
    } else {
        echo "<p class='text-center mt-3 text-danger'>Usuario o contraseña incorrectos.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row justify-content-center align-items-center" style="height: 100vh;">
            <div class="col-md-4">
                <div class="form-container">
                    <h2 class="text-center">Iniciar sesión</h2>

                    <!-- Formulario de inicio de sesión -->
                    <form action="index.php" method="post">
                        <div class="form-group">
                            <label for="usuario">Usuario:</label>
                            <input type="text" id="usuario" name="usuario" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="contraseña">Contraseña:</label>
                            <input type="password" id="contraseña" name="contraseña" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Iniciar sesión</button>
                    </form>

                    <p class="text-center mt-3">
                        ¿No tienes cuenta? <a href="registro.php">Regístrate aquí</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
