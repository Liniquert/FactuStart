<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dao.ComprobanteDAO"%>
<%@page import="dao.NegocioDAO"%>
<%@page import="modelo.Comprobante"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Negocio"%>

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

    ComprobanteDAO dao = new ComprobanteDAO();
    List<Comprobante> lista = dao.listarPorNegocio(negocio.getIdNegocio());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historial de Comprobantes</title>
    <link rel="stylesheet" href="css/estilos.css?v=40">
</head>

<body>

<div class="sidebar">
    <div class="logo">
        Facturación<br>
        <small><%= negocio.getRazonSocial() %></small>
    </div>

    <div class="menu">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="comprobantes.jsp">Emitir comprobante</a>
        <a href="historial.jsp" class="activo">Historial</a>
        <a href="reportes.jsp">Reportes</a>
        <a href="sunat.jsp">SUNAT</a>
        <a href="configuracion.jsp">Configuración</a>
    </div>
</div>

<div class="contenido">

    <div class="header">
        <div>
            <h2>Historial de comprobantes</h2>
            <p>Consulta, descarga y revisa tus comprobantes emitidos</p>
        </div>

        <div>
            Usuario<br>
            <strong><%= usuario.getEmail() %></strong>
        </div>
    </div>

    <div class="filtros-historial">
        <div>
            <label>BUSCAR</label>
            <input type="text" id="buscar" placeholder="Número de comprobante o tipo" onkeyup="filtrarTabla()">
        </div>

        <div>
            <label>TIPO</label>
            <select id="tipoFiltro" onchange="filtrarTabla()">
                <option value="">Todos</option>
                <option value="BOLETA">Boleta</option>
                <option value="FACTURA">Factura</option>
            </select>
        </div>

        <div>
            <label>FECHA</label>
            <input type="date" id="fechaFiltro" onchange="filtrarTabla()">
        </div>
    </div>

    <div class="tabla-historial-card">

        <table class="tabla-historial" id="tablaHistorial">
            <thead>
                <tr>
                    <th>NÚMERO</th>
                    <th>TIPO</th>
                    <th>FECHA</th>
                    <th>MONTO</th>
                    <th>ESTADO</th>
                    <th>ACCIONES</th>
                </tr>
            </thead>

            <tbody>
            <% for(Comprobante c : lista){ %>
                <tr>
                    <td><strong><%= c.getSerie() %>-<%= c.getNumero() %></strong></td>
                    <td><%= c.getTipoComprobante() %></td>
                    <td><%= c.getFechaEmision() %></td>
                    <td>S/ <%= String.format("%.2f", c.getTotal()) %></td>
                    <td><span class="estado enviado"><%= c.getEstado() %></span></td>
                    <td class="acciones-tabla">
                        <a href="verComprobante.jsp?id=<%= c.getIdComprobante() %>" title="Ver">👁</a>
                        <a href="verComprobante.jsp?id=<%= c.getIdComprobante() %>&imprimir=1" title="Imprimir / PDF">⬇</a>
                        <a href="#" title="Reenviar SUNAT">↻</a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <div class="pie-tabla">
            <span>Total de comprobantes: <%= lista.size() %></span>
            <span>Mostrando registros disponibles</span>
        </div>

    </div>

</div>

<script>
function filtrarTabla() {
    let buscar = document.getElementById("buscar").value.toLowerCase();
    let tipo = document.getElementById("tipoFiltro").value.toLowerCase();
    let fecha = document.getElementById("fechaFiltro").value;

    let filas = document.querySelectorAll("#tablaHistorial tbody tr");

    filas.forEach(fila => {
        let numero = fila.children[0].innerText.toLowerCase();
        let tipoFila = fila.children[1].innerText.toLowerCase();
        let fechaFila = fila.children[2].innerText;

        let coincideBuscar = numero.includes(buscar) || tipoFila.includes(buscar);
        let coincideTipo = tipo === "" || tipoFila === tipo;
        let coincideFecha = fecha === "" || fechaFila.startsWith(fecha);

        fila.style.display = (coincideBuscar && coincideTipo && coincideFecha) ? "" : "none";
    });
}
</script>

</body>
</html>