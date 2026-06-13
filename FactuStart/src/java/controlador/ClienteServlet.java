package controlador;

import dao.ClienteDAO;
import modelo.Cliente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {

    ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {

            case "listar":
                request.setAttribute("clientes", clienteDAO.listar());
                request.getRequestDispatcher("clientes.jsp").forward(request, response);
                break;

            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Cliente cliente = clienteDAO.buscarPorId(idEditar);
                request.setAttribute("cliente", cliente);
                request.setAttribute("clientes", clienteDAO.listar());
                request.getRequestDispatcher("clientes.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                clienteDAO.eliminar(idEliminar);
                response.sendRedirect("ClienteServlet?accion=listar");
                break;

            default:
                response.sendRedirect("ClienteServlet?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idCliente = request.getParameter("idCliente");

        Cliente cliente = new Cliente();

        cliente.setIdNegocio(1);
        cliente.setTipoDocumento(request.getParameter("tipoDocumento"));
        cliente.setNumeroDocumento(request.getParameter("numeroDocumento"));
        cliente.setRazonSocialNombre(request.getParameter("razonSocialNombre"));
        cliente.setDireccion(request.getParameter("direccion"));
        cliente.setEmail(request.getParameter("email"));
        cliente.setTelefono(request.getParameter("telefono"));

        if (idCliente == null || idCliente.isEmpty()) {

            clienteDAO.registrar(cliente);

        } else {

            cliente.setIdCliente(Integer.parseInt(idCliente));
            clienteDAO.actualizar(cliente);
        }

        response.sendRedirect("ClienteServlet?accion=listar");
    }
}