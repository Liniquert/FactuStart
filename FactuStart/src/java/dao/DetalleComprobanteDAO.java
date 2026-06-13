package dao;

import config.Conexion;
import modelo.DetalleComprobante;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DetalleComprobanteDAO {

    Conexion conexion = new Conexion();
    Connection cn;
    PreparedStatement ps;
    ResultSet rs;

    public boolean registrarDetalles(List<DetalleComprobante> detalles) {

        String sql = "INSERT INTO detalle_comprobante "
                + "(id_comprobante, descripcion, cantidad, precio_unitario, descuento, subtotal) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                System.out.println("ERROR: conexión nula en detalle_comprobante");
                return false;
            }

            ps = cn.prepareStatement(sql);

            for (DetalleComprobante detalle : detalles) {
                ps.setInt(1, detalle.getIdComprobante());
                ps.setString(2, detalle.getDescripcion());
                ps.setInt(3, detalle.getCantidad());
                ps.setDouble(4, detalle.getPrecioUnitario());
                ps.setDouble(5, detalle.getDescuento());
                ps.setDouble(6, detalle.getSubtotal());

                ps.addBatch();
            }

            ps.executeBatch();

            return true;

        } catch (Exception e) {
            System.out.println("Error registrar detalles: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<DetalleComprobante> listarPorComprobante(int idComprobante) {

        List<DetalleComprobante> lista = new ArrayList<>();

        String sql = "SELECT * FROM detalle_comprobante WHERE id_comprobante = ?";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return lista;
            }

            ps = cn.prepareStatement(sql);
            ps.setInt(1, idComprobante);

            rs = ps.executeQuery();

            while (rs.next()) {
                DetalleComprobante d = new DetalleComprobante();

                d.setIdDetalle(rs.getInt("id_detalle"));
                d.setIdComprobante(rs.getInt("id_comprobante"));
                d.setDescripcion(rs.getString("descripcion"));
                d.setCantidad(rs.getInt("cantidad"));
                d.setPrecioUnitario(rs.getDouble("precio_unitario"));
                d.setDescuento(rs.getDouble("descuento"));
                d.setSubtotal(rs.getDouble("subtotal"));

                lista.add(d);
            }

        } catch (Exception e) {
            System.out.println("Error listar detalles: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }
}