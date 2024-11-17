<?php
session_start();

// Verifica si el usuario está logueado
if (!isset($_SESSION['usuario'])) {
    header("Location: index.php"); // Redirige si no está logueado
    exit();
}

// Lista de productos
$productos = array(
    'Cemento' => 'Cemento de alta calidad para construcción',
    'Ladrillos' => 'Ladrillos resistentes para muros',
    'Madera' => 'Madera tratada para estructuras',
    'Varilla' => 'Varilla de acero para refuerzo'
);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos de Construcción</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Productos de Construcción</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="main.php">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php">Cerrar sesión</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Contenido de productos -->
    <div class="container mt-5">
        <h2 class="text-center">Nuestros Productos</h2>
        <div class="row">
            <?php foreach ($productos as $nombre => $descripcion): ?>
                <div class="col-md-3 mb-4">
                    <div class="card">
                        <img src="path/to/placeholder-image.jpg" class="card-img-top" alt="Imagen del producto">
                        <div class="card-body">
                            <h5 class="card-title"><?= $nombre ?></h5>
                            <p class="card-text"><?= $descripcion ?></p>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
