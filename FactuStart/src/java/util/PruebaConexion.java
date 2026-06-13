package util;

import config.Conexion;
import java.sql.Connection;

public class PruebaConexion {

    public static void main(String[] args) {

        Conexion con = new Conexion();

        Connection cn = con.conectar();

        if (cn != null) {

            System.out.println("Base de datos conectada correctamente");

        } else {

            System.out.println("No se pudo conectar");

        }
    }
}