package servlet;

import controladores.CategoriasJpaController;
import controladores.exceptions.IllegalOrphanException;
import controladores.exceptions.NonexistentEntityException;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.Categorias;

@WebServlet(name = "CategoriaServlet", urlPatterns = {"/CategoriaServlet"})
public class CategoriaServlet extends HttpServlet {

    private CategoriasJpaController categoriasJpaController;

    @Override
    public void init() throws ServletException {
        // Inicializa el CategoriasJpaController al inicio
        categoriasJpaController = new CategoriasJpaController();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtiene el nombre de la categoría desde el formulario
        String nombreCategoria = request.getParameter("nombreCategoria");

        // Verifica que el nombre no sea nulo o vacío
        if (nombreCategoria == null || nombreCategoria.trim().isEmpty()) {
            // Si el nombre es inválido, redirige a una página de error
            response.sendRedirect("categoriaError.jsp");
            return;
        }

        // Crea una nueva instancia de Categorias
        Categorias nuevaCategoria = new Categorias();
        nuevaCategoria.setNombreCategoria(nombreCategoria);

        // Intenta guardar la nueva categoría usando el JpaController
        try {
            // Llama al método create del controlador JPA
            categoriasJpaController.create(nuevaCategoria);
            // Si se guarda correctamente, redirige a la página de éxito
            response.sendRedirect("CategoriaServlet");
        } catch (Exception e) {
            // En caso de error, muestra el error y redirige a la página de error
            e.printStackTrace();
            response.sendRedirect("categoriaError.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar si el parámetro de eliminación está presente
        String idCategoriaParam = request.getParameter("idCategoria");

        // Si el parámetro está presente, proceder con la eliminación
        if (idCategoriaParam != null) {
            int idCategoria = Integer.parseInt(idCategoriaParam);

            try {
                // Eliminar la categoría con el ID correspondiente
                categoriasJpaController.destroy(idCategoria);
            } catch (NonexistentEntityException ex) {
                Logger.getLogger(CategoriaServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalOrphanException ex) {
                Logger.getLogger(CategoriaServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            // Redirigir después de la eliminación
            response.sendRedirect("CategoriaServlet");
            return; // Salir de la ejecución para evitar redirecciones adicionales
        }

        // Obtener la lista actualizada de categorías
        List<Object[]> categorias = categoriasJpaController.findCategoriasIdAndName();

        // Establecer las categorías como atributo de la solicitud
        request.setAttribute("categorias", categorias);

        // Redirigir a la página JSP donde se mostrarán las categorías
        request.getRequestDispatcher("Categoria.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que maneja la creación y eliminación de categorías";
    }
}
