<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras</title>
    <style>
        /* Estilo general para el cuerpo de la página */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    color: #333;
}

/* Estilo para el encabezado */
h2 {
    background-color: #3E8E41;
    color: white;
    text-align: center;
    padding: 15px;
    margin-bottom: 20px;
    font-size: 2rem;
}

/* Estilo de la tabla */
table {
    width: 80%;
    margin: 0 auto 20px;
    border-collapse: collapse;
    background-color: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Estilo de los encabezados de la tabla */
table th {
    background-color: #3E8E41;
    color: white;
    padding: 12px 15px;
    text-align: center;
    font-size: 1.1rem;
    text-transform: uppercase;
}

/* Estilo para las filas de la tabla */
table td {
    padding: 12px 15px;
    text-align: center;
    border-top: 1px solid #ddd;
    font-size: 1rem;
}

/* Estilo para las filas al pasar el cursor */
table tr:hover {
    background-color: #f1f1f1;
}

/* Estilo para los botones dentro de la tabla */
button {
    background-color: #FF6347;
    color: white;
    border: none;
    padding: 8px 15px;
    font-size: 1rem;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #FF4500;
}

/* Estilo para el total */
h3 {
    text-align: right;
    margin-right: 20%;
    font-size: 1.4rem;
    color: #333;
    margin-top: 20px;
}

/* Estilo para el formulario de método de pago */
form {
    width: 80%;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

/* Estilo de las etiquetas dentro del formulario */
form label {
    font-size: 1.1rem;
    margin-bottom: 8px;
    display: block;
}

/* Estilo para los campos de texto y select dentro del formulario */
form input[type="text"], form input[type="number"], form textarea, form select {
    width: 100%;
    padding: 10px;
    font-size: 1rem;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* Estilo para el botón de finalizar compra */
form button[type="submit"] {
    background-color: #4CAF50;
    color: white;
    padding: 12px 20px;
    font-size: 1.2rem;
    cursor: pointer;
    border: none;
    border-radius: 5px;
    width: 100%;
    transition: background-color 0.3s;
}

form button[type="submit"]:hover {
    background-color: #45a049;
}

/* Estilo para los contenedores y el layout */
.container {
    width: 80%;
    margin: 0 auto;
}

/* Estilo para el espacio entre las secciones */
section {
    margin: 30px 0;
}

/* Estilo para las alertas (por si agregas mensajes de error o éxito) */
.alert {
    padding: 10px;
    color: white;
    background-color: #4CAF50;
    margin-bottom: 20px;
    border-radius: 5px;
}

.alert.error {
    background-color: #f44336;
}

.alert.success {
    background-color: #4CAF50;
}


    </style>
</head>
<body>
    <h2>Carrito de Compras</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Subtotal</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="detalle" items="${carrito}">
                <tr>
                    <td>${detalle.idProducto.nombre}</td>
                    <td>${detalle.cantidad}</td>
                    <td>${detalle.precioUnitario}</td>
                    <td>${detalle.subtotal}</td>
                    <td>
                        <form action="CarritoServlet" method="post">
                            <input type="hidden" name="idProducto" value="${detalle.idProducto.idProducto}">
                            <button type="submit" name="accion" value="eliminar">Eliminar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <h3>Total: ${carritoTotal}</h3>

    <form action="CarritoServlet" method="post">
        <label for="metodoPago">Método de Pago:</label>
        <select id="metodoPago" name="metodoPago" required>
            <option value="Tarjeta">Tarjeta</option>
            <option value="Efectivo">Efectivo</option>
            <option value="Transferencia">Transferencia</option>
        </select><br><br>
        
        <label for="dirreccion">Dirección:</label>
        <textarea id="dirreccion" name="dirreccion" required></textarea><br><br>
        
        <button type="submit" name="accion" value="finalizar">Finalizar Compra</button>
    </form>
</body>
</html>
