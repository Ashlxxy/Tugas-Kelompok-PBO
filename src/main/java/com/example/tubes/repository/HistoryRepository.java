package com.example.tubes.repository;

import com.example.tubes.entity.History;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface HistoryRepository extends JpaRepository<History, Long> {
    List<History> findByUserIdOrderByPlayedAtDesc(Long userId);
}
