<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ComprobanteDAO"%>
<%@page import="dao.NegocioDAO"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Negocio"%>
<%@page import="java.util.Map"%>

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

    double ingresos = dao.obtenerIngresosTotalesPorNegocio(idNegocio);
    int comprobantes = dao.obtenerTotalComprobantesPorNegocio(idNegocio);
    int boletas = dao.obtenerTotalPorTipoPorNegocio("BOLETA", idNegocio);
    int facturas = dao.obtenerTotalPorTipoPorNegocio("FACTURA", idNegocio);
    double igv = dao.obtenerIGVTotalPorNegocio(idNegocio);

    Map<String, Double> ventas7Dias = dao.obtenerVentasUltimos7DiasPorNegocio(idNegocio);
    Map<String, Integer> comprobantes7Dias = dao.obtenerComprobantesUltimos7DiasPorNegocio(idNegocio);

    String labelsVentas = "";
    String datosVentas = "";

    for (Map.Entry<String, Double> entry : ventas7Dias.entrySet()) {
        labelsVentas += "'" + entry.getKey() + "',";
        datosVentas += entry.getValue() + ",";
    }

    String labelsComprobantes = "";
    String datosComprobantes = "";

    for (Map.Entry<String, Integer> entry : comprobantes7Dias.entrySet()) {
        labelsComprobantes += "'" + entry.getKey() + "',";
        datosComprobantes += entry.getValue() + ",";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reportes de Ventas</title>
    <link rel="stylesheet" href="css/estilos.css?v=41">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .reporte-grid{
            display:grid;
            grid-template-columns:repeat(4,1fr);
            gap:20px;
            margin-bottom:25px;
        }

        .reporte-card{
            background:white;
            padding:25px;
            border-radius:12px;
            box-shadow:0 2px 10px rgba(0,0,0,.08);
        }

        .reporte-card h4{
            margin:0;
            color:#666;
        }

        .reporte-card h2{
            margin-top:15px;
            color:#08142d;
        }

        .grafico-grid{
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:20px;
            margin-bottom:25px;
        }

        .grafico-card{
            background:white;
            padding:25px;
            border-radius:12px;
            box-shadow:0 2px 10px rgba(0,0,0,.08);
        }

        .tabla-reportes{
            width:100%;
            border-collapse:collapse;
            background:white;
            border-radius:12px;
            overflow:hidden;
        }

        .tabla-reportes th{
            background:#08142d;
            color:white;
            padding:14px;
            text-align:left;
        }

        .tabla-reportes td{
            padding:14px;
            border-bottom:1px solid #eee;
        }

        .contenedor-tabla{
            background:white;
            padding:20px;
            border-radius:12px;
            box-shadow:0 2px 10px rgba(0,0,0,.08);
        }
    </style>
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
        <a href="historial.jsp">Historial</a>
        <a href="reportes.jsp" class="activo">Reportes</a>
        <a href="sunat.jsp">SUNAT</a>
        <a href="configuracion.jsp">Configuración</a>
    </div>

</div>

<div class="contenido">

    <h1>Reportes de Ventas</h1>
    <p>Resumen general del negocio</p>

    <div class="reporte-grid">

        <div class="reporte-card">
            <h4>Ingresos Totales</h4>
            <h2>S/ <%= String.format("%.2f", ingresos) %></h2>
        </div>

        <div class="reporte-card">
            <h4>Comprobantes Emitidos</h4>
            <h2><%= comprobantes %></h2>
        </div>

        <div class="reporte-card">
            <h4>Total Boletas</h4>
            <h2><%= boletas %></h2>
        </div>

        <div class="reporte-card">
            <h4>Total Facturas</h4>
            <h2><%= facturas %></h2>
        </div>

    </div>

    <div class="reporte-grid">
        <div class="reporte-card">
            <h4>IGV Recaudado</h4>
            <h2>S/ <%= String.format("%.2f", igv) %></h2>
        </div>
    </div>

    <div class="grafico-grid">

        <div class="grafico-card">
            <h3>Ventas por Día - Últimos 7 días</h3>
            <canvas id="ventasChart"></canvas>
        </div>

        <div class="grafico-card">
            <h3>Comprobantes Emitidos - Últimos 7 días</h3>
            <canvas id="comprobantesChart"></canvas>
        </div>

    </div>

    <div class="contenedor-tabla">

        <h3>Resumen</h3>

        <table class="tabla-reportes">

            <tr>
                <th>Indicador</th>
                <th>Valor</th>
            </tr>

            <tr>
                <td>Ingresos Totales</td>
                <td>S/ <%= String.format("%.2f", ingresos) %></td>
            </tr>

            <tr>
                <td>Total Comprobantes</td>
                <td><%= comprobantes %></td>
            </tr>

            <tr>
                <td>Boletas Emitidas</td>
                <td><%= boletas %></td>
            </tr>

            <tr>
                <td>Facturas Emitidas</td>
                <td><%= facturas %></td>
            </tr>

            <tr>
                <td>IGV Recaudado</td>
                <td>S/ <%= String.format("%.2f", igv) %></td>
            </tr>

        </table>

    </div>

</div>

<script>
new Chart(document.getElementById('ventasChart'), {
    type: 'bar',
    data: {
        labels: [<%= labelsVentas %>],
        datasets: [{
            label: 'Ventas S/',
            data: [<%= datosVentas %>]
        }]
    }
});

new Chart(document.getElementById('comprobantesChart'), {
    type: 'line',
    data: {
        labels: [<%= labelsComprobantes %>],
        datasets: [{
            label: 'Comprobantes',
            data: [<%= datosComprobantes %>],
            tension: 0.4
        }]
    }
});
</script>

</body>
</html>