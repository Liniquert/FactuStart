package dao;

import config.Conexion;
import modelo.Cliente;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    Conexion conexion = new Conexion();
    Connection cn;
    PreparedStatement ps;
    ResultSet rs;

    public List<Cliente> listar() {

        List<Cliente> lista = new ArrayList<>();

        String sql = "SELECT * FROM cliente";

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                lista.add(llenarCliente(rs));
            }

        } catch (Exception e) {
            System.out.println("Error listar clientes: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }

    public boolean registrar(Cliente cliente) {

        String sql = "INSERT INTO cliente(id_negocio, tipo_documento, numero_documento, razon_social_nombre, direccion, email, telefono) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return false;
            }

            ps = cn.prepareStatement(sql);

            ps.setInt(1, cliente.getIdNegocio());
            ps.setString(2, cliente.getTipoDocumento());
            ps.setString(3, cliente.getNumeroDocumento());
            ps.setString(4, cliente.getRazonSocialNombre());
            ps.setString(5, cliente.getDireccion());
            ps.setString(6, cliente.getEmail());
            ps.setString(7, cliente.getTelefono());

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error registrar cliente: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public int registrarYObtenerId(Cliente cliente) {

        int idGenerado = 0;

        String sql = "INSERT INTO cliente(id_negocio, tipo_documento, numero_documento, razon_social_nombre, direccion, email, telefono) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return 0;
            }

            ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, cliente.getIdNegocio());
            ps.setString(2, cliente.getTipoDocumento());
            ps.setString(3, cliente.getNumeroDocumento());
            ps.setString(4, cliente.getRazonSocialNombre());
            ps.setString(5, cliente.getDireccion());
            ps.setString(6, cliente.getEmail());
            ps.setString(7, cliente.getTelefono());

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();

            if (rs.next()) {
                idGenerado = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error registrar y obtener cliente: " + e.getMessage());
            e.printStackTrace();
        }

        return idGenerado;
    }

    public Cliente buscarPorId(int idCliente) {

        Cliente c = null;

        String sql = "SELECT * FROM cliente WHERE id_cliente = ?";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return null;
            }

            ps = cn.prepareStatement(sql);
            ps.setInt(1, idCliente);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = llenarCliente(rs);
            }

        } catch (Exception e) {
            System.out.println("Error buscar cliente: " + e.getMessage());
            e.printStackTrace();
        }

        return c;
    }

    public Cliente buscarPorDocumento(String numeroDocumento) {

        Cliente c = null;

        String sql = "SELECT * FROM cliente WHERE numero_documento = ? LIMIT 1";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return null;
            }

            ps = cn.prepareStatement(sql);
            ps.setString(1, numeroDocumento);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = llenarCliente(rs);
            }

        } catch (Exception e) {
            System.out.println("Error buscar cliente por documento: " + e.getMessage());
            e.printStackTrace();
        }

        return c;
    }

    public int obtenerOCrearCliente(Cliente cliente) {

        Cliente existente = buscarPorDocumento(cliente.getNumeroDocumento());

        if (existente != null) {
            return existente.getIdCliente();
        }

        return registrarYObtenerId(cliente);
    }

    public boolean actualizar(Cliente cliente) {

        String sql = "UPDATE cliente SET tipo_documento=?, numero_documento=?, razon_social_nombre=?, direccion=?, email=?, telefono=? "
                + "WHERE id_cliente=?";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return false;
            }

            ps = cn.prepareStatement(sql);

            ps.setString(1, cliente.getTipoDocumento());
            ps.setString(2, cliente.getNumeroDocumento());
            ps.setString(3, cliente.getRazonSocialNombre());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getEmail());
            ps.setString(6, cliente.getTelefono());
            ps.setInt(7, cliente.getIdCliente());

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error actualizar cliente: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int idCliente) {

        String sql = "DELETE FROM cliente WHERE id_cliente = ?";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                return false;
            }

            ps = cn.prepareStatement(sql);
            ps.setInt(1, idCliente);

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error eliminar cliente: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private Cliente llenarCliente(ResultSet rs) throws Exception {

        Cliente c = new Cliente();

        c.setIdCliente(rs.getInt("id_cliente"));
        c.setIdNegocio(rs.getInt("id_negocio"));
        c.setTipoDocumento(rs.getString("tipo_documento"));
        c.setNumeroDocumento(rs.getString("numero_documento"));
        c.setRazonSocialNombre(rs.getString("razon_social_nombre"));
        c.setDireccion(rs.getString("direccion"));
        c.setEmail(rs.getString("email"));
        c.setTelefono(rs.getString("telefono"));

        return c;
    }
}