package com.example.tubes.service;

import com.example.tubes.entity.Song;
import com.example.tubes.repository.SongRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SongServiceImpl implements ISongService {

    @Autowired
    private SongRepository songRepository;

    @Override
    public List<Song> getAllSongs() {
        return songRepository.findAll(
                org.springframework.data.domain.Sort.by(org.springframework.data.domain.Sort.Direction.DESC, "id"));
    }

    @Override
    public Optional<Song> getSongById(Long id) {
        return songRepository.findById(id);
    }

    @Override
    public Song saveSong(Song song) {
        return songRepository.save(song);
    }

    @Override
    public void deleteSong(Long id) {
        songRepository.deleteById(id);
    }

    @Override
    public java.util.List<Song> searchSongs(String query) {
        return songRepository.findByTitleContainingIgnoreCaseOrArtistContainingIgnoreCase(query, query);
    }

    @Override
    public java.util.List<Song> urutkanLagu(String criteria) {
        if ("artist".equalsIgnoreCase(criteria)) {
            return songRepository.findAll(org.springframework.data.domain.Sort.by("artist"));
        } else if ("title".equalsIgnoreCase(criteria)) {
            return songRepository.findAll(org.springframework.data.domain.Sort.by("title"));
        } else if ("plays".equalsIgnoreCase(criteria)) {
            return songRepository.findAll(org.springframework.data.domain.Sort
                    .by(org.springframework.data.domain.Sort.Direction.DESC, "plays"));
        } else {
            return songRepository.findAll();
        }
    }

    @Override
    public List<Song> tampilkanSemuaLagu() {
        return getAllSongs();
    }

    @Override
    public List<Song> cariBerdasarkanJudul(String keyword) {
        return songRepository.findByTitleContainingIgnoreCase(keyword);
    }

    @Override
    public List<Song> cariBerdasarkanPenyanyi(String nama) {
        return songRepository.findByArtistContainingIgnoreCase(nama);
    }

    @Override
    public Optional<Song> getRandomSong() {
        return songRepository.findRandomSong();
    }

    @Override
    public List<Song> getPopularSongs() {
        return songRepository.findTopPopularSongs();
    }
}
