package com.example.tubes.controller;

import com.example.tubes.entity.User;
import com.example.tubes.service.HistoryService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/history")
public class HistoryController {

    @Autowired
    private HistoryService historyService;

    @GetMapping
    public String index(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("histories", historyService.getHistoryByUserId(user.getId()));
        model.addAttribute("pageTitle", "Riwayat");
        return "history/index";
    }
}
