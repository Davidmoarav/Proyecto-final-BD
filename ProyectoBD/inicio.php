<?php
session_start();

// Asegúrate de que el usuario esté autenticado
if (!isset($_SESSION['usuario'])) {
    header("Location: index.php");
    exit;
}

// Obtener el rol del usuario
$rol = $_SESSION['rol'];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página de Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Bienvenido, <?php echo $_SESSION['usuario']; ?></h1>
        <h2>Rol: <?php echo $rol; ?></h2>

        <div class="mt-4">
            <?php if ($rol == 'admin'): ?>
                <a href="registro_materiales.php" class="btn btn-primary">Registro de Materiales</a>
                <a href="registro_ventas.php" class="btn btn-primary">Registros de Ventas</a>
                <a href="calculo_comision.php" class="btn btn-primary">Cálculo de Comisión</a>
            <?php elseif ($rol == 'vendedor'): ?>
                <a href="registro_ventas.php" class="btn btn-primary">Registros de Ventas</a>
            <?php elseif ($rol == 'bodeguero'): ?>
                <a href="registro_materiales.php" class="btn btn-primary">Registro de Materiales</a>
            <?php else: ?>
                <p>No tienes permisos para acceder a estas opciones.</p>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>
