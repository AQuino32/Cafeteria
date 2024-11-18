package controladores;

import modelos.Ventas;
import modelos.Usuario;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VentaServlet")
public class VentaServlet extends HttpServlet {

    private VentasJpaController ventasController = new VentasJpaController();
    private UsuarioJpaController usuarioController = new UsuarioJpaController();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuario> usuarios = usuarioController.findUsuariosEntities();
        request.setAttribute("usuarios", usuarios);
        
        String fechaActual = java.time.LocalDate.now().toString();
        request.setAttribute("fechaActual", fechaActual);
        
        request.getRequestDispatcher("/venta.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String fecha = request.getParameter("fecha");
            BigDecimal total = new BigDecimal(request.getParameter("total"));
            String metodoPago = request.getParameter("metodoPago");
            String direccion = request.getParameter("dirreccion");

            // Crear objeto Venta
            Usuario usuario = usuarioController.findUsuario(idUsuario);
            Ventas venta = new Ventas();
            venta.setIdUsuario(usuario);
            venta.setFecha(java.sql.Date.valueOf(fecha));
            venta.setTotal(total);
            venta.setMetodoPago(metodoPago);
            venta.setDirreccion(direccion);

            // Guardar la venta
            ventasController.create(venta);
            
            // Redirigir a la página de confirmación o lista de ventas
            response.sendRedirect("VentasListServlet");  // Asegúrate de tener un servlet que liste las ventas
        } catch (Exception e) {
            request.setAttribute("error", "Error al registrar la venta: " + e.getMessage());
            doGet(request, response);
        }
    }
}
