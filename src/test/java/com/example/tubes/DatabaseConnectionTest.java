package com.example.tubes;

import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class DatabaseConnectionTest {

    @Test
    public void testConnection() {
        String url = "jdbc:mysql://localhost:3306/tubes_pbo?createDatabaseIfNotExist=true";
        String user = "root";
        String password = "";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connection successful!");
            assertNotNull(conn);
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Connection failed: " + e.getMessage());
        }
    }
}
