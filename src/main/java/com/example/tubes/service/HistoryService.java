package com.example.tubes.service;

import com.example.tubes.entity.History;
import com.example.tubes.repository.HistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HistoryService {

    @Autowired
    private HistoryRepository historyRepository;

    public void addHistory(History history) {
        historyRepository.save(history);
    }

    public List<History> getHistoryByUserId(Long userId) {
        return historyRepository.findByUserIdOrderByPlayedAtDesc(userId);
    }
}
