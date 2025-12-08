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
        // User can see form, maybe list their own feedback?
        // Or just a form. Laravel usually shows a form.
        // Let's check blade first, but for now just return view.
        return "feedback/index";
    }

    @PostMapping
    public String store(@ModelAttribute Feedback feedback, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        // Feedback entity might not have user relation if it's anonymous, but here we
        // require login.
        // Let's check Feedback entity.
        // Assuming it has name/email/message.
        feedback.setName(user.getUsername());
        feedback.setEmail(user.getEmail());
        feedbackService.saveFeedback(feedback);
        session.setAttribute("success", "Feedback sent successfully!");
        return "redirect:/feedback";
    }
}
