<%@ page import="java.util.List" %>
<%@ page import="controladores.CategoriasJpaController" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Categorías</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            margin: 20px auto;
            display: flex;
            gap: 20px;
            justify-content: space-between;
        }

        .table-container, .form-container {
            width: 48%;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #6a4f39;
            color: white;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            margin: 5px 0;
            background-color: #6a4f39;
            color: white;
            border: none;
            cursor: pointer;
            text-align: center;
        }

        .btn:hover {
            background-color: #5c3e2f;
        }

        .delete-btn {
            background-color: #ff4f4f;
            color: white;
            border: none;
            cursor: pointer;
        }

        .delete-btn:hover {
            background-color: #ff3f3f;
        }

        .form-title {
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #6a4f39;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #5c3e2f;
        }
        
        
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
    <div class="container">
        
    
        <!-- Tabla de categorías existentes -->
        <div class="table-container">
            <h3>Categorías Existentes</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Iterar sobre la lista de categorías que se pasa en el request -->
                    <c:if test="${not empty categorias}">
                        <c:forEach var="categoria" items="${categorias}">
                            <tr>
                                <!-- Acceder a los elementos del array (posición 0 para ID y 1 para Nombre) -->
                                <td>${categoria[0]}</td>
                                <td>${categoria[1]}</td>
                                <td>
                                    <!-- Formulario de eliminación -->
                                    <form action="CategoriaServlet" method="get" style="display:inline;">
                                        <input type="hidden" name="idCategoria" value="${categoria[0]}">
                                        <input type="submit" value="Eliminar" class="btn delete-btn">
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Formulario para agregar una nueva categoría -->
        <div class="form-container">
            <h3 class="form-title">Agregar Nueva Categoría</h3>
            <form action="CategoriaServlet" method="post">
                <input type="text" name="nombreCategoria" placeholder="Nombre de la categoría" required>
                <input type="submit" value="Agregar" class="btn">
            </form>
        </div>
    </div>
</body>
</html>
