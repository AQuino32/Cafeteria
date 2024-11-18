package servlet;

import controladores.ProductosJpaController;
import controladores.VentasJpaController;
import controladores.DetallesVentaJpaController;
import controladores.ProductosJpaController;
import controladores.VentasJpaController;
import modelos.Productos;
import modelos.Ventas;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Date;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.DetallesVenta;
import modelos.Usuario;

@WebServlet(name = "CarritoServlet", urlPatterns = {"/CarritoServlet"})
public class CarritoServlet extends HttpServlet {

    @PersistenceContext(unitName = "miUnidadDePersistencia")
    private EntityManager em; // Inyección de EntityManager para JPA

    // Inyectamos los controladores de JPA
    @Inject
    private ProductosJpaController productoJpaController;

    @Inject
    private VentasJpaController ventaJpaController;

    @Inject
    private DetallesVentaJpaController detallesVentaJpaController;

    // Este método se ejecuta cuando se accede al carrito
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la sesión y el carrito (si no existe, se crea uno nuevo)
        HttpSession session = request.getSession();
        Map<Integer, DetallesVenta> carrito = (Map<Integer, DetallesVenta>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new HashMap<>();
            session.setAttribute("carrito", carrito);
        }

        // Mostrar carrito con productos
        request.setAttribute("carrito", carrito.values());
        request.getRequestDispatcher("/carrito.jsp").forward(request, response);
    }

    // Este método maneja las peticiones POST (agregar, eliminar, finalizar compra)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        // Obtener la sesión del usuario
        HttpSession session = request.getSession();
        Map<Integer, DetallesVenta> carrito = (Map<Integer, DetallesVenta>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new HashMap<>();
            session.setAttribute("carrito", carrito);
        }

        if ("agregar".equals(accion)) {
            // Obtener el producto y la cantidad desde los parámetros
            Integer idProducto = Integer.parseInt(request.getParameter("idProducto"));
            Integer cantidad = Integer.parseInt(request.getParameter("cantidad"));

            // Buscar el producto en la base de datos
            Productos producto = productoJpaController.findProducto(idProducto);

            if (producto != null) {
                // Crear un detalle de venta para este producto
                DetallesVenta detalle = new DetallesVenta();
                detalle.setIDProducto(producto);
                detalle.setCantidad(cantidad);
                detalle.setPrecioUnitario(producto.getPrecio());
                

                // Agregar el detalle al carrito
                carrito.put(producto.getIDProducto(), detalle);
            }

            // Redirigir al carrito para mostrar los productos
            response.sendRedirect("CarritoServlet");

        } else if ("eliminar".equals(accion)) {
            // Obtener el ID del producto a eliminar
            Integer idProducto = Integer.parseInt(request.getParameter("idProducto"));
            carrito.remove(idProducto);
            response.sendRedirect("CarritoServlet");

        } else if ("finalizar".equals(accion)) {
            // Finalizar la compra (crear la venta y los detalles)
            Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

            if (usuario != null) {
                // Crear la venta
                Ventas venta = new Ventas();
                venta.setIdUsuario(usuario);
                venta.setFecha(new Date());
                venta.setMetodoPago(request.getParameter("metodoPago"));
                venta.setDirreccion(request.getParameter("dirreccion"));

                // Calcular el total de la venta
                BigDecimal total = BigDecimal.ZERO;
                for (DetallesVenta detalle : carrito.values()) {
                    total = total.add(detalle.getSubtotal());
                }
                venta.setTotal(total);

                // Persistir la venta
                ventaJpaController.create(venta);

                // Persistir los detalles de la venta
                for (DetallesVenta detalle : carrito.values()) {
                    detalle.setIdVenta(venta); // Asociamos cada detalle a la venta
                    detallesVentaJpaController.create(detalle);
                }

                // Limpiar el carrito
                carrito.clear();

                // Redirigir a la página de confirmación
                response.sendRedirect("venta_confirmada.jsp");
            } else {
                // Si el usuario no está logueado, redirigir al login
                response.sendRedirect("login.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para manejar el carrito de compras.";
    }
}
