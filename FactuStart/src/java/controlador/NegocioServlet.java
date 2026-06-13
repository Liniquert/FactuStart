package controlador;

import dao.NegocioDAO;
import modelo.Negocio;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "NegocioServlet", urlPatterns = {"/NegocioServlet"})
public class NegocioServlet extends HttpServlet {

    NegocioDAO negocioDAO = new NegocioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Negocio negocio = new Negocio();

        negocio.setIdUsuario(usuario.getIdUsuario());
        negocio.setRazonSocial(request.getParameter("razonSocial"));
        negocio.setRuc(request.getParameter("ruc"));
        negocio.setDireccionFiscal(request.getParameter("direccionFiscal"));
        negocio.setCorreoContacto(request.getParameter("correoContacto"));
        negocio.setTelefono(request.getParameter("telefono"));
        negocio.setEstado("ACTIVO");

        boolean registrado = negocioDAO.registrar(negocio);

        if (registrado) {
            sesion.setAttribute("negocio", negocio);
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/configuracionInicial.jsp?error=1");
        }
    }
}