package com.example.tubes.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public String handleResourceNotFound(ResourceNotFoundException ex, Model model) {
        model.addAttribute("error", ex.getMessage());
        return "error/404";
    }

    @ExceptionHandler(org.springframework.web.multipart.MaxUploadSizeExceededException.class)
    public String handleMaxSizeException(org.springframework.web.multipart.MaxUploadSizeExceededException exc,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", "File terlalu besar! Maksimum upload adalah 200MB.");
        return "redirect:/admin/songs";
    }

    @ExceptionHandler(Exception.class)
    public String handleGeneralException(Exception ex, Model model, jakarta.servlet.http.HttpServletRequest request,
            jakarta.servlet.http.HttpServletResponse response) {
        if (response.isCommitted()) {
            return null; // Do not attempt to render a view if the response is already committed
        }

        // If request is for a static resource or API, returning HTML might not be
        // appropriate, but 500 page is fallback
        // For now, at least prevent the IllegalStateException

        model.addAttribute("error", "An unexpected error occurred: " + ex.getMessage());
        return "error/500";
    }
}
