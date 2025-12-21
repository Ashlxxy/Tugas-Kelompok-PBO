package com.example.tubes.component;

import com.example.tubes.entity.Song;
import com.example.tubes.repository.SongRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class MostPopular {

    @Autowired
    private SongRepository songRepository;

    private List<Song> daftarPopuler;

    public void tampilkanTopLagu() {
        this.daftarPopuler = songRepository.findTop10ByOrderByPlaysDesc();
        System.out.println("Top Songs:");
        for (Song song : daftarPopuler) {
            System.out.println(song.getTitle() + " - " + song.getPlays() + " plays");
        }
    }

    public List<Song> getDaftarPopuler() {
        if (daftarPopuler == null) {
            tampilkanTopLagu();
        }
        return daftarPopuler;
    }
}
