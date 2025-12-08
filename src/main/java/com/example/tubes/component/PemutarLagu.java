package com.example.tubes.component;

import com.example.tubes.interfaces.Playable;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;

@Component
@SessionScope
public class PemutarLagu implements Playable {

    private String status = "STOPPED";
    private int volume = 50;
    private boolean autoplay = false;

    @Override
    public void play() {
        this.status = "PLAYING";
        System.out.println("Music is playing");
    }

    @Override
    public void pause() {
        this.status = "PAUSED";
        System.out.println("Music is paused");
    }

    @Override
    public void next() {
        System.out.println("Playing next song");
    }

    @Override
    public void previous() {
        System.out.println("Playing previous song");
    }

    @Override
    public void repeat() {
        System.out.println("Repeating current song");
    }

    // Getters and Setters
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getVolume() {
        return volume;
    }

    public void setVolume(int volume) {
        this.volume = volume;
    }

    public boolean isAutoplay() {
        return autoplay;
    }

    public void setAutoplay(boolean autoplay) {
        this.autoplay = autoplay;
    }
}
