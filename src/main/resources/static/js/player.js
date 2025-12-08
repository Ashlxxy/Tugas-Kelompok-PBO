const Player = {
    audio: new Audio(),
    isPlaying: false,
    queue: [],
    currentIndex: -1,
    isShuffle: false,
    repeatMode: 'off', // off, all, one

    init() {
        console.log("Player v4 Initialized");
        // Restore state
        const savedQueue = localStorage.getItem('queue');
        const savedIndex = localStorage.getItem('currentIndex');
        const savedTime = localStorage.getItem('currentTime');
        const savedVolume = localStorage.getItem('volume');
        const wasPlaying = localStorage.getItem('isPlaying') === 'true';

        const savedShuffle = localStorage.getItem('isShuffle') === 'true';
        const savedRepeat = localStorage.getItem('repeatMode') || 'off';

        if (savedVolume) {
            this.audio.volume = parseFloat(savedVolume);
            document.getElementById('volume').value = savedVolume;
        }

        // Save state before leaving page
        window.addEventListener('beforeunload', () => {
            localStorage.setItem('currentTime', this.audio.currentTime);
            localStorage.setItem('isPlaying', this.isPlaying);
        });

        // Restore Shuffle/Repeat State
        this.isShuffle = savedShuffle;
        this.repeatMode = savedRepeat;

        // Update UI for Shuffle/Repeat
        const shuffleBtn = document.getElementById('btn-shuffle');
        if (shuffleBtn) {
            if (this.isShuffle) shuffleBtn.classList.add('text-accent');
        }

        const repeatBtn = document.getElementById('btn-repeat');
        if (repeatBtn) {
            const icon = repeatBtn.querySelector('i');
            if (this.repeatMode === 'all') {
                repeatBtn.classList.add('text-accent');
                if (icon) icon.className = 'bi bi-repeat';
            } else if (this.repeatMode === 'one') {
                repeatBtn.classList.add('text-accent');
                if (icon) icon.className = 'bi bi-repeat-1';
            } else {
                repeatBtn.classList.remove('text-accent');
                if (icon) icon.className = 'bi bi-repeat';
            }
        }

        if (savedQueue) {
            try {
                this.queue = JSON.parse(savedQueue);
                this.currentIndex = parseInt(savedIndex);

                if (!this.queue || this.queue.length === 0) {
                    // Invalid queue
                } else {
                    if (isNaN(this.currentIndex) || this.currentIndex < 0 || this.currentIndex >= this.queue.length) {
                        this.currentIndex = 0;
                    }

                    if (this.queue[this.currentIndex]) {
                        this.loadSong(this.queue[this.currentIndex], wasPlaying, savedTime ? parseFloat(savedTime) : 0);

                        // Force show bar
                        const bar = document.getElementById('player-bar');
                        if (bar) {
                            bar.classList.remove('d-none');
                            bar.classList.add('d-flex');
                        }
                    }
                }
            } catch (e) {
                console.error("Error restoring state:", e);
                localStorage.removeItem('queue');
            }
        } else {
            const title = document.getElementById('player-title');
            const artist = document.getElementById('player-artist');
            if (title) title.textContent = "Pilih lagu untuk memutar";
            if (artist) artist.textContent = "UKM Band";
            localStorage.setItem('isPlaying', 'false');
        }

        this.setupEventListeners();
    },

    setupEventListeners() {
        // Controls
        const playBtn = document.getElementById('play-pause-btn');
        if (playBtn) playBtn.addEventListener('click', () => this.togglePlay());

        const nextBtn = document.getElementById('btn-next');
        if (nextBtn) nextBtn.addEventListener('click', () => this.next());

        const prevBtn = document.getElementById('btn-prev');
        if (prevBtn) prevBtn.addEventListener('click', () => this.prev());

        const shuffleBtn = document.getElementById('btn-shuffle');
        if (shuffleBtn) shuffleBtn.addEventListener('click', () => this.toggleShuffle());

        const repeatBtn = document.getElementById('btn-repeat');
        if (repeatBtn) repeatBtn.addEventListener('click', () => this.toggleRepeat());

        const likeBtn = document.querySelector('#player-bar .bi-heart, #player-bar .bi-heart-fill');
        if (likeBtn) likeBtn.closest('button').addEventListener('click', () => this.toggleLike());

        // Audio Events
        this.audio.addEventListener('timeupdate', () => {
            this.updateProgressBar();
            localStorage.setItem('currentTime', this.audio.currentTime);
        });

        this.audio.addEventListener('ended', () => {
            if (this.repeatMode === 'one') {
                this.audio.currentTime = 0;
                this.audio.play();
            } else {
                this.next();
            }
        });

        this.audio.addEventListener('loadedmetadata', () => {
            const totalTimeEl = document.getElementById('total-time');
            if (totalTimeEl) totalTimeEl.textContent = this.formatTime(this.audio.duration);
        });

        // Progress & Volume
        const progressContainer = document.getElementById('progress-container');
        if (progressContainer) {
            progressContainer.addEventListener('click', (e) => {
                const width = e.currentTarget.clientWidth;
                const clickX = e.offsetX;
                const duration = this.audio.duration;
                this.audio.currentTime = (clickX / width) * duration;
            });
        }

        const volumeSlider = document.getElementById('volume');
        if (volumeSlider) {
            volumeSlider.addEventListener('input', (e) => {
                const vol = e.target.value;
                this.audio.volume = vol;
                localStorage.setItem('volume', vol);
                this.audio.volume = vol;
                localStorage.setItem('volume', vol);
            });
        }

        // Expanded Player Controls
        const expandBtn = document.getElementById('btn-expand');
        const collapseBtn = document.getElementById('btn-collapse');
        const expandedPlayer = document.getElementById('player-expanded');

        if (expandBtn && expandedPlayer) {
            expandBtn.addEventListener('click', () => {
                expandedPlayer.classList.remove('d-none');
                expandedPlayer.classList.add('d-flex');

                // Animation
                expandedPlayer.style.opacity = '0';
                expandedPlayer.style.transform = 'translateY(100%)';
                expandedPlayer.style.transition = 'all 0.4s cubic-bezier(0.16, 1, 0.3, 1)';

                // Force reflow
                expandedPlayer.offsetHeight;

                expandedPlayer.style.opacity = '1';
                expandedPlayer.style.transform = 'translateY(0)';
                document.body.style.overflow = 'hidden'; // Prevent scrolling
            });
        }

        if (collapseBtn && expandedPlayer) {
            collapseBtn.addEventListener('click', () => {
                expandedPlayer.style.opacity = '0';
                expandedPlayer.style.transform = 'translateY(100%)';

                setTimeout(() => {
                    expandedPlayer.classList.remove('d-flex');
                    expandedPlayer.classList.add('d-none');
                    document.body.style.overflow = '';
                }, 400); // Match transition duration
            });
        }

        // Expanded Control Bindings
        const playBtnEx = document.getElementById('play-pause-btn-expanded');
        if (playBtnEx) playBtnEx.addEventListener('click', () => this.togglePlay());

        const nextBtnEx = document.getElementById('btn-next-expanded');
        if (nextBtnEx) nextBtnEx.addEventListener('click', () => this.next());

        const prevBtnEx = document.getElementById('btn-prev-expanded');
        if (prevBtnEx) prevBtnEx.addEventListener('click', () => this.prev());

        const shuffleBtnEx = document.getElementById('btn-shuffle-expanded');
        if (shuffleBtnEx) shuffleBtnEx.addEventListener('click', () => this.toggleShuffle());

        const repeatBtnEx = document.getElementById('btn-repeat-expanded');
        if (repeatBtnEx) repeatBtnEx.addEventListener('click', () => this.toggleRepeat());

        const likeBtnEx = document.getElementById('btn-like-expanded');
        if (likeBtnEx) likeBtnEx.addEventListener('click', () => this.toggleLike());

        // Expanded Progress Bar
        const progressContainerEx = document.getElementById('progress-container-expanded');
        if (progressContainerEx) {
            progressContainerEx.addEventListener('click', (e) => {
                const width = e.currentTarget.clientWidth;
                const clickX = e.offsetX;
                const duration = this.audio.duration;
                this.audio.currentTime = (clickX / width) * duration;
            });
        }
    },

    playContext(songs, startIndex = 0, autoPlay = true) {
        this.queue = songs;
        this.currentIndex = startIndex;
        localStorage.setItem('queue', JSON.stringify(this.queue));
        this.playSong(this.queue[this.currentIndex], autoPlay);
    },

    playSongFromElement(element) {
        const container = element.closest('.row, .list-group');
        if (!container) {
            this.playContext([this.getSongData(element)], 0);
            return;
        }
        const buttons = Array.from(container.querySelectorAll('[data-id]'));
        const songs = buttons.map(btn => this.getSongData(btn));
        const targetId = element.dataset.id;
        const index = songs.findIndex(s => s.id === targetId);
        this.playContext(songs, index >= 0 ? index : 0);
    },

    playAll(container) {
        if (!container) return;
        const buttons = Array.from(container.querySelectorAll('[data-id]'));
        if (buttons.length === 0) return;
        const songs = buttons.map(btn => this.getSongData(btn));
        this.playContext(songs, 0, true);
    },

    getSongData(element) {
        return {
            id: element.dataset.id,
            title: element.dataset.title,
            artist: element.dataset.artist,
            coverPath: element.dataset.cover,
            filePath: element.dataset.file
        };
    },

    playSong(song, autoPlay = true) {
        if (!song) return;
        localStorage.setItem('currentIndex', this.currentIndex);

        // Update UI (Mini Player)
        const cover = document.getElementById('player-cover');
        const title = document.getElementById('player-title');
        const artist = document.getElementById('player-artist');

        if (cover) cover.src = song.coverPath;
        if (title) title.textContent = song.title;
        if (artist) artist.textContent = song.artist;

        // Update UI (Expanded Player)
        const coverEx = document.getElementById('player-cover-expanded');
        const titleEx = document.getElementById('player-title-expanded');
        const artistEx = document.getElementById('player-artist-expanded');

        if (coverEx) coverEx.src = song.coverPath;
        if (titleEx) titleEx.textContent = song.title;
        if (artistEx) artistEx.textContent = song.artist;

        const bar = document.getElementById('player-bar');
        if (bar) {
            bar.classList.remove('d-none');
            bar.classList.remove('active');
            bar.classList.add('d-flex');
        }

        this.checkLikeStatus(song.id);
        this.audio.src = song.filePath;
        this.audio.currentTime = 0;

        if (autoPlay) {
            const playPromise = this.audio.play();
            if (playPromise !== undefined) {
                playPromise
                    .then(() => {
                        this.isPlaying = true;
                        this.updatePlayButton();
                        // Record History
                        fetch('/api/history/record?songId=' + song.id, { method: 'POST' })
                            .catch(e => console.error("Failed to record history", e));
                    })
                    .catch(e => {
                        console.error("Playback failed:", e);
                        this.isPlaying = false;
                        this.updatePlayButton();
                    });
            }
        } else {
            this.isPlaying = false;
            this.updatePlayButton();
        }
        localStorage.setItem('isPlaying', this.isPlaying);
    },

    loadSong(song, autoPlay, startTime = 0) {
        if (!song) return;
        // Update Mini
        const cover = document.getElementById('player-cover');
        const title = document.getElementById('player-title');
        const artist = document.getElementById('player-artist');

        if (cover) cover.src = song.coverPath;
        if (title) title.textContent = song.title;
        if (artist) artist.textContent = song.artist;

        // Update Expanded
        const coverEx = document.getElementById('player-cover-expanded');
        const titleEx = document.getElementById('player-title-expanded');
        const artistEx = document.getElementById('player-artist-expanded');

        if (coverEx) coverEx.src = song.coverPath;
        if (titleEx) titleEx.textContent = song.title;
        if (artistEx) artistEx.textContent = song.artist;

        this.checkLikeStatus(song.id);
        this.audio.src = song.filePath;

        const onReadyToPlay = () => {
            this.audio.currentTime = startTime;
            if (autoPlay) {
                const playPromise = this.audio.play();
                if (playPromise !== undefined) {
                    playPromise
                        .then(() => {
                            this.isPlaying = true;
                            this.updatePlayButton();
                        })
                        .catch(e => {
                            console.error("Load auto-play failed (navigation):", e);
                            this.isPlaying = false;
                            this.updatePlayButton();
                        });
                }
            } else {
                this.isPlaying = false;
                this.updatePlayButton();
            }
        };
        this.audio.addEventListener('loadedmetadata', onReadyToPlay, { once: true });
        localStorage.setItem('isPlaying', this.isPlaying);
    },

    checkLikeStatus(songId) {
        fetch(`/api/songs/${songId}/liked`)
            .then(res => res.json())
            .then(data => {
                this.updateLikeButton(data.isLiked);
            })
            .catch(e => console.error("Error checking like status:", e));
    },

    toggleLike() {
        if (!this.queue[this.currentIndex]) return;
        const songId = this.queue[this.currentIndex].id;
        fetch(`/api/songs/${songId}/like`, { method: 'POST' })
            .then(res => {
                if (res.status === 401) {
                    window.location.href = '/login';
                    return;
                }
                return res.json();
            })
            .then(data => {
                if (data && data.success) {
                    this.updateLikeButton(data.isLiked);
                }
            })
            .catch(e => console.error("Error toggling like:", e));
    },

    updateLikeButton(isLiked) {
        // Update Mini Player
        const btn = document.querySelector('#player-bar .bi-heart, #player-bar .bi-heart-fill');

        // Update Expanded Player
        const btnEx = document.querySelector('#btn-like-expanded i');

        if (isLiked) {
            if (btn) {
                btn.classList.remove('bi-heart');
                btn.classList.add('bi-heart-fill');
                btn.classList.add('text-accent');
            }
            if (btnEx) {
                btnEx.classList.remove('bi-heart');
                btnEx.classList.add('bi-heart-fill');
                btnEx.classList.add('text-accent');
            }
        } else {
            if (btn) {
                btn.classList.remove('bi-heart-fill');
                btn.classList.remove('text-accent');
                btn.classList.add('bi-heart');
            }
            if (btnEx) {
                btnEx.classList.remove('bi-heart-fill');
                btnEx.classList.remove('text-accent');
                btnEx.classList.add('bi-heart');
            }
        }
    },

    togglePlay() {
        if (!this.audio.src || this.queue.length === 0) return;
        if (this.audio.paused) {
            this.audio.play()
                .then(() => {
                    this.isPlaying = true;
                    this.updatePlayButton();
                    localStorage.setItem('isPlaying', 'true');
                })
                .catch(e => {
                    this.isPlaying = false;
                    this.updatePlayButton();
                    localStorage.setItem('isPlaying', 'false');
                });
        } else {
            this.audio.pause();
            this.isPlaying = false;
            this.updatePlayButton();
            localStorage.setItem('isPlaying', 'false');
        }
    },

    next() {
        const nextBtn = document.getElementById('btn-next');
        const nextBtnEx = document.getElementById('btn-next-expanded');

        if (nextBtn) {
            nextBtn.classList.add('text-accent');
            setTimeout(() => nextBtn.classList.remove('text-accent'), 200);
        }
        if (nextBtnEx) {
            nextBtnEx.classList.add('text-accent');
            setTimeout(() => nextBtnEx.classList.remove('text-accent'), 200);
        }

        if (!this.queue) this.queue = [];
        if (this.queue.length === 0 || this.currentIndex >= this.queue.length - 1) {
            if (this.repeatMode === 'all' && this.queue.length > 0) {
                this.currentIndex = 0;
                this.playSong(this.queue[this.currentIndex]);
                return;
            }
            // Logic for auto-selecting a random song if queue ends (kept from original)
            const allPlayButtons = Array.from(document.querySelectorAll('button[data-file]'));
            if (allPlayButtons.length > 0) {
                let candidateBtn = allPlayButtons[Math.floor(Math.random() * allPlayButtons.length)];
                if (allPlayButtons.length > 1 && this.queue[this.currentIndex] && candidateBtn.getAttribute('data-id') == this.queue[this.currentIndex].id) {
                    candidateBtn = allPlayButtons[Math.floor(Math.random() * allPlayButtons.length)];
                }
                const nextSong = this.getSongData(candidateBtn);
                this.queue.push(nextSong);
                this.currentIndex++;
                this.playSong(this.queue[this.currentIndex]);
                localStorage.setItem('queue', JSON.stringify(this.queue));
                return;
            }
            return;
        }

        if (this.isShuffle) {
            this.currentIndex = Math.floor(Math.random() * this.queue.length);
        } else {
            this.currentIndex++;
        }
        this.playSong(this.queue[this.currentIndex]);
    },

    prev() {
        const prevBtn = document.getElementById('btn-prev');
        const prevBtnEx = document.getElementById('btn-prev-expanded');

        if (prevBtn) {
            prevBtn.classList.add('text-accent');
            setTimeout(() => prevBtn.classList.remove('text-accent'), 200);
        }
        if (prevBtnEx) {
            prevBtnEx.classList.add('text-accent');
            setTimeout(() => prevBtnEx.classList.remove('text-accent'), 200);
        }

        if (!this.queue || this.queue.length === 0) return;
        if (this.audio.currentTime > 3) {
            this.audio.currentTime = 0;
            return;
        }
        if (this.isShuffle) {
            this.currentIndex = Math.floor(Math.random() * this.queue.length);
        } else {
            this.currentIndex--;
            if (this.currentIndex < 0) this.currentIndex = 0;
        }
        this.playSong(this.queue[this.currentIndex]);
    },

    toggleShuffle() {
        this.isShuffle = !this.isShuffle;
        localStorage.setItem('isShuffle', this.isShuffle);

        const btn = document.getElementById('btn-shuffle');
        if (btn) btn.classList.toggle('text-accent', this.isShuffle);

        const btnEx = document.getElementById('btn-shuffle-expanded');
        if (btnEx) btnEx.classList.toggle('text-accent', this.isShuffle);
    },

    toggleRepeat() {
        const btn = document.getElementById('btn-repeat');
        const btnEx = document.getElementById('btn-repeat-expanded');

        this.updateRepeatState(btn);

        // Sync the state calculation is a bit tricky if we just call the same logic twice.
        // Instead, let's reset and re-calculate based on current state, but the original logic
        // advanced the state. We should advance global state once, then update UI.
    },

    // Helper to advance repeat mode
    cycleRepeatMode() {
        if (this.repeatMode === 'off') {
            this.repeatMode = 'all';
        } else if (this.repeatMode === 'all') {
            this.repeatMode = 'one';
        } else {
            this.repeatMode = 'off';
        }
        localStorage.setItem('repeatMode', this.repeatMode);
        this.syncRepeatUI();
    },

    syncRepeatUI() {
        const btn = document.getElementById('btn-repeat');
        const btnEx = document.getElementById('btn-repeat-expanded');

        [btn, btnEx].forEach(b => {
            if (!b) return;
            const icon = b.querySelector('i');
            if (this.repeatMode === 'all') {
                b.classList.add('text-accent');
                if (icon) icon.className = 'bi bi-repeat';
            } else if (this.repeatMode === 'one') {
                b.classList.add('text-accent');
                if (icon) icon.className = 'bi bi-repeat-1';
            } else {
                b.classList.remove('text-accent');
                if (icon) icon.className = 'bi bi-repeat';
            }
        });
    },

    // Overriding the original toggleRepeat to use the new synced logic
    toggleRepeat() {
        this.cycleRepeatMode();
    },

    updatePlayButton() {
        const btn = document.getElementById('play-pause-btn');
        const btnEx = document.getElementById('play-pause-btn-expanded');

        [btn, btnEx].forEach(b => {
            if (b) {
                const icon = b.querySelector('i');
                if (this.isPlaying) {
                    icon.classList.remove('bi-play-fill');
                    icon.classList.add('bi-pause-fill');
                } else {
                    icon.classList.remove('bi-pause-fill');
                    icon.classList.add('bi-play-fill');
                }
            }
        });
    },

    updateProgressBar() {
        const current = this.audio.currentTime;
        const duration = this.audio.duration || 1;
        const percent = (current / duration) * 100;

        // Mini Player
        const fill = document.getElementById('progress-fill');
        const timeLab = document.getElementById('current-time');

        // Expanded Player
        const fillEx = document.getElementById('progress-fill-expanded');
        const timeLabEx = document.getElementById('current-time-expanded');
        const totalTimeEx = document.getElementById('total-time-expanded');

        if (fill) fill.style.width = percent + '%';
        if (timeLab) timeLab.textContent = this.formatTime(current);

        if (fillEx) fillEx.style.width = percent + '%';
        if (timeLabEx) timeLabEx.textContent = this.formatTime(current);
        if (totalTimeEx) totalTimeEx.textContent = this.formatTime(duration);
    },

    formatTime(seconds) {
        if (isNaN(seconds)) return "0:00";
        const min = Math.floor(seconds / 60);
        const sec = Math.floor(seconds % 60);
        return `${min}:${sec < 10 ? '0' + sec : sec}`;
    }
};

window.Player = Player;
document.addEventListener('DOMContentLoaded', () => Player.init());
