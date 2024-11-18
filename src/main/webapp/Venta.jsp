<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Venta</title>
    <style>
        /* Estilos generales */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Contenedor principal */
        .container {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            border-radius: 8px;
        }

        /* Título */
        .title {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* Estilo para el formulario */
        .form {
            display: flex;
            flex-direction: column;
        }

        /* Estilo para los grupos de elementos del formulario */
        .form-group {
            margin-bottom: 15px;
        }

        /* Estilo para las etiquetas */
        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }

        /* Estilo para los campos de entrada */
        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
            color: #333;
        }

        /* Estilo para el botón */
        .btn {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        /* Estilo para el textarea */
        textarea {
            resize: vertical;
            min-height: 100px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="title">Registrar Venta</h2>
        <form action="VentaServlet" method="post" class="form">
            <div class="form-group">
                <label for="idUsuario">Usuario:</label>
                <select id="idUsuario" name="idUsuario" required>
                    <c:forEach var="usuario" items="${usuarios}">
                        <option value="${usuario.id}">${usuario.nombre}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="fecha">Fecha:</label>
                <input type="date" id="fecha" name="fecha" value="${fechaActual}" required>
            </div>

            <div class="form-group">
                <label for="total">Total:</label>
                <input type="number" id="total" name="total" step="0.01" required>
            </div>

            <div class="form-group">
                <label for="metodoPago">Método de Pago:</label>
                <select id="metodoPago" name="metodoPago" required>
                    <option value="Tarjeta">Tarjeta</option>
                    <option value="Efectivo">Efectivo</option>
                    <option value="Transferencia">Transferencia</option>
                </select>
            </div>

            <div class="form-group">
                <label for="dirreccion">Dirección:</label>
                <textarea id="dirreccion" name="dirreccion" required></textarea>
            </div>

            <div class="form-group">
                <button type="submit" class="btn">Registrar Venta</button>
            </div>
        </form>
    </div>
</body>
</html>
