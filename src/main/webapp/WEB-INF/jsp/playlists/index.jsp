<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <div class="container-xxl py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0">Playlist Saya</h3>
                <a href="${pageContext.request.contextPath}/playlists/create" class="btn btn-accent">
                    <i class="bi bi-plus-lg me-1"></i>Buat Playlist
                </a>
            </div>

            <div class="row g-3">
                <c:choose>
                    <c:when test="${not empty playlists}">
                        <c:forEach items="${playlists}" var="playlist">
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 fade-in">
                                <div class="card song p-2 h-100 hover-scale"
                                    onclick="window.location.href='${pageContext.request.contextPath}/playlists/${playlist.id}'"
                                    style="cursor: pointer;">
                                    <div
                                        class="ratio ratio-1x1 bg-dark-800 rounded mb-2 d-flex align-items-center justify-content-center">
                                        <i class="bi bi-music-note-list display-4 text-dark-700"></i>
                                    </div>
                                    <div class="d-flex flex-column">
                                        <div class="fw-semibold text-truncate">${playlist.name}</div>
                                        <div class="small text-dark-300 text-truncate">${playlist.songs.size()} Lagu
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center text-dark-300 py-5">
                            <i class="bi bi-music-note-list display-1 mb-3 d-block text-dark-700"></i>
                            <p>Anda belum memiliki playlist.</p>
                            <a href="${pageContext.request.contextPath}/playlists/create"
                                class="btn btn-outline-accent mt-2">Buat Sekarang</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />