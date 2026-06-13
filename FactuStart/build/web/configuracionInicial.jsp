<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Configuración Inicial - FactuStart</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body>

<div class="contenedor-config">

    <div class="card-config">

        <h2>Configura tu negocio</h2>
        <p>Registra los datos básicos de tu negocio para comenzar a emitir comprobantes.</p>

        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">No se pudo guardar la información. Intenta nuevamente.</p>
        <% } %>

        <form action="NegocioServlet" method="post">

            <label>Razón Social</label>
            <input type="text" name="razonSocial" required>

            <label>RUC</label>
            <input type="text" name="ruc" maxlength="11" required>

            <label>Dirección Fiscal</label>
            <input type="text" name="direccionFiscal" required>

            <label>Correo de Contacto</label>
            <input type="email" name="correoContacto" required>

            <label>Teléfono</label>
            <input type="text" name="telefono" maxlength="15" required>

            <button type="submit">Guardar y continuar</button>

        </form>

    </div>

</div>

</body>
</html>