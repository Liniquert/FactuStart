<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Comprobante"%>
<%@page import="modelo.Negocio"%>
<%@page import="dao.ComprobanteDAO"%>
<%@page import="dao.NegocioDAO"%>
<%@page import="java.util.List"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if(usuario == null){
        response.sendRedirect("login.jsp");
        return;
    }

    NegocioDAO negocioDAO = new NegocioDAO();
    Negocio negocio = negocioDAO.buscarPorUsuario(usuario.getIdUsuario());

    if(negocio == null){
        response.sendRedirect("configuracionInicial.jsp");
        return;
    }

    int idNegocio = negocio.getIdNegocio();

    ComprobanteDAO dao = new ComprobanteDAO();

    double ventasDia = dao.obtenerVentasDelDiaPorNegocio(idNegocio);
    int comprobantesDia = dao.obtenerComprobantesDelDiaPorNegocio(idNegocio);

    List<Comprobante> ultimos = dao.listarUltimosPorNegocio(idNegocio, 5);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard FactuStart</title>
    <link rel="stylesheet" href="css/estilos.css?v=31">
</head>

<body>

<div class="sidebar">
    <div class="logo">
        Facturación<br>
        <small><%= negocio.getRazonSocial() %></small>
    </div>

    <div class="menu">
        <a href="dashboard.jsp" class="activo">Dashboard</a>
        <a href="comprobantes.jsp">Emitir comprobante</a>
        <a href="historial.jsp">Historial</a>
        <a href="reportes.jsp">Reportes</a>
        <a href="sunat.jsp">SUNAT</a>
        <a href="configuracion.jsp">Configuración</a>
    </div>
</div>

<div class="contenido">

    <div class="header">
        <div>
            <h2>Panel principal</h2>
            <p>Bienvenido al sistema de facturación</p>
        </div>

        <div>
            Usuario<br>
            <strong><%= usuario.getEmail() %></strong>
        </div>
    </div>

    <div class="cards">

        <div class="card">
            <h3>Ventas del día</h3>
            <h2>S/ <%= String.format("%.2f", ventasDia) %></h2>
        </div>

        <div class="card">
            <h3>Comprobantes emitidos</h3>
            <h2><%= comprobantesDia %></h2>
        </div>

        <div class="card">
            <h3>Estado SUNAT</h3>
            <h2 style="color:green;">● Conectado</h2>
        </div>

    </div>

    <div class="acciones">

        <a href="comprobantes.jsp" class="accion dark enlace-card">
            <h3>Emitir comprobante</h3>
            <p>Crea una nueva factura o boleta</p>
        </a>

        <a href="reportes.jsp" class="accion enlace-card">
            <h3>Ver reportes</h3>
            <p>Consulta tus estadísticas</p>
        </a>

    </div>

    <div class="actividad">

        <h3>Actividad reciente</h3>

        <% if(ultimos == null || ultimos.isEmpty()){ %>

            <p>No hay actividad reciente</p>
            <small>Los comprobantes emitidos aparecerán aquí</small>

        <% } else { %>

            <table class="tabla-comprobante">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Número</th>
                        <th>Fecha</th>
                        <th>Total</th>
                        <th>Estado</th>
                    </tr>
                </thead>

                <tbody>
                <% for(Comprobante c : ultimos){ %>
                    <tr>
                        <td><%= c.getTipoComprobante() %></td>
                        <td><%= c.getSerie() %>-<%= c.getNumero() %></td>
                        <td><%= c.getFechaEmision() %></td>
                        <td>S/ <%= String.format("%.2f", c.getTotal()) %></td>
                        <td><%= c.getEstado() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>

        <% } %>

    </div>

</div>

</body>
</html>