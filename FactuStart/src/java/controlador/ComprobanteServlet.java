package controlador;

import dao.ComprobanteDAO;
import dao.DetalleComprobanteDAO;
import dao.NegocioDAO;
import dao.ClienteDAO;

import modelo.Comprobante;
import modelo.DetalleComprobante;
import modelo.Negocio;
import modelo.Usuario;
import modelo.Cliente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ComprobanteServlet", urlPatterns = {"/ComprobanteServlet"})
public class ComprobanteServlet extends HttpServlet {

    ComprobanteDAO comprobanteDAO = new ComprobanteDAO();
    DetalleComprobanteDAO detalleDAO = new DetalleComprobanteDAO();
    NegocioDAO negocioDAO = new NegocioDAO();
    ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Negocio negocio = negocioDAO.buscarPorUsuario(usuario.getIdUsuario());

        if (negocio == null) {
            response.sendRedirect("configuracionInicial.jsp");
            return;
        }

        String tipo = request.getParameter("tipoComprobante");

        Cliente cliente = new Cliente();
        cliente.setIdNegocio(negocio.getIdNegocio());

        if ("BOLETA".equals(tipo)) {

            String nombreCliente = request.getParameter("nombreCliente");
            String documentoCliente = request.getParameter("documentoCliente");

            cliente.setTipoDocumento("DNI");
            cliente.setNumeroDocumento(documentoCliente);
            cliente.setRazonSocialNombre(nombreCliente);
            cliente.setDireccion("");
            cliente.setEmail("");
            cliente.setTelefono("");

        } else if ("FACTURA".equals(tipo)) {

            String razonSocialCliente = request.getParameter("razonSocialCliente");
            String rucCliente = request.getParameter("rucCliente");
            String direccionFiscalCliente = request.getParameter("direccionFiscalCliente");

            cliente.setTipoDocumento("RUC");
            cliente.setNumeroDocumento(rucCliente);
            cliente.setRazonSocialNombre(razonSocialCliente);
            cliente.setDireccion(direccionFiscalCliente);
            cliente.setEmail("");
            cliente.setTelefono("");
        }

        int idCliente = clienteDAO.obtenerOCrearCliente(cliente);

        if (idCliente == 0) {
            response.sendRedirect("comprobantes.jsp?error=cliente");
            return;
        }

        String[] descripciones = request.getParameterValues("descripcion");
        String[] cantidades = request.getParameterValues("cantidad");
        String[] precios = request.getParameterValues("precio");

        double subtotalGeneral = 0;

        List<DetalleComprobante> detalles = new ArrayList<>();

        if (descripciones != null) {
            for (int i = 0; i < descripciones.length; i++) {

                String descripcion = descripciones[i];

                if (descripcion == null || descripcion.trim().isEmpty()) {
                    continue;
                }

                int cantidad = Integer.parseInt(cantidades[i]);
                double precio = Double.parseDouble(precios[i]);
                double subtotal = cantidad * precio;

                DetalleComprobante detalle = new DetalleComprobante();

                detalle.setDescripcion(descripcion);
                detalle.setCantidad(cantidad);
                detalle.setPrecioUnitario(precio);
                detalle.setDescuento(0);
                detalle.setSubtotal(subtotal);

                detalles.add(detalle);

                subtotalGeneral += subtotal;
            }
        }

        double igv = 0;
        double total = subtotalGeneral;

        if ("FACTURA".equals(tipo)) {
            igv = subtotalGeneral * 0.18;
            total = subtotalGeneral + igv;
        }

        int siguiente = comprobanteDAO.obtenerSiguienteNumero(tipo);

        String serie = "BOLETA".equals(tipo) ? "B001" : "F001";
        String numero = String.format("%08d", siguiente);

        Comprobante comprobante = new Comprobante();

        comprobante.setIdNegocio(negocio.getIdNegocio());
        comprobante.setIdCliente(idCliente);
        comprobante.setTipoComprobante(tipo);
        comprobante.setSerie(serie);
        comprobante.setNumero(numero);
        comprobante.setMoneda("PEN");
        comprobante.setSubtotal(subtotalGeneral);
        comprobante.setIgv(igv);
        comprobante.setTotal(total);
        comprobante.setFormaPago("CONTADO");
        comprobante.setEstado("EMITIDO");
        comprobante.setObservacion("Comprobante generado desde FactuStart");

        int idComprobante = comprobanteDAO.registrar(comprobante);

        if (idComprobante > 0) {

            for (DetalleComprobante d : detalles) {
                d.setIdComprobante(idComprobante);
            }

            detalleDAO.registrarDetalles(detalles);

            response.sendRedirect("comprobantes.jsp?exito=1&serie=" + serie + "&numero=" + numero);

        } else {
            response.sendRedirect("comprobantes.jsp?error=1");
        }
    }
}