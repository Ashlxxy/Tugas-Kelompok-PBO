package com.example.tubes.controller;

import com.example.tubes.service.ISongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private ISongService songService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("songs", songService.getAllSongs());
        model.addAttribute("popularSongs", songService.getPopularSongs());
        return "home";
    }
}
