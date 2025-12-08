package com.example.tubes.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import java.util.List;

@Entity
@DiscriminatorValue("user")
public class Pengguna extends User {

    public void klikLagu(Song lagu) {
        // Implementation for clicking a song
    }

    public void beriLike(Song lagu) {
        // Implementation for liking a song
    }

    public void beriKomentar(Song lagu, String isi) {
        // Implementation for commenting on a song
    }

    public void tambahKePlaylist(Song lagu, Playlist playlist) {
        // Implementation for adding song to playlist
    }

    public void kirimFeedback(String isi) {
        // Implementation for sending feedback
    }

    public List<Song> cariLagu(String keyword) {
        // Implementation for searching songs
        return null;
    }
}
