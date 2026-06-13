<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>

<%
Usuario usuario = (Usuario) session.getAttribute("usuario");

if(usuario == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Configuración</title>

    <link rel="stylesheet" href="css/estilos.css?v=50">

    <style>

        .config-card{
            background:white;
            padding:30px;
            border-radius:12px;
            max-width:500px;
            margin-top:20px;
            box-shadow:0 2px 10px rgba(0,0,0,.08);
        }

        .btn-cerrar{
            background:#dc3545;
            color:white;
            border:none;
            padding:12px 25px;
            border-radius:8px;
            text-decoration:none;
            font-weight:bold;
            display:inline-block;
            margin-top:20px;
        }

        .btn-cerrar:hover{
            background:#bb2d3b;
        }

    </style>
</head>

<body>

<div class="sidebar">

    <div class="logo">
        Facturación
    </div>

    <div class="menu">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="comprobantes.jsp">Emitir comprobante</a>
        <a href="historial.jsp">Historial</a>
        <a href="reportes.jsp">Reportes</a>
        <a href="sunat.jsp">SUNAT</a>
        <a href="configuracion.jsp" class="activo">Configuración</a>
    </div>

</div>

<div class="contenido">

    <h1>Configuración</h1>

    <div class="config-card">

        <h3>Cuenta actual</h3>

        <p>
            <strong>Usuario:</strong><br>
            <%= usuario.getEmail() %>
        </p>

        <a href="CerrarSesionServlet"
           class="btn-cerrar"
           onclick="return confirm('¿Desea cerrar sesión?');">
            Cerrar Sesión
        </a>

    </div>

</div>

</body>
</html>