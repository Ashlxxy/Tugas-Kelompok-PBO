<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
            <jsp:include page="../layout/header.jsp" />

            <div class="container-xxl py-5 fade-in">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="card-dark p-0 rounded-4 border-dark-700 shadow-lg overflow-hidden">
                            <div class="row g-0">
                                <!-- Left Column: Cover Image -->
                                <div class="col-md-4">
                                    <img src="${pageContext.request.contextPath}${song.coverPath}"
                                        class="w-100 h-100 object-fit-cover" style="aspect-ratio: 1/1;"
                                        alt="${song.title}">
                                </div>

                                <!-- Right Column: Details & Player -->
                                <div class="col-md-8 p-4 d-flex flex-column justify-content-center">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h1 class="display-5 fw-bold mb-1 text-white">${song.title}</h1>
                                            <h4 class="text-accent mb-3">${song.artist}</h4>
                                        </div>
                                        <div class="d-flex gap-2">
                                            <form action="${pageContext.request.contextPath}/songs/${song.id}/like"
                                                method="POST">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.user}">
                                                        <button
                                                            class="btn ${isLiked ? 'btn-accent' : 'btn-outline-accent'}">
                                                            <i class="bi ${isLiked ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                                            ${song.likes}
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-outline-accent">
                                                            <i class="bi bi-heart"></i> ${song.likes}
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                            <button class="btn btn-outline-accent" data-bs-toggle="modal"
                                                data-bs-target="#playlistModal">
                                                <i class="bi bi-plus-lg"></i> Playlist
                                            </button>
                                        </div>
                                    </div>

                                    <p class="text-dark-200 lead mb-4" style="font-size: 1rem;">${song.description}</p>

                                    <!-- Global Player Integration -->
                                    <div class="mb-4">
                                        <button
                                            class="btn btn-accent btn-lg rounded-pill px-4 d-flex align-items-center gap-2"
                                            data-id="${song.id}" data-title="${song.title}" data-artist="${song.artist}"
                                            data-cover="${pageContext.request.contextPath}${song.coverPath}"
                                            data-file="${pageContext.request.contextPath}${song.filePath}"
                                            onclick="Player.playSongFromElement(this)">
                                            <i class="bi bi-play-fill fs-4"></i> Putar Sekarang
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Comments Section -->
                <div class="row mt-5 justify-content-center">
                    <div class="col-lg-10">
                        <h4 class="mb-3">Komentar</h4>

                        <c:if test="${not empty sessionScope.success}">
                            <div class="alert bg-dark-800 border-success text-success mb-4 alert-dismissible fade show"
                                role="alert">
                                <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.success}
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div>
                            <c:remove var="success" scope="session" />
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <form action="${pageContext.request.contextPath}/songs/${song.id}/comments"
                                    method="POST" class="mb-4">
                                    <div class="input-group">
                                        <input type="text" name="content" class="form-control form-control-dark"
                                            placeholder="Tulis komentar..." required>
                                        <button class="btn btn-accent" type="submit"><i class="bi bi-send"></i></button>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-dark mb-4">Silakan login untuk menulis komentar.</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="list-group list-group-flush rounded-3 overflow-hidden">
                            <c:choose>
                                <c:when test="${not empty comments}">
                                    <c:forEach items="${comments}" var="comment">
                                        <c:if test="${empty comment.parent}">
                                            <t:comment comment="${comment}" songId="${song.id}" depth="0" />
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-dark-300 py-3">Belum ada komentar.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Playlist Modal -->
            <div class="modal fade" id="playlistModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content card-dark">
                        <div class="modal-header border-dark-700">
                            <h5 class="modal-title"><i class="bi bi-music-note-list me-2"></i>Tambahkan ke Playlist</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <div class="text-center py-4">
                                        <i class="bi bi-lock display-4 text-dark-300 mb-3 d-block"></i>
                                        <p class="text-dark-200 mb-3">Login untuk menambahkan lagu ke playlist.</p>
                                        <a href="${pageContext.request.contextPath}/login" class="btn btn-accent">Login
                                            Sekarang</a>
                                    </div>
                                </c:when>
                                <c:when test="${empty userPlaylists}">
                                    <div class="text-center py-4">
                                        <i class="bi bi-music-player display-4 text-dark-300 mb-3 d-block"></i>
                                        <p class="text-dark-200 mb-3">Anda belum memiliki playlist.</p>
                                        <form action="${pageContext.request.contextPath}/playlists" method="POST">
                                            <input type="hidden" name="songId" value="${song.id}">
                                            <div class="input-group">
                                                <input type="text" name="name" class="form-control form-control-dark"
                                                    placeholder="Nama Playlist Baru..." required>
                                                <button class="btn btn-accent">Buat</button>
                                            </div>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-dark-300 mb-3 small">Pilih playlist untuk menambahkan lagu ini:</p>
                                    <div class="list-group list-group-flush rounded-3 overflow-hidden">
                                        <c:forEach items="${userPlaylists}" var="playlist">
                                            <form
                                                action="${pageContext.request.contextPath}/playlists/${playlist.id}/songs"
                                                method="POST">
                                                <input type="hidden" name="songId" value="${song.id}">
                                                <button type="submit"
                                                    class="list-group-item list-group-item-action bg-dark-900 border-dark-700 d-flex justify-content-between align-items-center p-3">
                                                    <span class="fw-medium text-white">${playlist.name}</span>
                                                    <%-- Check if song is already in playlist --%>
                                                        <c:set var="inPlaylist" value="false" />
                                                        <c:forEach items="${playlist.songs}" var="pSong">
                                                            <c:if test="${pSong.id == song.id}">
                                                                <c:set var="inPlaylist" value="true" />
                                                            </c:if>
                                                        </c:forEach>

                                                        <c:choose>
                                                            <c:when test="${inPlaylist}">
                                                                <span class="badge bg-success"><i
                                                                        class="bi bi-check"></i>
                                                                    Sudah
                                                                    Ada</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-dark-700"><i
                                                                        class="bi bi-plus"></i>
                                                                    Tambah</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                </button>
                                            </form>
                                        </c:forEach>
                                    </div>
                                    <div class="mt-4 pt-3 border-top border-dark-700">
                                        <p class="text-dark-300 mb-2 small">Atau buat playlist baru:</p>
                                        <form action="${pageContext.request.contextPath}/playlists" method="POST">
                                            <div class="input-group">
                                                <input type="text" name="name" class="form-control form-control-dark"
                                                    placeholder="Nama Playlist Baru..." required>
                                                <button class="btn btn-accent">Buat</button>
                                            </div>
                                        </form>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="../layout/footer.jsp" />

            <!-- Delete Comment Modal -->
            <div class="modal fade" id="deleteCommentModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content card-dark">
                        <div class="modal-header border-dark-700">
                            <h5 class="modal-title text-danger"><i
                                    class="bi bi-exclamation-triangle-fill me-2"></i>Hapus Komentar</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="text-dark-200 mb-0">Apakah Anda yakin ingin menghapus komentar ini? Tindakan ini
                                tidak dapat dibatalkan.</p>
                        </div>
                        <div class="modal-footer border-dark-700">
                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Batal</button>
                            <form id="deleteCommentForm" action="" method="POST">
                                <button type="submit" class="btn btn-danger">Hapus</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function confirmDeleteComment(url) {
                    document.getElementById('deleteCommentForm').action = url;
                    new bootstrap.Modal(document.getElementById('deleteCommentModal')).show();
                }
            </script>