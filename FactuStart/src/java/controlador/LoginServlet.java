package controlador;

import dao.UsuarioDAO;
import dao.NegocioDAO;
import modelo.Usuario;
import modelo.Negocio;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    UsuarioDAO usuarioDAO = new UsuarioDAO();
    NegocioDAO negocioDAO = new NegocioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Usuario usuario = usuarioDAO.validarLogin(email, password);

        if (usuario != null) {

            HttpSession sesion = request.getSession(true);
            sesion.setAttribute("usuario", usuario);

            Negocio negocio = negocioDAO.buscarPorUsuario(usuario.getIdUsuario());

            if (negocio == null) {
                response.sendRedirect(request.getContextPath() + "/configuracionInicial.jsp");
            } else {
                sesion.setAttribute("negocio", negocio);
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}