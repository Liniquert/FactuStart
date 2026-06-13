package dao;

import config.Conexion;
import modelo.Comprobante;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ComprobanteDAO {

    Conexion conexion = new Conexion();
    Connection cn;
    PreparedStatement ps;
    ResultSet rs;

    public int registrar(Comprobante comprobante) {

        int idGenerado = 0;

        String sql = "INSERT INTO comprobante "
                + "(id_negocio, id_cliente, tipo_comprobante, serie, numero, moneda, subtotal, igv, total, forma_pago, estado, observacion) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return 0;
            }

            ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, comprobante.getIdNegocio());
            ps.setInt(2, comprobante.getIdCliente());
            ps.setString(3, comprobante.getTipoComprobante());
            ps.setString(4, comprobante.getSerie());
            ps.setString(5, comprobante.getNumero());
            ps.setString(6, comprobante.getMoneda());
            ps.setDouble(7, comprobante.getSubtotal());
            ps.setDouble(8, comprobante.getIgv());
            ps.setDouble(9, comprobante.getTotal());
            ps.setString(10, comprobante.getFormaPago());
            ps.setString(11, comprobante.getEstado());
            ps.setString(12, comprobante.getObservacion());

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();

            if (rs.next()) {
                idGenerado = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error registrar comprobante: " + e.getMessage());
            e.printStackTrace();
        }

        return idGenerado;
    }

    public int obtenerSiguienteNumero(String tipoComprobante) {

        int numero = 1;

        String sql = "SELECT COUNT(*) + 1 AS siguiente FROM comprobante WHERE tipo_comprobante = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setString(1, tipoComprobante);
            rs = ps.executeQuery();

            if (rs.next()) {
                numero = rs.getInt("siguiente");
            }

        } catch (Exception e) {
            System.out.println("Error obtener siguiente número: " + e.getMessage());
        }

        return numero;
    }

    public Comprobante buscarPorId(int idComprobante) {

        Comprobante c = null;

        String sql = "SELECT * FROM comprobante WHERE id_comprobante = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idComprobante);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = llenarComprobante(rs);
            }

        } catch (Exception e) {
            System.out.println("Error buscar comprobante: " + e.getMessage());
            e.printStackTrace();
        }

        return c;
    }

    public List<Comprobante> listarPorNegocio(int idNegocio) {

        List<Comprobante> lista = new ArrayList<>();

        String sql = "SELECT * FROM comprobante WHERE id_negocio = ? ORDER BY id_comprobante DESC";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            while (rs.next()) {
                lista.add(llenarComprobante(rs));
            }

        } catch (Exception e) {
            System.out.println("Error listar por negocio: " + e.getMessage());
        }

        return lista;
    }

    public double obtenerVentasDelDiaPorNegocio(int idNegocio) {

        double total = 0;

        String sql = "SELECT IFNULL(SUM(total),0) AS total "
                + "FROM comprobante "
                + "WHERE DATE(fecha_emision) = CURDATE() "
                + "AND estado = 'EMITIDO' "
                + "AND id_negocio = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total");
            }

        } catch (Exception e) {
            System.out.println("Error ventas del día por negocio: " + e.getMessage());
        }

        return total;
    }

    public int obtenerComprobantesDelDiaPorNegocio(int idNegocio) {

        int total = 0;

        String sql = "SELECT COUNT(*) AS total "
                + "FROM comprobante "
                + "WHERE DATE(fecha_emision) = CURDATE() "
                + "AND estado = 'EMITIDO' "
                + "AND id_negocio = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            System.out.println("Error comprobantes del día por negocio: " + e.getMessage());
        }

        return total;
    }

    public List<Comprobante> listarUltimosPorNegocio(int idNegocio, int limite) {

        List<Comprobante> lista = new ArrayList<>();

        String sql = "SELECT * FROM comprobante "
                + "WHERE id_negocio = ? "
                + "ORDER BY id_comprobante DESC "
                + "LIMIT ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            ps.setInt(2, limite);
            rs = ps.executeQuery();

            while (rs.next()) {
                lista.add(llenarComprobante(rs));
            }

        } catch (Exception e) {
            System.out.println("Error listar últimos por negocio: " + e.getMessage());
        }

        return lista;
    }

    public double obtenerIngresosTotalesPorNegocio(int idNegocio) {

        double total = 0;

        String sql = "SELECT IFNULL(SUM(total),0) AS total "
                + "FROM comprobante "
                + "WHERE estado = 'EMITIDO' "
                + "AND id_negocio = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total");
            }

        } catch (Exception e) {
            System.out.println("Error ingresos por negocio: " + e.getMessage());
        }

        return total;
    }

    public int obtenerTotalComprobantesPorNegocio(int idNegocio) {

        int total = 0;

        String sql = "SELECT COUNT(*) AS total "
                + "FROM comprobante "
                + "WHERE estado = 'EMITIDO' "
                + "AND id_negocio = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            System.out.println("Error total comprobantes por negocio: " + e.getMessage());
        }

        return total;
    }

    public int obtenerTotalPorTipoPorNegocio(String tipo, int idNegocio) {

        int total = 0;

        String sql = "SELECT COUNT(*) AS total "
                + "FROM comprobante "
                + "WHERE tipo_comprobante = ? "
                + "AND estado = 'EMITIDO' "
                + "AND id_negocio = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setString(1, tipo);
            ps.setInt(2, idNegocio);
            rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            System.out.println("Error tipo por negocio: " + e.getMessage());
        }

        return total;
    }

    public double obtenerIGVTotalPorNegocio(int idNegocio) {

        double total = 0;

        String sql = "SELECT IFNULL(SUM(igv),0) AS total "
                + "FROM comprobante "
                + "WHERE estado = 'EMITIDO' "
                + "AND id_negocio = ?";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total");
            }

        } catch (Exception e) {
            System.out.println("Error IGV por negocio: " + e.getMessage());
        }

        return total;
    }

    public Map<String, Double> obtenerVentasUltimos7DiasPorNegocio(int idNegocio) {

        Map<String, Double> datos = new LinkedHashMap<>();

        String sql = "SELECT DATE(fecha_emision) AS fecha, IFNULL(SUM(total),0) AS total "
                + "FROM comprobante "
                + "WHERE estado = 'EMITIDO' "
                + "AND id_negocio = ? "
                + "AND fecha_emision >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) "
                + "GROUP BY DATE(fecha_emision) "
                + "ORDER BY fecha";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            while (rs.next()) {
                datos.put(rs.getString("fecha"), rs.getDouble("total"));
            }

        } catch (Exception e) {
            System.out.println("Error ventas 7 días por negocio: " + e.getMessage());
        }

        return datos;
    }

    public Map<String, Integer> obtenerComprobantesUltimos7DiasPorNegocio(int idNegocio) {

        Map<String, Integer> datos = new LinkedHashMap<>();

        String sql = "SELECT DATE(fecha_emision) AS fecha, COUNT(*) AS total "
                + "FROM comprobante "
                + "WHERE estado = 'EMITIDO' "
                + "AND id_negocio = ? "
                + "AND fecha_emision >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) "
                + "GROUP BY DATE(fecha_emision) "
                + "ORDER BY fecha";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);
            rs = ps.executeQuery();

            while (rs.next()) {
                datos.put(rs.getString("fecha"), rs.getInt("total"));
            }

        } catch (Exception e) {
            System.out.println("Error comprobantes 7 días por negocio: " + e.getMessage());
        }

        return datos;
    }

    private Comprobante llenarComprobante(ResultSet rs) throws Exception {

        Comprobante c = new Comprobante();

        c.setIdComprobante(rs.getInt("id_comprobante"));
        c.setIdNegocio(rs.getInt("id_negocio"));
        c.setIdCliente(rs.getInt("id_cliente"));
        c.setTipoComprobante(rs.getString("tipo_comprobante"));
        c.setSerie(rs.getString("serie"));
        c.setNumero(rs.getString("numero"));
        c.setFechaEmision(rs.getString("fecha_emision"));
        c.setMoneda(rs.getString("moneda"));
        c.setSubtotal(rs.getDouble("subtotal"));
        c.setIgv(rs.getDouble("igv"));
        c.setTotal(rs.getDouble("total"));
        c.setFormaPago(rs.getString("forma_pago"));
        c.setEstado(rs.getString("estado"));
        c.setObservacion(rs.getString("observacion"));

        return c;
    }
}