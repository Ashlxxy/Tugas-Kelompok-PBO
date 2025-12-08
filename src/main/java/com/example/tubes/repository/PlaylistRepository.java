package com.example.tubes.repository;

import com.example.tubes.entity.Playlist;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PlaylistRepository extends JpaRepository<Playlist, Long> {
    List<Playlist> findByUserId(Long userId);

    @org.springframework.data.jpa.repository.Query("SELECT p FROM Playlist p LEFT JOIN FETCH p.songs WHERE p.user.id = :userId")
    List<Playlist> findWithSongsByUserId(Long userId);
}
