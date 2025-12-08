package com.example.tubes.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "histories")
public class History extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "song_id", nullable = false)
    private Song song;

    @Column(name = "played_at", nullable = false)
    private LocalDateTime playedAt;

    @PrePersist
    protected void onPlay() {
        if (playedAt == null) {
            playedAt = LocalDateTime.now();
        }
        super.onCreate();
    }

    // Getters and Setters
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Song getSong() {
        return song;
    }

    public void setSong(Song song) {
        this.song = song;
    }

    public LocalDateTime getPlayedAt() {
        return playedAt;
    }

    public void setPlayedAt(LocalDateTime playedAt) {
        this.playedAt = playedAt;
    }

    public String getFormattedPlayedAt() {
        if (playedAt == null)
            return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd MMMM yyyy, HH:mm").format(playedAt);
    }
}
