package com.example.tubes.repository;

import com.example.tubes.entity.Song;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SongRepository extends JpaRepository<Song, Long> {
    java.util.List<Song> findByTitleContainingIgnoreCaseOrArtistContainingIgnoreCase(String title, String artist);

    java.util.List<Song> findByTitleContainingIgnoreCase(String title);

    java.util.List<Song> findByArtistContainingIgnoreCase(String artist);

    java.util.List<Song> findTop10ByOrderByPlaysDesc();

    @org.springframework.data.jpa.repository.Query("SELECT s FROM Song s ORDER BY (s.likes + s.plays) DESC")
    java.util.List<Song> findTopPopularSongs();

    @org.springframework.data.jpa.repository.Query(value = "SELECT * FROM songs ORDER BY RAND() LIMIT 1", nativeQuery = true)
    java.util.Optional<Song> findRandomSong();
}
