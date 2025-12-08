package com.example.tubes.service;

import com.example.tubes.entity.Comment;
import com.example.tubes.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    public Comment addComment(Comment comment) {
        return commentRepository.save(comment);
    }

    public java.util.Optional<Comment> getCommentById(Long id) {
        return commentRepository.findById(id);
    }

    public void deleteComment(Long id) {
        commentRepository.deleteById(id);
    }

    public List<Comment> getCommentsBySongId(Long songId) {
        return commentRepository.findBySongId(songId);
    }
}
