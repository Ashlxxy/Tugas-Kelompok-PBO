package com.example.tubes.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class JdbcReportRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> getSongStats() {
        String sql = "SELECT title, artist, plays FROM songs ORDER BY plays DESC LIMIT 10";
        return jdbcTemplate.queryForList(sql);
    }
}
