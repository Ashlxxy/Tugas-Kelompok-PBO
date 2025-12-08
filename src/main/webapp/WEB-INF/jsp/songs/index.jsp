<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <div class="container-xxl py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0">Semua Lagu</h3>

            </div>

            <c:if test="${not empty addToPlaylistId}">
                <div
                    class="alert bg-dark-800 border-accent text-accent mb-4 d-flex justify-content-between align-items-center">
                    <span>
                        <i class="bi bi-info-circle me-2"></i>
                        Menambahkan lagu ke playlist <strong>"${targetPlaylistName}"</strong>
                    </span>
                    <a href="${pageContext.request.contextPath}/playlists/${addToPlaylistId}"
                        class="btn btn-sm btn-outline-light">Selesai</a>
                </div>
            </c:if>

            <div class="row g-3">
                <c:choose>
                    <c:when test="${not empty songs}">
                        <c:forEach items="${songs}" var="song">
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 fade-in">
                                <div class="card song p-2 h-100 hover-scale"
                                    onclick="window.location.href='${pageContext.request.contextPath}/songs/${song.id}'"
                                    style="cursor: pointer;">
                                    <img src="${pageContext.request.contextPath}${song.coverPath}" alt="${song.title}"
                                        class="card-img-top rounded mb-2 shadow-sm"
                                        style="width: 100%; aspect-ratio: 1/1; object-fit: cover;">
                                    <div class="card-body p-0">
                                        <h6 class="card-title text-truncate mb-0 fw-bold text-white"
                                            title="${song.title}">${song.title}</h6>
                                        <p class="card-text text-dark-200 text-truncate small">${song.artist}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center text-dark-300 py-5">
                            Tidak ada lagu ditemukan.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />