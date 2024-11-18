/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import controladores.ProductosJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.Categorias;
import modelos.Productos;

/**
 *
 * @author Edgar
 */
@WebServlet(name = "ProductosServlet", urlPatterns = {"/ProductosServlet"})
public class ProductosServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductosServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductosServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    if ("delete".equals(action)) {
        int productoId = Integer.parseInt(request.getParameter("id"));
        eliminarProducto(productoId);
        response.sendRedirect("ProductosServlet"); // Redirige después de eliminar
    } else {
        listarProductos(request, response);
    }
}

// Método para eliminar un producto
private void eliminarProducto(int productoId) {
    ProductosJpaController controller = new ProductosJpaController();
    try {
        Productos producto = controller.findProductos(productoId);
        if (producto != null) {
            controller.destroy(productoId);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}

// Método para listar productos
private void listarProductos(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    ProductosJpaController controller = new ProductosJpaController();
    List<Productos> productosList = controller.findProductosEntities();

    // Enviar los productos a la vista
    request.setAttribute("productos", productosList);
    request.getRequestDispatcher("productos.jsp").forward(request, response);
}



    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Obtener los parámetros del formulario
    String nombreProducto = request.getParameter("nombreProducto");
    BigDecimal precio = new BigDecimal(request.getParameter("precio"));
    String descripcion = request.getParameter("descripcion");
    Integer categoriaId = Integer.valueOf(request.getParameter("categoria"));
    Integer stock = Integer.valueOf(request.getParameter("stock"));
    BigDecimal promocion = new BigDecimal(request.getParameter("promocion"));
    // Puedes agregar la lógica para manejar la imagen más tarde si es necesario.

    // Crear un objeto Producto
    Productos producto = new Productos();
    producto.setNombreProducto(nombreProducto);
    producto.setPrecio(precio);
    producto.setDescripción(descripcion);
    producto.setStock(stock);
    producto.setPromoción(promocion);

    // Recuperar la categoría seleccionada desde la base de datos
    Categorias categoria = new Categorias(); // Instancia de la clase Categorias
    categoria.setIdCategoria(categoriaId);
    producto.setIDCategoria(categoria);

    // Guardar el producto en la base de datos
    ProductosJpaController controller = new ProductosJpaController();
    try {
        controller.create(producto);
        response.sendRedirect("ProductosServlet"); // Redirige después de agregar
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp"); // Redirige si ocurre un error
    }
}


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
