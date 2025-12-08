package com.example.tubes.controller;

import com.example.tubes.entity.User;
import com.example.tubes.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        User user = userService.login(email, password);
        if (user != null) {
            session.setAttribute("user", user);
            return "redirect:/";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "auth/login";
        }
    }

    @GetMapping("/register")
    public String showRegisterForm(org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("showRegister", true);
        return "redirect:/login";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user, Model model,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        try {
            userService.register(user);
            redirectAttributes.addFlashAttribute("success", "Registrasi berhasil! Silakan login.");
            return "redirect:/login";
        } catch (RuntimeException e) {
            String errorMessage = e.getMessage();
            if (errorMessage == null || errorMessage.trim().isEmpty()) {
                errorMessage = "Terjadi kesalahan saat registrasi.";
            }
            redirectAttributes.addFlashAttribute("error", errorMessage);
            redirectAttributes.addFlashAttribute("registerError", true);
            redirectAttributes.addFlashAttribute("user", user); // Keep filled data
            return "redirect:/login";
        }
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
