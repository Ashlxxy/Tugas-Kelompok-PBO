package com.example.tubes.controller;

import com.example.tubes.entity.Feedback;
import com.example.tubes.entity.User;
import com.example.tubes.service.FeedbackService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    @GetMapping
    public String index(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        return "feedback/index";
    }

    @PostMapping
    public String store(@ModelAttribute Feedback feedback, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        feedback.setName(user.getUsername());
        feedback.setEmail(user.getEmail());
        feedbackService.saveFeedback(feedback);
        session.setAttribute("success", "Feedback sent successfully!");
        return "redirect:/feedback";
    }
}
