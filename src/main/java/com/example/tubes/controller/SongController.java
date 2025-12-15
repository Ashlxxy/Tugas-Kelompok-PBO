package com.example.tubes.controller;

import com.example.tubes.entity.Comment;
import com.example.tubes.entity.Song;
import com.example.tubes.entity.User;
import com.example.tubes.service.CommentService;
import com.example.tubes.service.ISongService;
import com.example.tubes.service.PlaylistService;
import com.example.tubes.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/songs")
public class SongController {

    @Autowired
    private ISongService songService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @Autowired
    private PlaylistService playlistService;

    @GetMapping
    public String index(@RequestParam(required = false) String q,
            @RequestParam(required = false) Long addToPlaylist,
            Model model, HttpSession session) {
        if (q != null && !q.isEmpty()) {
            model.addAttribute("songs", songService.searchSongs(q));
        } else {
            model.addAttribute("songs", songService.getAllSongs());
        }

        if (addToPlaylist != null) {
            playlistService.getPlaylistById(addToPlaylist).ifPresent(playlist -> {
                model.addAttribute("addToPlaylistId", addToPlaylist);
                model.addAttribute("targetPlaylistName", playlist.getName());
            });
        }

        User user = (User) session.getAttribute("user");
        if (user != null) {
            java.util.Set<Long> likedSongIds = userService.getLikedSongIds(user.getId());
            model.addAttribute("likedSongIds", likedSongIds);
        }

        return "songs/index";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model, HttpSession session) {
        Optional<Song> song = songService.getSongById(id);
        if (song.isPresent()) {
            model.addAttribute("song", song.get());
            model.addAttribute("comments", commentService.getCommentsBySongId(id));

            User user = (User) session.getAttribute("user");
            boolean isLiked = false;
            if (user != null) {
                isLiked = userService.isSongLiked(user.getId(), id);
                model.addAttribute("userPlaylists", playlistService.getPlaylistsWithSongsByUserId(user.getId()));
            }
            model.addAttribute("isLiked", isLiked);

            return "songs/show";
        }
        return "redirect:/songs";
    }

    @PostMapping("/{id}/comments")
    public String addComment(@PathVariable Long id,
            @RequestParam String content,
            @RequestParam(required = false) Long parentId,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        Optional<Song> song = songService.getSongById(id);
        if (song.isPresent()) {
            Comment comment = new Comment();
            comment.setUser(user);
            comment.setSong(song.get());
            if (parentId != null) {
                commentService.getCommentById(parentId).ifPresent(parent -> {
                    comment.setParent(parent);
                });
            }
            comment.setContent(content);
            commentService.addComment(comment);
        }
        return "redirect:/songs/" + id;
    }

    @PostMapping("/{id}/comments/{commentId}/delete")
    public String deleteComment(@PathVariable Long id, @PathVariable Long commentId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Optional<Comment> commentOpt = commentService.getCommentById(commentId);
        if (commentOpt.isPresent()) {
            Comment comment = commentOpt.get();
            if (comment.getUser().getId().equals(user.getId()) || "admin".equals(user.getRole())) {
                commentService.deleteComment(commentId);
                session.setAttribute("success", "Komentar berhasil dihapus!");
            }
        }

        return "redirect:/songs/" + id;
    }

    @PostMapping("/{id}/like")
    public String toggleLike(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        userService.toggleLike(user.getId(), id);
        return "redirect:/songs/" + id;
    }
}
