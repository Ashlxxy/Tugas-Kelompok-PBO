package com.example.tubes.controller;

import com.example.tubes.entity.Song;
import com.example.tubes.entity.User;
import com.example.tubes.service.ISongService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ISongService songService;

    @Autowired
    private com.example.tubes.service.FeedbackService feedbackService;

    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equals(user.getRole());
    }

    @GetMapping("/songs")
    public String index(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";
        model.addAttribute("songs", songService.getAllSongs());
        model.addAttribute("feedbacks", feedbackService.getAllFeedbacks());
        return "admin/songs/index";
    }

    @GetMapping("/songs/create")
    public String create(HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/login";
        return "admin/songs/create";
    }

    @PostMapping("/songs")
    public String store(@ModelAttribute Song song,
            @RequestParam("audioFile") org.springframework.web.multipart.MultipartFile audioFile,
            @RequestParam(value = "coverFile", required = false) org.springframework.web.multipart.MultipartFile coverFile,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/login";

        try {
            // Save Audio
            if (audioFile != null && !audioFile.isEmpty()) {
                String audioFileName = audioFile.getOriginalFilename();
                // External directory path from WebConfig
                java.nio.file.Path audioPath = java.nio.file.Paths.get(
                        "D:/Kuliah/SMST/SMST 5/PBO/Tubes/Tubes-Kelompok2-WebProPBO-main/Tubes_WebPro 0911/assets/songs/",
                        audioFileName);
                // Ensure directory exists
                java.nio.file.Files.createDirectories(audioPath.getParent());
                java.nio.file.Files.copy(audioFile.getInputStream(), audioPath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                song.setFilePath("/assets/songs/" + audioFileName);
            }

            // Save Cover
            if (coverFile != null && !coverFile.isEmpty()) {
                String coverFileName = coverFile.getOriginalFilename();
                // Webapp directory
                java.nio.file.Path coverPath = java.nio.file.Paths.get("src/main/webapp/assets/img/", coverFileName);
                // Ensure directory exists
                java.nio.file.Files.createDirectories(coverPath.getParent());
                java.nio.file.Files.copy(coverFile.getInputStream(), coverPath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                song.setCoverPath("/assets/img/" + coverFileName);
            } else {
                if (song.getCoverPath() == null || song.getCoverPath().isEmpty()) {
                    song.setCoverPath("/assets/img/covers/default.jpg");
                }
            }

            songService.saveSong(song);
            session.setAttribute("success", "Berhasil menambahkan lagu!");
        } catch (java.io.IOException e) {
            e.printStackTrace();
            session.setAttribute("error", "Gagal menambahkan lagu: " + e.getMessage());
        }
        return "redirect:/admin/songs";
    }

    @GetMapping("/songs/{id}/edit")
    public String edit(@PathVariable Long id, HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";
        model.addAttribute("song", songService.getSongById(id).orElse(null));
        return "admin/songs/edit";
    }

    @PostMapping("/songs/{id}")
    public String update(@PathVariable Long id, @ModelAttribute Song song, HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/login";
        song.setId(id); // Ensure ID is set
        songService.saveSong(song);
        session.setAttribute("success", "Berhasil memperbarui lagu!");
        return "redirect:/admin/songs";
    }

    @PostMapping("/songs/{id}/delete")
    public String delete(@PathVariable Long id, HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/login";
        songService.deleteSong(id);
        session.setAttribute("success", "Berhasil menghapus lagu!");
        return "redirect:/admin/songs";
    }
}
