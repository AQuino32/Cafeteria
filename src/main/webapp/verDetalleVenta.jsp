<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del Pedido</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding-top: 50px;
        }
        h2, h3 {
            color: #333;
        }
        .order-info, .shipping-info, .product-list {
            background: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .order-info p, .shipping-info p {
            font-size: 1.1rem;
            margin: 10px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .boton {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .boton:hover {
            background-color: #45a049;
        }
        .bnt-imprimir {
            background-color: bisque;
        }
        .bnt-imprimir:hover {
            background-color: bisque;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2>Detalle del Pedido #<c:out value="${id}"/></h2>

    <div class="order-info">
        <h3>Información del Pedido</h3>
        <p><strong>Número de Pedido: </strong><c:out value="${id}"/></p>
        <p><strong>Fecha del Pedido: </strong><c:out value="${formato}"/></p>
        <p><strong>Método de Pago: </strong><c:out value="${metodo_pago}"/></p>
        <p><strong>Total: </strong><c:out value="${total}"/></p>
    </div>

    <div class="shipping-info">
        <h3>Información de Envío</h3>
        <p><strong>Dirección de Envío: </strong><c:out value="${direccion}"/></p>
        <p><strong>Número de Seguimiento: </strong><c:out value="${id}"/></p>
    </div>

    <div class="product-list">
        <h3>Ventas de la semana</h3>
        <table>
            <thead>
                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Unitario</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detalle" items="${detalles}">
                    <tr>
                        <td><c:out value="${detalle.producto}"/></td>
                        <td><c:out value="${detalle.cantidad}"/></td>
                        <td><c:out value="${detalle.precioUnitario}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="Ajustes" class="bnt boton">Volver a Perfil</a>
        <a href="javascript:window.print()" class="bnt bnt-imprimir boton">Imprimir Reporte</a>
    </div>
</div>

</body>
</html>
