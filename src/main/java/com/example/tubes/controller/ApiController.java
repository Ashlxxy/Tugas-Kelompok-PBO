package com.example.tubes.controller;

import com.example.tubes.entity.User;
import com.example.tubes.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private UserService userService;

    @PostMapping("/songs/{id}/like")
    public ResponseEntity<Map<String, Object>> toggleLike(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Map<String, Object> response = new HashMap<>();

        if (user == null) {
            response.put("success", false);
            response.put("message", "Unauthorized");
            return ResponseEntity.status(401).body(response);
        }

        try {
            userService.toggleLike(user.getId(), id);
            boolean isLiked = userService.isSongLiked(user.getId(), id);

            response.put("success", true);
            response.put("isLiked", isLiked);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

    @GetMapping("/songs/{id}/liked")
    public ResponseEntity<Map<String, Object>> getLikeStatus(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Map<String, Object> response = new HashMap<>();

        if (user == null) {
            response.put("isLiked", false);
            return ResponseEntity.ok(response);
        }

        boolean isLiked = userService.isSongLiked(user.getId(), id);
        response.put("success", true);
        response.put("isLiked", isLiked);
        return ResponseEntity.ok(response);
    }

    @Autowired
    private com.example.tubes.service.ISongService songService;

    @GetMapping("/songs/random")
    public ResponseEntity<Map<String, Object>> getRandomSong() {
        java.util.Optional<com.example.tubes.entity.Song> song = songService.getRandomSong();
        Map<String, Object> response = new HashMap<>();

        if (song.isPresent()) {
            response.put("success", true);

            Map<String, Object> songData = new HashMap<>();
            songData.put("id", song.get().getId());
            songData.put("title", song.get().getTitle());
            songData.put("artist", song.get().getArtist());

            songData.put("coverPath", song.get().getCoverPath());
            songData.put("filePath", song.get().getFilePath());

            response.put("song", songData);
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            return ResponseEntity.status(404).body(response);
        }
    }

    @Autowired
    private com.example.tubes.service.HistoryService historyService;

    @PostMapping("/history/record")
    public ResponseEntity<Map<String, Object>> recordHistory(@RequestParam Long songId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Map<String, Object> response = new HashMap<>();

        if (user == null) {
            response.put("success", false);
            return ResponseEntity.status(401).body(response);
        }

        try {
            java.util.Optional<com.example.tubes.entity.Song> songOpt = songService.getSongById(songId);
            if (songOpt.isPresent()) {
                com.example.tubes.entity.Song song = songOpt.get();

                song.setPlays(song.getPlays() + 1);
                songService.saveSong(song);

                com.example.tubes.entity.History history = new com.example.tubes.entity.History();
                history.setUser(user);
                history.setSong(song);
                history.setPlayedAt(java.time.LocalDateTime.now());
                historyService.addHistory(history);

                response.put("success", true);
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                return ResponseEntity.status(404).body(response);
            }
        } catch (Exception e) {
            response.put("success", false);
            return ResponseEntity.status(500).body(response);
        }
    }
}
