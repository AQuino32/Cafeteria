<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menú</title>
        <style>
            /* Estilo general */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                color: #333;
            }

            /* Contenedor del menú */
            .menu {
                position: fixed;
                bottom: 0;
                width: 100%;
                background-color: #6a4f39; /* Color café */
                box-shadow: 0 -4px 6px rgba(0, 0, 0, 0.1);
                padding: 10px 0; /* Espaciado adicional */
            }

            .menu ul {
                list-style: none;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: space-around;
                align-items: center;
            }

            .menu li {
                text-align: center;
                flex: 1;
            }

            .menu a {
                text-decoration: none;
                color: white;
                font-size: 1rem; /* Tamaño de fuente ligeramente mayor */
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 15px; /* Espaciado interno más grande */
                transition: transform 0.3s, background 0.3s;
            }

            .menu a:hover {
                transform: scale(1.1);
                background-color: #5c3e2f; /* Color café más oscuro */
                border-radius: 10px;
            }

            /* Íconos */
            .icon {
                font-size: 1.5rem;
                margin-bottom: 5px;
            }

            /* Efecto responsivo */
            @media (min-width: 768px) {
                .menu ul {
                    max-width: 600px;
                    margin: 0 auto;
                }
            }
        </style>
    </head>
    <body>
        <nav class="menu">
            <ul>
                <li><a href="CategoriaServlet">Categoría</a></li>
                <li><a href="ProductosServlet">Productos</a></li>
                <li><a href="#about">Acerca</a></li>
                <li><a href="#contact">Contacto</a></li>
            </ul>
        </nav>
    </body>
</html>
