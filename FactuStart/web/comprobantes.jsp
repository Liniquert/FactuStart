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
    <title>Emitir Comprobante</title>
    <link rel="stylesheet" href="css/estilos.css?v=5">
</head>

<body>

<div class="sidebar">
    <div class="logo">
        Facturación<br>
        <small>RED SOLUCIONES</small>
    </div>

    <div class="menu">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="comprobantes.jsp" class="activo">Emitir comprobante</a>
        <a href="historial.jsp">Historial</a>
        <a href="reportes.jsp">Reportes</a>
        <a href="sunat.jsp">SUNAT</a>
        <a href="configuracion.jsp">Configuración</a>
    </div>
</div>

<div class="contenido">

    <div class="header">
        <div>
            <h2>Emitir comprobante</h2>
            <p>Genera boletas o facturas electrónicas</p>
        </div>

        <div>
            Usuario<br>
            <strong><%= usuario.getEmail() %></strong>
        </div>
    </div>

    <% if (request.getParameter("exito") != null) { %>
        <div class="mensaje-exito">
            Comprobante emitido correctamente:
            <strong><%= request.getParameter("serie") %>-<%= request.getParameter("numero") %></strong>
        </div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
        <div class="mensaje-error">
            No se pudo emitir el comprobante.
        </div>
    <% } %>

    <div class="tabs">
        <button type="button" class="tab-btn activo-tab" onclick="mostrarTab('boleta', this)">Boleta</button>
        <button type="button" class="tab-btn" onclick="mostrarTab('factura', this)">Factura</button>
    </div>

    <!-- BOLETA -->
    <div id="boleta" class="tab-content">

        <form action="ComprobanteServlet" method="post">

            <input type="hidden" name="tipoComprobante" value="BOLETA">

            <div class="card-form">
                <h3>Emitir boleta</h3>

                <h4>Datos del cliente</h4>

                <div class="form-row">
                    <div>
                        <label>Nombre del cliente</label>
                        <input type="text" name="nombreCliente" placeholder="Juan Pérez" required>
                    </div>

                    <div>
                        <label>Documento DNI/RUC</label>
                        <input type="text" name="documentoCliente" placeholder="12345678" required>
                    </div>
                </div>

                <div class="cabecera-productos">
                    <h4>Productos/Servicios</h4>

                    <button type="button"
                            class="btn-agregar"
                            onclick="agregarFilaBoleta()">
                        + Agregar
                    </button>
                </div>

                <table class="tabla-comprobante">
                    <thead>
                        <tr>
                            <th>Descripción</th>
                            <th>Cantidad</th>
                            <th>Precio Unit.</th>
                            <th>Subtotal</th>
                            <th>Quitar</th>
                        </tr>
                    </thead>

                    <tbody id="detalleBoleta">
                        <tr>
                            <td>
                                <input type="text"
                                       name="descripcion"
                                       placeholder="Producto o servicio"
                                       required>
                            </td>

                            <td>
                                <input type="number"
                                       name="cantidad"
                                       value="1"
                                       min="1"
                                       oninput="calcularBoleta()"
                                       required>
                            </td>

                            <td>
                                <input type="number"
                                       name="precio"
                                       value="0"
                                       min="0"
                                       step="0.01"
                                       oninput="calcularBoleta()"
                                       required>
                            </td>

                            <td class="subtotal-boleta">S/ 0.00</td>

                            <td>
                                <button type="button"
                                        class="btn-quitar"
                                        onclick="eliminarFila(this); calcularBoleta();">
                                    X
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="total-box">
                    <span>Total</span>
                    <strong id="totalBoleta">S/ 0.00</strong>
                </div>

                <div class="botones-comprobante">
                    <button type="submit" class="btn-dark">
                        Emitir comprobante
                    </button>

                    <button type="button" class="btn-green" onclick="alert('Envío a SUNAT simulado')">
                        Enviar a SUNAT
                    </button>
                </div>
            </div>

        </form>

    </div>

    <!-- FACTURA -->
    <div id="factura" class="tab-content oculto">

        <form action="ComprobanteServlet" method="post">

            <input type="hidden" name="tipoComprobante" value="FACTURA">

            <div class="factura-layout">

                <div class="factura-main">

                    <h2 class="titulo-factura">Emitir factura electrónica</h2>

                    <div class="card-form">
                        <h4>Datos del Cliente</h4>

                        <label>Razón Social</label>
                        <input type="text"
                               name="razonSocialCliente"
                               placeholder="Nombre completo o razón social del cliente"
                               required>

                        <div class="form-row">
                            <div>
                                <label>RUC</label>
                                <input type="text"
                                       name="rucCliente"
                                       placeholder="20123456789"
                                       required>
                            </div>

                            <div>
                                <label>Dirección Fiscal</label>
                                <input type="text"
                                       name="direccionFiscalCliente"
                                       placeholder="Av. Principal 123, Lima"
                                       required>
                            </div>
                        </div>
                    </div>

                    <div class="card-form">

                        <div class="cabecera-productos">
                            <h4>Detalle de Productos/Servicios</h4>

                            <button type="button"
                                    class="btn-agregar"
                                    onclick="agregarFilaFactura()">
                                + Agregar
                            </button>
                        </div>

                        <table class="tabla-comprobante">
                            <thead>
                                <tr>
                                    <th>Descripción</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unit.</th>
                                    <th>Subtotal</th>
                                    <th>Quitar</th>
                                </tr>
                            </thead>

                            <tbody id="detalleFactura">
                                <tr>
                                    <td>
                                        <input type="text"
                                               name="descripcion"
                                               placeholder="Descripción del producto o servicio"
                                               required>
                                    </td>

                                    <td>
                                        <input type="number"
                                               name="cantidad"
                                               value="1"
                                               min="1"
                                               oninput="calcularFactura()"
                                               required>
                                    </td>

                                    <td>
                                        <input type="number"
                                               name="precio"
                                               value="0"
                                               min="0"
                                               step="0.01"
                                               oninput="calcularFactura()"
                                               required>
                                    </td>

                                    <td class="subtotal-factura">S/ 0.00</td>

                                    <td>
                                        <button type="button"
                                                class="btn-quitar"
                                                onclick="eliminarFila(this); calcularFactura();">
                                            X
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

                <div class="resumen-lateral">
                    <h4>Resumen</h4>

                    <p>Subtotal <strong id="subtotalFactura">S/ 0.00</strong></p>
                    <p>IGV (18%) <strong id="igvFactura">S/ 0.00</strong></p>
                    <p class="total-final">Total <strong id="totalFactura">S/ 0.00</strong></p>

                    <button type="submit" class="btn-turquesa">
                        Emitir factura
                    </button>

                    <button type="button" class="btn-orange" onclick="alert('Envío a SUNAT simulado')">
                        Enviar a SUNAT
                    </button>
                </div>

            </div>

        </form>

    </div>

</div>

<script>
    function mostrarTab(tab, boton) {
        document.getElementById("boleta").classList.add("oculto");
        document.getElementById("factura").classList.add("oculto");

        document.getElementById(tab).classList.remove("oculto");

        const botones = document.querySelectorAll(".tab-btn");
        botones.forEach(b => b.classList.remove("activo-tab"));

        boton.classList.add("activo-tab");
    }

    function agregarFilaBoleta() {
        let fila = `
            <tr>
                <td><input type="text" name="descripcion" placeholder="Producto o servicio" required></td>
                <td><input type="number" name="cantidad" value="1" min="1" oninput="calcularBoleta()" required></td>
                <td><input type="number" name="precio" value="0" min="0" step="0.01" oninput="calcularBoleta()" required></td>
                <td class="subtotal-boleta">S/ 0.00</td>
                <td>
                    <button type="button" class="btn-quitar" onclick="eliminarFila(this); calcularBoleta();">
                        X
                    </button>
                </td>
            </tr>
        `;

        document.getElementById("detalleBoleta").insertAdjacentHTML("beforeend", fila);
        calcularBoleta();
    }

    function agregarFilaFactura() {
        let fila = `
            <tr>
                <td><input type="text" name="descripcion" placeholder="Descripción del producto o servicio" required></td>
                <td><input type="number" name="cantidad" value="1" min="1" oninput="calcularFactura()" required></td>
                <td><input type="number" name="precio" value="0" min="0" step="0.01" oninput="calcularFactura()" required></td>
                <td class="subtotal-factura">S/ 0.00</td>
                <td>
                    <button type="button" class="btn-quitar" onclick="eliminarFila(this); calcularFactura();">
                        X
                    </button>
                </td>
            </tr>
        `;

        document.getElementById("detalleFactura").insertAdjacentHTML("beforeend", fila);
        calcularFactura();
    }

    function eliminarFila(boton) {
        boton.closest("tr").remove();
    }

    function calcularBoleta() {
        let total = 0;
        let filas = document.querySelectorAll("#detalleBoleta tr");

        filas.forEach(fila => {
            let cantidad = parseFloat(fila.children[1].querySelector("input").value) || 0;
            let precio = parseFloat(fila.children[2].querySelector("input").value) || 0;
            let subtotal = cantidad * precio;

            fila.children[3].innerText = "S/ " + subtotal.toFixed(2);
            total += subtotal;
        });

        document.getElementById("totalBoleta").innerText = "S/ " + total.toFixed(2);
    }

    function calcularFactura() {
        let subtotalGeneral = 0;
        let filas = document.querySelectorAll("#detalleFactura tr");

        filas.forEach(fila => {
            let cantidad = parseFloat(fila.children[1].querySelector("input").value) || 0;
            let precio = parseFloat(fila.children[2].querySelector("input").value) || 0;
            let subtotal = cantidad * precio;

            fila.children[3].innerText = "S/ " + subtotal.toFixed(2);
            subtotalGeneral += subtotal;
        });

        let igv = subtotalGeneral * 0.18;
        let total = subtotalGeneral + igv;

        document.getElementById("subtotalFactura").innerText = "S/ " + subtotalGeneral.toFixed(2);
        document.getElementById("igvFactura").innerText = "S/ " + igv.toFixed(2);
        document.getElementById("totalFactura").innerText = "S/ " + total.toFixed(2);
    }

    window.onload = function() {
        calcularBoleta();
        calcularFactura();
    };
</script>

</body>
</html>