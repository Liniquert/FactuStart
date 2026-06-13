package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
public class RegistroServlet extends HttpServlet {

    UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreCompleto = request.getParameter("nombreCompleto");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (usuarioDAO.existeEmail(email)) {
            response.sendRedirect(request.getContextPath() + "/registro.jsp?error=email");
            return;
        }

        Usuario usuario = new Usuario();

        usuario.setNombreCompleto(nombreCompleto);
        usuario.setEmail(email);
        usuario.setPasswordHash(password);
        usuario.setRol("EMPRENDEDOR");
        usuario.setEstado("ACTIVO");

        boolean registrado = usuarioDAO.registrar(usuario);

        if (registrado) {

            Usuario usuarioLogin = usuarioDAO.validarLogin(email, password);

            HttpSession sesion = request.getSession(true);
            sesion.setAttribute("usuario", usuarioLogin);

            response.sendRedirect(request.getContextPath() + "/configuracionInicial.jsp");

        } else {
            response.sendRedirect(request.getContextPath() + "/registro.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/registro.jsp");
    }
}