package com.example.tubes.controller;

import com.example.tubes.repository.JdbcReportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReportController {

    @Autowired
    private JdbcReportRepository jdbcReportRepository;

    @GetMapping("/report")
    public String index(Model model) {
        model.addAttribute("stats", jdbcReportRepository.getSongStats());
        return "report/index";
    }
}
