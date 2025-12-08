package com.example.tubes.config;

import com.example.tubes.entity.Song;
import com.example.tubes.entity.User;
import com.example.tubes.repository.SongRepository;
import com.example.tubes.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class DataSeeder implements CommandLineRunner {

        @Autowired
        private SongRepository songRepository;

        @Autowired
        private UserRepository userRepository;

        @Override
        public void run(String... args) throws Exception {
                seedUsers();
                seedSongs();
        }

        private void seedUsers() {
                try {
                        User admin = userRepository.findByEmail("admin@example.com").orElse(new User());
                        admin.setUsername("Admin User");
                        admin.setEmail("admin@example.com");
                        admin.setPassword("password"); // Reset password to ensure access
                        admin.setRole("admin");
                        userRepository.save(admin);
                        userRepository.flush(); // Force write
                        System.out.println("Admin user updated/created: admin@example.com / password");

                        User user = userRepository.findByEmail("user@example.com").orElse(new User());
                        user.setUsername("Regular User");
                        user.setEmail("user@example.com");
                        user.setPassword("password");
                        user.setRole("user");
                        userRepository.save(user);
                        userRepository.flush(); // Force write
                        System.out.println("Regular user updated/created: user@example.com / password");
                } catch (Exception e) {
                        System.err.println("Error seeding users: " + e.getMessage());
                        e.printStackTrace();
                }
        }

        private void seedSongs() {
                List<Song> songsToSeed = Arrays.asList(
                                createSong("Lust", "Bachelor's Thrill",
                                                "Lagu penuh energi tentang hasrat, ketertarikan, dan dorongan emosi yang kuat. Menggambarkan sisi menggoda dan impulsif dari hubungan atau perasaan. Intens namun tetap menyenangkan untuk dinikmati.",
                                                "/assets/img/Bachelor_s Thrill - Lust.png",
                                                "/assets/songs/Bachelor_s Thrill - Lust.wav"),

                                createSong("Strangled", "Dystopia",
                                                "Sebuah lagu bernuansa intens tentang tekanan, kekacauan, dan rasa tercekik oleh keadaan. Menyampaikan atmosfir dunia yang tidak ideal dan penuh ketegangan, sekaligus menggambarkan perjuangan batin seseorang.",
                                                "/assets/img/Dystopia - Strangled.png",
                                                "/assets/songs/Dystopia - Strangled.wav"),
                                createSong("Au Revoir", "Elisya",
                                                "Lagu ini menggambarkan perpisahan yang lembut namun penuh makna. Ada kesedihan, keikhlasan, dan harapan yang terselip dalam setiap kata. Cocok untuk pendengar yang sedang merelakan atau menutup bab lama dalam hidup.",
                                                "/assets/img/Elisya - Au Revoir.png",
                                                "/assets/songs/elisya_au revoir.wav"),
                                createSong("Prisoner", "Secrets.",
                                                "Lagu ini menggambarkan perasaan terkurung oleh pikiran dan rahasia yang selama ini dipendam. Nuansanya emosional dan reflektif, cocok untuk pendengar yang sedang merasa terikat oleh sesuatu yang sulit diungkapkan.",
                                                "/assets/img/Secrets - Prisoner.png",
                                                "/assets/songs/Secrets. - Prisoner.wav"),
                                createSong("Langit Kelabu", "The Harper",
                                                "Lagu ini membawa suasana sendu dan melankolis, seperti langit mendung yang mencerminkan hati. Menggambarkan momen kesedihan, kehilangan, atau perasaan yang sulit disampaikan. Cocok untuk merenung dan melepas emosi.",
                                                "/assets/img/The Harper - Langit Kelabu.png",
                                                "/assets/songs/The Harper - Langit Kelabu.wav"),
                                createSong("New World", "The Overtrain",
                                                "Lagu ini bercerita tentang perjalanan menuju perubahan dan awal yang baru. Ada semangat, harapan, dan dorongan untuk meninggalkan masa lalu. Cocok untuk pendengar yang sedang memasuki fase baru dalam hidup.",
                                                "/assets/img/The Overtrain - New World.png",
                                                "/assets/songs/The Overtrain - New World.wav"),
                                createSong("Form", "Coral",
                                                "Sebuah lagu reflektif tentang pencarian jati diri dan proses perubahan dalam hidup. Nuansanya abstrak namun menenangkan, mengajak pendengar untuk memahami bentuk dan arah baru dalam perjalanan mereka.",
                                                "/assets/img/coral-form.png",
                                                "/assets/songs/coral_form.wav"));

                List<Song> existingSongs = songRepository.findAll();

                for (Song songData : songsToSeed) {
                        Song existingSong = existingSongs.stream()
                                        .filter(s -> s.getTitle().equalsIgnoreCase(songData.getTitle()))
                                        .findFirst()
                                        .orElse(null);

                        // Special handling for renaming "Coral" or "Coral Form" to "Form"
                        if (existingSong == null && songData.getTitle().equalsIgnoreCase("Form")) {
                                existingSong = existingSongs.stream()
                                                .filter(s -> s.getTitle().equalsIgnoreCase("Coral")
                                                                || s.getTitle().equalsIgnoreCase("Coral Form"))
                                                .findFirst()
                                                .orElse(null);
                        }

                        if (existingSong != null) {
                                // Update existing song
                                existingSong.setTitle(songData.getTitle());
                                existingSong.setArtist(songData.getArtist());
                                existingSong.setFilePath(songData.getFilePath());
                                existingSong.setCoverPath(songData.getCoverPath());
                                existingSong.setDescription(songData.getDescription());
                                songRepository.save(existingSong);
                                System.out.println("Updated song: " + songData.getTitle());
                        } else {
                                // Create new song
                                songRepository.save(songData);
                                System.out.println("Seeded song: " + songData.getTitle());
                        }
                }
                // Cleanup unwanted "Coral Form - Unknown"
                songRepository.findAll().forEach(s -> {
                        if ("Unknown".equalsIgnoreCase(s.getArtist()) && s.getTitle().contains("Coral")) {
                                songRepository.delete(s);
                                System.out.println("Deleted unwanted song: " + s.getTitle());
                        }
                });
        }

        private Song createSong(String title, String artist, String description, String coverPath, String filePath) {
                Song song = new Song();
                song.setTitle(title);
                song.setArtist(artist);
                song.setDescription(description);
                song.setCoverPath(coverPath);
                song.setFilePath(filePath);
                song.setPlays(0);
                song.setLikes(0);
                return song;
        }
}
