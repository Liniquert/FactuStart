package dao;

import config.Conexion;
import modelo.Negocio;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class NegocioDAO {

    Conexion conexion = new Conexion();
    Connection cn;
    PreparedStatement ps;
    ResultSet rs;

    public Negocio buscarPorUsuario(int idUsuario) {

        Negocio negocio = null;

        String sql = "SELECT * FROM negocio WHERE id_usuario = ? AND estado = 'ACTIVO'";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return null;
            }

            ps = cn.prepareStatement(sql);
            ps.setInt(1, idUsuario);

            rs = ps.executeQuery();

            if (rs.next()) {
                negocio = llenarNegocio(rs);
            }

        } catch (Exception e) {
            System.out.println("Error buscar negocio: " + e.getMessage());
            e.printStackTrace();
        }

        return negocio;
    }

    public Negocio buscarPorId(int idNegocio) {

        Negocio negocio = null;

        String sql = "SELECT * FROM negocio WHERE id_negocio = ?";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return null;
            }

            ps = cn.prepareStatement(sql);
            ps.setInt(1, idNegocio);

            rs = ps.executeQuery();

            if (rs.next()) {
                negocio = llenarNegocio(rs);
            }

        } catch (Exception e) {
            System.out.println("Error buscar negocio por ID: " + e.getMessage());
            e.printStackTrace();
        }

        return negocio;
    }

    public boolean registrar(Negocio negocio) {

        String sql = "INSERT INTO negocio(id_usuario, razon_social, ruc, direccion_fiscal, correo_contacto, telefono, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return false;
            }

            ps = cn.prepareStatement(sql);

            ps.setInt(1, negocio.getIdUsuario());
            ps.setString(2, negocio.getRazonSocial());
            ps.setString(3, negocio.getRuc());
            ps.setString(4, negocio.getDireccionFiscal());
            ps.setString(5, negocio.getCorreoContacto());
            ps.setString(6, negocio.getTelefono());
            ps.setString(7, negocio.getEstado());

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            System.out.println("Error registrar negocio: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private Negocio llenarNegocio(ResultSet rs) throws Exception {

        Negocio negocio = new Negocio();

        negocio.setIdNegocio(rs.getInt("id_negocio"));
        negocio.setIdUsuario(rs.getInt("id_usuario"));
        negocio.setRazonSocial(rs.getString("razon_social"));
        negocio.setRuc(rs.getString("ruc"));
        negocio.setDireccionFiscal(rs.getString("direccion_fiscal"));
        negocio.setCorreoContacto(rs.getString("correo_contacto"));
        negocio.setTelefono(rs.getString("telefono"));
        negocio.setEstado(rs.getString("estado"));

        return negocio;
    }
}