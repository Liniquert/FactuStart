package dao;

import config.Conexion;
import modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {

    Conexion conexion = new Conexion();
    Connection cn;
    PreparedStatement ps;
    ResultSet rs;

    public Usuario validarLogin(String email, String password) {

        Usuario usuario = null;

        String sql = "SELECT * FROM usuario WHERE email = ? AND password_hash = ? AND estado = 'ACTIVO'";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                System.out.println("ERROR: La conexion es NULL");
                return null;
            }

            ps = cn.prepareStatement(sql);
            ps.setString(1, email.trim());
            ps.setString(2, password.trim());

            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();

                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPasswordHash(rs.getString("password_hash"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));

                System.out.println("USUARIO ENCONTRADO: " + usuario.getEmail());
            } else {
                System.out.println("USUARIO NO ENCONTRADO");
            }

        } catch (Exception e) {
            System.out.println("ERROR LOGIN: " + e.getMessage());
            e.printStackTrace();
        }

        return usuario;
    }

    public boolean registrar(Usuario usuario) {

        String sql = "INSERT INTO usuario(nombre_completo, email, password_hash, rol, estado) VALUES (?, ?, ?, ?, ?)";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                System.out.println("ERROR: La conexion es NULL");
                return false;
            }

            ps = cn.prepareStatement(sql);

            ps.setString(1, usuario.getNombreCompleto());
            ps.setString(2, usuario.getEmail());
            ps.setString(3, usuario.getPasswordHash());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            System.out.println("ERROR REGISTRO: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean existeEmail(String email) {

        String sql = "SELECT id_usuario FROM usuario WHERE email = ?";

        try {
            cn = conexion.conectar();

            if (cn == null) {
                System.out.println("ERROR: La conexion es NULL");
                return true;
            }

            ps = cn.prepareStatement(sql);
            ps.setString(1, email.trim());

            rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            System.out.println("ERROR existeEmail: " + e.getMessage());
            e.printStackTrace();
            return true;
        }
    }
}