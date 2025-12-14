package com.example.tubes.controller;

import com.example.tubes.entity.Playlist;
import com.example.tubes.entity.User;
import com.example.tubes.service.ISongService;
import com.example.tubes.service.PlaylistService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/playlists")
public class PlaylistController {

    @Autowired
    private PlaylistService playlistService;

    @Autowired
    private ISongService songService;

    @GetMapping
    public String index(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("playlists", playlistService.getPlaylistsByUserId(user.getId()));
        return "playlists/index";
    }

    @GetMapping("/create")
    public String createForm() {
        return "playlists/create";
    }

    @PostMapping
    public String store(@ModelAttribute Playlist playlist, @RequestParam(required = false) Long songId,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        playlist.setUser(user);
        Playlist newPlaylist = playlistService.createPlaylist(playlist);

        if (songId != null) {
            playlistService.addSongToPlaylist(newPlaylist.getId(), songId);
            session.setAttribute("success", "Playlist berhasil dibuat dan lagu ditambahkan!");
            return "redirect:/playlists/" + newPlaylist.getId();
        }

        session.setAttribute("success", "Playlist berhasil dibuat!");
        return "redirect:/playlists";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        model.addAttribute("playlist", playlistService.getPlaylistById(id).orElse(null));
        model.addAttribute("allSongs", songService.getAllSongs());
        return "playlists/show";
    }

    @PostMapping("/{id}/songs")
    public String addSong(@PathVariable Long id, @RequestParam Long songId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        playlistService.addSongToPlaylist(id, songId);
        session.setAttribute("success", "Lagu ditambahkan ke playlist!");
        return "redirect:/playlists/" + id;
    }

    @PostMapping("/{id}/songs/remove")
    public String removeSong(@PathVariable Long id, @RequestParam Long songId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        playlistService.removeSongFromPlaylist(id, songId);
        session.setAttribute("success", "Lagu dihapus dari playlist!");
        return "redirect:/playlists/" + id;
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        playlistService.deletePlaylist(id);
        session.setAttribute("success", "Playlist dihapus!");
        return "redirect:/playlists";
    }
}
