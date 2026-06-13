<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FactuStart - Login</title>
    <link rel="stylesheet" href="css/login.css">
</head>

<body>

<div class="login-container">

    <div class="login-card">

        <div class="login-header">
            <div class="icono">▣</div>
            <h2>Bienvenido</h2>
            <p>Ingresa tus credenciales para continuar</p>
        </div>

        <form action="LoginServlet" method="post" class="login-form">

            <label>Correo electrónico</label>
            <input type="email" name="email" placeholder="tu@email.com" required>

            <label>Contraseña</label>
            <input type="password" name="password" placeholder="********" required>

            <div class="recuperar">
                <a href="#">¿Olvidaste tu contraseña?</a>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <p class="error">Correo o contraseña incorrectos</p>
            <% } %>

            <button type="submit" class="btn-login">Iniciar sesión</button>

            <a href="registro.jsp" class="btn-registro">Registrarme</a>

        </form>

    </div>

    <p class="footer-text">
        Tu información está protegida con encriptación de grado empresarial
    </p>

</div>

</body>
</html>