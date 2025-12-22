package com.example.tubes.service;

import com.example.tubes.entity.User;
import com.example.tubes.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    public User register(User user) {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new RuntimeException("Email sudah terdaftar");
        }
        if (user.getUsername() == null || user.getUsername().isEmpty()) {

            String email = user.getEmail();
            if (email != null && email.contains("@")) {
                user.setUsername(email.split("@")[0]);
            } else {
                user.setUsername(user.getName().replaceAll("\\s+", "").toLowerCase());
            }
        }

        // Hash password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        return userRepository.save(user);
    }

    public User login(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (passwordEncoder.matches(password, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    @Autowired
    private com.example.tubes.repository.SongRepository songRepository;

    @org.springframework.transaction.annotation.Transactional
    public void toggleLike(Long userId, Long songId) {
        Optional<User> userOpt = userRepository.findById(userId);
        Optional<com.example.tubes.entity.Song> songOpt = songRepository.findById(songId);

        if (userOpt.isPresent() && songOpt.isPresent()) {
            User user = userOpt.get();
            com.example.tubes.entity.Song song = songOpt.get();

            if (user.getLikedSongs().contains(song)) {
                user.getLikedSongs().remove(song);
                song.setLikes(song.getLikes() - 1);
            } else {
                user.getLikedSongs().add(song);
                song.setLikes(song.getLikes() + 1);
            }
            userRepository.save(user);
            songRepository.save(song);
        }
    }

    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public boolean isSongLiked(Long userId, Long songId) {
        Optional<User> user = userRepository.findById(userId);
        if (user.isPresent()) {
            return user.get().getLikedSongs().stream().anyMatch(song -> song.getId().equals(songId));
        }
        return false;
    }

    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public java.util.Set<Long> getLikedSongIds(Long userId) {
        Optional<User> user = userRepository.findById(userId);
        if (user.isPresent()) {
            return user.get().getLikedSongs().stream().map(com.example.tubes.entity.Song::getId)
                    .collect(java.util.stream.Collectors.toSet());
        }
        return new java.util.HashSet<>();
    }

}
