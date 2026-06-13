<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro - FactuStart</title>
    <link rel="stylesheet" href="css/login.css">
</head>

<body>

<div class="login-container">

    <div class="login-card">

        <div class="login-header">
            <div class="icono">▣</div>
            <h2>Crear cuenta</h2>
            <p>Registra tus datos para continuar</p>
        </div>

        <form action="RegistroServlet" method="post" class="login-form">

            <label>Nombre completo</label>
            <input type="text"
                   name="nombreCompleto"
                   placeholder="Tu nombre completo"
                   required>

            <label>Correo electrónico</label>
            <input type="email"
                   name="email"
                   placeholder="tu@email.com"
                   required>

            <label>Contraseña</label>
            <input type="password"
                   name="password"
                   placeholder="********"
                   required>

            <% if ("email".equals(request.getParameter("error"))) { %>
                <p class="error">El correo ya está registrado</p>
            <% } else if (request.getParameter("error") != null) { %>
                <p class="error">No se pudo crear la cuenta</p>
            <% } %>

            <button type="submit" class="btn-login">
                Registrarme
            </button>

            <a href="login.jsp" class="btn-registro">
                Ya tengo cuenta
            </a>

        </form>

    </div>

    <p class="footer-text">
        Tu información está protegida con encriptación de grado empresarial
    </p>

</div>

</body>
</html>