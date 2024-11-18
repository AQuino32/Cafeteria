<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }

        .container {
            margin-top: 20px;
        }

        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
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
            margin-top: 10px;
        }

        .search-bar {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Formulario para agregar un nuevo producto -->
    <div class="form-container">
        <h3>Agregar Producto</h3>
        <form action="ProductosServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="nombreProducto">Nombre del Producto:</label>
                <input type="text" class="form-control" id="nombreProducto" name="nombreProducto" required>
            </div>
            <div class="form-group">
                <label for="precio">Precio:</label>
                <input type="number" step="0.01" class="form-control" id="precio" name="precio" required>
            </div>
            <div class="form-group">
                <label for="descripcion">Descripción:</label>
                <textarea class="form-control" id="descripcion" name="descripcion"></textarea>
            </div>
            <div class="form-group">
                <label for="categoria">Categoría:</label>
                <select class="form-control" id="categoria" name="categoria">
                    <c:forEach var="categoria" items="${categorias}">
                        <option value="${categoria.idCategoria}">${categoria.nombreCategoria}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="stock">Stock:</label>
                <input type="number" class="form-control" id="stock" name="stock" required>
            </div>
            <div class="form-group">
                <label for="promocion">Promoción:</label>
                <input type="number" step="0.01" class="form-control" id="promocion" name="promocion">
            </div>
            <div class="form-group">
                <label for="imagenURL">Selecciona una Imagen:</label>
                <input type="file" id="imagenURL" name="imagenURL" accept="image/*" class="btn btn-primary">
            </div>
            <button type="submit" class="btn btn-primary">Agregar Producto</button>
        </form>
    </div>

    <!-- Tabla para listar productos -->
    <div class="form-container">
        <h3>Productos Existentes</h3>  
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Categoría</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty productos}">
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>${producto.iDProducto}</td>
                            <td>${producto.nombreProducto}</td>
                            <td>${producto.precio}</td>
                            <td>${producto.stock}</td>
                            <td>${producto.iDCategoria.nombreCategoria}</td>
                            <td>
                                <form action="ProductoServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="idProducto" value="${producto.iDProducto}">
                                    <input type="submit" value="Eliminar" class="btn btn-danger">
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(event) {
        let nombreProducto = document.getElementById('nombreProducto').value;
        let precio = document.getElementById('precio').value;
        let stock = document.getElementById('stock').value;

        if (!nombreProducto || !precio || !stock) {
            alert('Por favor, complete todos los campos requeridos.');
            event.preventDefault();
        }
    });
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
