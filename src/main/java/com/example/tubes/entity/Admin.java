package com.example.tubes.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("admin")
public class Admin extends User {

    public void kelolaLagu() {
        // Logika bisnis didelegasikan ke SongService (Admin CRUD).
        // Sesuai dengan Architecture Spring Boot.
    }

    public void moderasiKomentar() {
        // Implementation for moderating comments
    }

    public void lihatStatistik() {
        // Implementation for viewing statistics
    }

    public void tanggapiFeedback() {
        // Implementation for responding to feedback
    }
}
