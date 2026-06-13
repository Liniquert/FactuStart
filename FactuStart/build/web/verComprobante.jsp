<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Comprobante"%>
<%@page import="modelo.DetalleComprobante"%>
<%@page import="modelo.Negocio"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Cliente"%>
<%@page import="dao.ComprobanteDAO"%>
<%@page import="dao.DetalleComprobanteDAO"%>
<%@page import="dao.NegocioDAO"%>
<%@page import="dao.ClienteDAO"%>
<%@page import="java.util.List"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if(usuario == null){
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    ComprobanteDAO dao = new ComprobanteDAO();
    Comprobante c = dao.buscarPorId(id);

    if(c == null){
        response.sendRedirect("historial.jsp");
        return;
    }

    NegocioDAO negocioDAO = new NegocioDAO();
    Negocio negocio = negocioDAO.buscarPorId(c.getIdNegocio());

    ClienteDAO clienteDAO = new ClienteDAO();
    Cliente cliente = clienteDAO.buscarPorId(c.getIdCliente());

    DetalleComprobanteDAO detalleDAO = new DetalleComprobanteDAO();
    List<DetalleComprobante> detalles = detalleDAO.listarPorComprobante(id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ver Comprobante</title>
    <link rel="stylesheet" href="css/estilos.css?v=11">
</head>

<body>

<div class="contenido" style="margin-left:0; max-width:950px; margin:auto;">

    <div class="card-form">

        <h2><%= c.getTipoComprobante() %> ELECTRÓNICA</h2>

        <h3><%= c.getSerie() %>-<%= c.getNumero() %></h3>

        <hr>

        <h3>Datos del emisor</h3>

        <% if(negocio != null){ %>
            <p><strong>Razón Social:</strong> <%= negocio.getRazonSocial() %></p>
            <p><strong>RUC:</strong> <%= negocio.getRuc() %></p>
            <p><strong>Dirección Fiscal:</strong> <%= negocio.getDireccionFiscal() %></p>
            <p><strong>Correo:</strong> <%= negocio.getCorreoContacto() %></p>
            <p><strong>Teléfono:</strong> <%= negocio.getTelefono() %></p>
        <% } %>

        <hr>

        <h3>Datos del cliente</h3>

        <% if(cliente != null){ %>
            <p><strong>Cliente / Razón Social:</strong> <%= cliente.getRazonSocialNombre() %></p>
            <p><strong>Tipo Documento:</strong> <%= cliente.getTipoDocumento() %></p>
            <p><strong>Número Documento:</strong> <%= cliente.getNumeroDocumento() %></p>

            <% if(cliente.getDireccion() != null && !cliente.getDireccion().isEmpty()){ %>
                <p><strong>Dirección:</strong> <%= cliente.getDireccion() %></p>
            <% } %>
        <% } else { %>
            <p>No se encontraron datos del cliente.</p>
        <% } %>

        <hr>

        <h3>Datos del comprobante</h3>

        <p><strong>Fecha:</strong> <%= c.getFechaEmision() %></p>
        <p><strong>Moneda:</strong> <%= c.getMoneda() %></p>
        <p><strong>Forma de pago:</strong> <%= c.getFormaPago() %></p>
        <p><strong>Estado:</strong> <%= c.getEstado() %></p>

        <hr>

        <h3>Detalle de productos / servicios</h3>

        <table class="tabla-comprobante">
            <thead>
                <tr>
                    <th>Descripción</th>
                    <th>Cantidad</th>
                    <th>Precio Unit.</th>
                    <th>Descuento</th>
                    <th>Subtotal</th>
                </tr>
            </thead>

            <tbody>
            <% for(DetalleComprobante d : detalles){ %>
                <tr>
                    <td><%= d.getDescripcion() %></td>
                    <td><%= d.getCantidad() %></td>
                    <td>S/ <%= String.format("%.2f", d.getPrecioUnitario()) %></td>
                    <td>S/ <%= String.format("%.2f", d.getDescuento()) %></td>
                    <td>S/ <%= String.format("%.2f", d.getSubtotal()) %></td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <hr>

        <h3>Resumen</h3>

        <p><strong>Subtotal:</strong> S/ <%= String.format("%.2f", c.getSubtotal()) %></p>
        <p><strong>IGV:</strong> S/ <%= String.format("%.2f", c.getIgv()) %></p>
        <p><strong>Total:</strong> S/ <%= String.format("%.2f", c.getTotal()) %></p>

        <br>

        <a href="historial.jsp" class="btn-link">Volver</a>

        <button onclick="window.print()" class="btn-dark" style="width:180px;">
            Imprimir / PDF
        </button>

    </div>

</div>

<% if(request.getParameter("imprimir") != null){ %>
<script>
    window.onload = function(){
        window.print();
    }
</script>
<% } %>

</body>
</html>