package com.example.tubes.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateUtil {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    // Private constructor to prevent instantiation (Static class concept)
    private DateUtil() {
    }

    public static String format(LocalDateTime dateTime) {
        if (dateTime == null)
            return "";
        return dateTime.format(FORMATTER);
    }
}
