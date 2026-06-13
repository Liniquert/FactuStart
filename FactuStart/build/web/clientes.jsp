<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Cliente"%>

<%
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    Cliente clienteEditar = (Cliente) request.getAttribute("cliente");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clientes - FactuStart</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body>

<div class="sidebar">
    <div class="logo">
        Facturación
        <br>
        <small>RED SOLUCIONES</small>
    </div>

    <div class="menu">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="comprobantes.jsp">Emitir comprobante</a>
        <a href="ClienteServlet?accion=listar" class="activo">Clientes</a>
        <a href="productos.jsp">Productos</a>
        <a href="reportes.jsp">Reportes</a>
        <a href="sunat.jsp">SUNAT</a>
        <a href="usuarios.jsp">Usuarios</a>
        <a href="configuracion.jsp">Configuración</a>
    </div>
</div>

<div class="contenido">

    <div class="header">
        <div>
            <h2>Gestión de Clientes</h2>
            <p>Registrar, editar y eliminar clientes</p>
        </div>
    </div>

    <div class="card">

        <h3>
            <%= (clienteEditar != null) ? "Editar Cliente" : "Nuevo Cliente" %>
        </h3>

        <form action="ClienteServlet" method="post">

            <input type="hidden" name="idCliente"
                   value="<%= (clienteEditar != null) ? clienteEditar.getIdCliente() : "" %>">

            <label>Tipo Documento</label>
            <select name="tipoDocumento" required>
                <option value="DNI">DNI</option>
                <option value="RUC">RUC</option>
            </select>

            <br><br>

            <label>Número Documento</label>
            <input type="text" name="numeroDocumento" required
                   value="<%= (clienteEditar != null) ? clienteEditar.getNumeroDocumento() : "" %>">

            <label>Nombre / Razón Social</label>
            <input type="text" name="razonSocialNombre" required
                   value="<%= (clienteEditar != null) ? clienteEditar.getRazonSocialNombre() : "" %>">

            <label>Dirección</label>
            <input type="text" name="direccion"
                   value="<%= (clienteEditar != null) ? clienteEditar.getDireccion() : "" %>">

            <label>Email</label>
            <input type="email" name="email"
                   value="<%= (clienteEditar != null) ? clienteEditar.getEmail() : "" %>">

            <label>Teléfono</label>
            <input type="text" name="telefono"
                   value="<%= (clienteEditar != null) ? clienteEditar.getTelefono() : "" %>">

            <br><br>

            <button type="submit">
                <%= (clienteEditar != null) ? "Actualizar Cliente" : "Guardar Cliente" %>
            </button>

            <a href="ClienteServlet?accion=listar">Cancelar</a>

        </form>

    </div>

    <br>

    <div class="card">

        <h3>Lista de Clientes</h3>

        <table border="1" width="100%" cellpadding="10">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Documento</th>
                    <th>Número</th>
                    <th>Nombre / Razón Social</th>
                    <th>Teléfono</th>
                    <th>Email</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
            <%
                if (clientes != null && !clientes.isEmpty()) {
                    for (Cliente c : clientes) {
            %>
                <tr>
                    <td><%= c.getIdCliente() %></td>
                    <td><%= c.getTipoDocumento() %></td>
                    <td><%= c.getNumeroDocumento() %></td>
                    <td><%= c.getRazonSocialNombre() %></td>
                    <td><%= c.getTelefono() %></td>
                    <td><%= c.getEmail() %></td>
                    <td>
                        <a href="ClienteServlet?accion=editar&id=<%= c.getIdCliente() %>">Editar</a>
                        |
                        <a href="ClienteServlet?accion=eliminar&id=<%= c.getIdCliente() %>"
                           onclick="return confirm('¿Deseas eliminar este cliente?')">
                            Eliminar
                        </a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="7" align="center">
                        No hay clientes registrados
                    </td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

    </div>

</div>

</body>
</html>