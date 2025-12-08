package com.example.tubes.service;

import com.example.tubes.entity.Playlist;
import com.example.tubes.repository.PlaylistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PlaylistService {

    @Autowired
    private PlaylistRepository playlistRepository;

    public List<Playlist> getPlaylistsByUserId(Long userId) {
        return playlistRepository.findByUserId(userId);
    }

    public List<Playlist> getPlaylistsWithSongsByUserId(Long userId) {
        return playlistRepository.findWithSongsByUserId(userId);
    }

    public Playlist createPlaylist(Playlist playlist) {
        return playlistRepository.save(playlist);
    }

    public Optional<Playlist> getPlaylistById(Long id) {
        return playlistRepository.findById(id);
    }

    public void deletePlaylist(Long id) {
        playlistRepository.deleteById(id);
    }

    @Autowired
    private com.example.tubes.repository.SongRepository songRepository;

    public Playlist savePlaylist(Playlist playlist) {
        return playlistRepository.save(playlist);
    }

    @org.springframework.transaction.annotation.Transactional
    public void addSongToPlaylist(Long playlistId, Long songId) {
        Optional<Playlist> playlistOpt = playlistRepository.findById(playlistId);
        Optional<com.example.tubes.entity.Song> songOpt = songRepository.findById(songId);

        if (playlistOpt.isPresent() && songOpt.isPresent()) {
            Playlist playlist = playlistOpt.get();
            com.example.tubes.entity.Song song = songOpt.get();
            playlist.getSongs().add(song);
            playlistRepository.save(playlist);
        }
    }

    @org.springframework.transaction.annotation.Transactional
    public void removeSongFromPlaylist(Long playlistId, Long songId) {
        Optional<Playlist> playlistOpt = playlistRepository.findById(playlistId);
        Optional<com.example.tubes.entity.Song> songOpt = songRepository.findById(songId);

        if (playlistOpt.isPresent() && songOpt.isPresent()) {
            Playlist playlist = playlistOpt.get();
            com.example.tubes.entity.Song song = songOpt.get();
            playlist.getSongs().remove(song);
            playlistRepository.save(playlist);
        }
    }
}
