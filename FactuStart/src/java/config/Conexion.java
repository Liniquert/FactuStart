package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    private Connection cn;

    public Connection conectar() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            cn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/factustart?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                    "root",
                    "3882281Li"
            );

            System.out.println("Conexion Exitosa");

        } catch (Exception e) {

            System.out.println("ERROR CONEXION: " + e.getMessage());
            e.printStackTrace();
        }

        return cn;
    }
}