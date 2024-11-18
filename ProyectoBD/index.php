<?php
// Conexión a la base de datos Oracle
$conn = oci_connect('SYSTEM', 'bdpalosrancios', 'localhost'); 

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nombre_usuario = $_POST['NOMBRE_USUARIO'];
    $contrasena = $_POST['CONTRASENA'];

    $stid = oci_parse($conn, "SELECT * FROM USUARIOS WHERE NOMBRE_USUARIO = :NOMBRE_USUARIO");
    oci_bind_by_name($stid, ':NOMBRE_USUARIO', $nombre_usuario);
    oci_execute($stid);

    $usuario = oci_fetch_assoc($stid);

    if ($usuario && password_verify($contrasena, $usuario['CONTRASENA'])) {
        // Redirigir a la página de inicio según el rol
        session_start();
        $_SESSION['usuario'] = $usuario['NOMBRE_USUARIO'];
        $_SESSION['rol'] = $usuario['ROL'];
        header("Location: inicio.php");
        exit;
    } else {
        $error = "Usuario o contraseña incorrectos.";
    }
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .side-image {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            z-index: -1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Iniciar Sesión</h2>
            <?php if (isset($error)): ?>
                <div class="alert alert-danger" role="alert">
                    <?php echo $error; ?>
                </div>
            <?php endif; ?>
            <form method="POST" action="">
                <div class="mb-3">
                    <label for="nombre_usuario" class="form-label">Nombre Usuario</label>
                    <input type="text" class="form-control" id="nombre_usuario" name="nombre_usuario" required>
                </div>
                <div class="mb-3">
                    <label for="contrasena" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                </div>
                <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
            </form>
        </div>
    </div>
</body>
</html>
