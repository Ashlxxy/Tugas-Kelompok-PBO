package com.example.tubes.service;

import com.example.tubes.entity.Song;
import java.util.List;
import java.util.Optional;

public interface ISongService {
    List<Song> getAllSongs();

    Optional<Song> getSongById(Long id);

    Song saveSong(Song song);

    void deleteSong(Long id);

    List<Song> searchSongs(String query);

    List<Song> urutkanLagu(String criteria);

    // Methods from Class Diagram
    List<Song> tampilkanSemuaLagu();

    List<Song> cariBerdasarkanJudul(String keyword);

    List<Song> cariBerdasarkanPenyanyi(String nama);

    java.util.Optional<Song> getRandomSong();

    java.util.List<Song> getPopularSongs();
}
