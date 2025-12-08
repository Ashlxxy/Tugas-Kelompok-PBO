package com.example.tubes.service;

import com.example.tubes.entity.Feedback;
import com.example.tubes.repository.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    public void saveFeedback(Feedback feedback) {
        feedbackRepository.save(feedback);
    }

    public java.util.List<Feedback> getAllFeedbacks() {
        return feedbackRepository.findAll();
    }
}
