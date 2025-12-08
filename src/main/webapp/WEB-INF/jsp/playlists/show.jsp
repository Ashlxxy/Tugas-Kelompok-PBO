<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <div class="container-xxl py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-dark-800 rounded p-3">
                        <i class="bi bi-music-note-list display-4 text-accent"></i>
                    </div>
                    <div>
                        <h2 class="mb-0 fw-bold">${playlist.name}</h2>
                        <p class="text-dark-300 mb-0">${playlist.songs.size()} Lagu</p>
                    </div>
                </div>
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/songs?addToPlaylist=${playlist.id}"
                        class="btn btn-outline-accent me-2">
                        <i class="bi bi-plus-lg me-1"></i>Tambah Lagu
                    </a>
                    <c:if test="${not empty playlist.songs}">
                        <button class="btn btn-accent me-2"
                            onclick="Player.playAll(document.querySelector('.list-group'))">
                            <i class="bi bi-play-fill me-1"></i>Putar Playlist
                        </button>
                    </c:if>
                    <form id="deletePlaylistForm"
                        action="${pageContext.request.contextPath}/playlists/${playlist.id}/delete" method="POST">
                        <button type="button" class="btn btn-danger" onclick="showDeletePlaylistModal()">
                            <i class="bi bi-trash me-1"></i>Hapus Playlist
                        </button>
                    </form>
                </div>
            </div>

            <div class="card-dark rounded-4 overflow-hidden">
                <div class="list-group list-group-flush">
                    <c:forEach items="${playlist.songs}" var="song">
                        <div
                            class="list-group-item bg-dark-900 border-dark-700 p-3 d-flex justify-content-between align-items-center hover-bg-dark-800 transition-all">
                            <div class="d-flex align-items-center gap-3 flex-grow-1" style="cursor: pointer;">
                                <div class="position-relative group"
                                    onclick="event.stopPropagation(); Player.playSongFromElement(this.querySelector('button'));">
                                    <img src="${pageContext.request.contextPath}${song.coverPath}" class="rounded"
                                        width="50" height="50" alt="${song.title}">
                                    <button
                                        class="btn btn-sm btn-accent-soft rounded-circle p-0 d-flex align-items-center justify-content-center position-absolute top-50 start-50 translate-middle opacity-0 group-hover-opacity-100 transition-all"
                                        style="width: 32px; height: 32px;" data-id="${song.id}"
                                        data-title="${song.title}" data-artist="${song.artist}"
                                        data-cover="${pageContext.request.contextPath}${song.coverPath}"
                                        data-file="${pageContext.request.contextPath}${song.filePath}">
                                        <i class="bi bi-play-fill"></i>
                                    </button>
                                </div>
                                <div
                                    onclick="window.location.href='${pageContext.request.contextPath}/songs/${song.id}'">
                                    <h5 class="mb-0 text-white">${song.title}</h5>
                                    <small class="text-dark-300">${song.artist}</small>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/playlists/${playlist.id}/songs/remove"
                                method="POST" class="ms-3">
                                <input type="hidden" name="songId" value="${song.id}">
                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Hapus dari playlist">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                    <c:if test="${empty playlist.songs}">
                        <div class="text-center py-5 text-dark-300">
                            <i class="bi bi-music-note-beamed display-1 mb-3 d-block text-dark-800"></i>
                            <p>Playlist ini masih kosong.</p>
                            <a href="${pageContext.request.contextPath}/songs?addToPlaylist=${playlist.id}"
                                class="btn btn-outline-accent mt-2">Cari
                                Lagu</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Custom Delete Playlist Modal -->
        <div id="deletePlaylistModal"
            class="position-fixed top-0 start-0 w-100 h-100 d-none justify-content-center align-items-center fade-in"
            style="z-index: 2000; background: rgba(0,0,0,0.6); backdrop-filter: blur(4px);">

            <div class="bg-dark-900 rounded-4 p-4 text-center shadow-lg border border-dark-700"
                style="width: 400px; max-width: 90%; transform: scale(1); transition: transform 0.3s;">

                <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-danger bg-opacity-10 mb-3"
                    style="width: 80px; height: 80px;">
                    <i class="bi bi-trash3-fill text-danger display-4"></i>
                </div>

                <h4 class="fw-bold text-white mb-2">Hapus Playlist?</h4>
                <p class="text-dark-300 small mb-4">
                    Apakah Anda yakin ingin menghapus playlist <strong>"${playlist.name}"</strong>?
                    Tindakan ini tidak dapat dibatalkan.
                </p>

                <div class="d-flex gap-2 justify-content-center">
                    <button class="btn btn-outline-secondary w-100 rounded-pill" onclick="closeDeletePlaylistModal()">
                        Batal
                    </button>
                    <button class="btn btn-danger w-100 rounded-pill" onclick="confirmDeletePlaylist()">
                        Hapus
                    </button>
                </div>
            </div>
        </div>

        <script>
            function showDeletePlaylistModal() {
                const modal = document.getElementById('deletePlaylistModal');
                modal.classList.remove('d-none');
                modal.classList.add('d-flex');
            }

            function closeDeletePlaylistModal() {
                const modal = document.getElementById('deletePlaylistModal');
                modal.classList.add('d-none');
                modal.classList.remove('d-flex');
            }

            function confirmDeletePlaylist() {
                document.getElementById('deletePlaylistForm').submit();
            }

            // Close modal on click outside
            document.getElementById('deletePlaylistModal').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeDeletePlaylistModal();
                }
            });
        </script>

        <jsp:include page="../layout/footer.jsp" />