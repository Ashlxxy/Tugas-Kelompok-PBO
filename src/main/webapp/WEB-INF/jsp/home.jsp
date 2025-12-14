<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="layout/header.jsp" />

        <header class="hero container-xxl py-5">
            <div class="row align-items-center g-4">
                <div class="col-lg-7 fade-in">
                    <h1 class="display-5 fw-bold lh-1">UKM Band Universitas Telkom<br><span
                            class="text-accent">Organisasi Musik Dari Universitas Telkom</span></h1>
                    <p class="lead text-dark-200 mt-3">Dengarkan lagu, baca deskripsi, simpan ke playlist, dan beri
                        apresiasi.</p>
                    <div class="d-flex gap-2 mt-2">
                        <a class="btn btn-accent" href="#descriptions"><i class="bi bi-card-text me-1"></i>Daftar
                            Deskripsi Lagu</a>
                        <a class="btn btn-outline-accent" href="#popular"><i class="bi bi-fire me-1"></i>Populer</a>
                    </div>
                </div>
                <div class="col-lg-5 fade-in" style="animation-delay: 0.2s;">
                    <c:if test="${not empty songs}">
                        <c:set var="latestSong" value="${songs[0]}" />
                        <div class="hero-card p-3 rounded-4 bg-dark-900 border border-dark-700 hover-scale"
                            onclick="window.location.href='${pageContext.request.contextPath}/songs/${latestSong.id}'"
                            style="cursor: pointer;">
                            <div class="ratio ratio-16x9 rounded-3 bg-dark-800 overflow-hidden">
                                <img src="${pageContext.request.contextPath}${latestSong.coverPath}"
                                    alt="${latestSong.title}" class="w-100 h-100 object-fit-cover">
                            </div>
                            <div class="mt-3">
                                <div class="badge bg-accent-soft">Terbaru</div>
                                <h4 class="mt-2">${latestSong.title}</h4>
                                <div class="text-dark-200">${latestSong.artist}</div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </header>

        <div class="container-xxl pb-5">
            <section id="popular" class="mt-4 fade-in" style="animation-delay: 0.4s; scroll-margin-top: 100px;">
                <div class="d-flex justify-content-between align-items-end mb-2">
                    <h3 class="mb-0">Paling Populer</h3>
                    <small class="text-dark-300 fst-italic">Berdasarkan like + pemutaran</small>
                </div>
                <div class="row g-3">
                    <c:choose>
                        <c:when test="${not empty popularSongs}">
                            <c:forEach items="${popularSongs}" var="song" end="5">
                                <div class="col-6 col-sm-4 col-md-3 col-lg-2">
                                    <div class="card song p-2 h-100 hover-scale"
                                        onclick="window.location.href='${pageContext.request.contextPath}/songs/${song.id}'">
                                        <img src="${pageContext.request.contextPath}${song.coverPath}"
                                            class="cover w-100 mb-2 rounded" alt="${song.title}">
                                        <div class="d-flex flex-column">
                                            <div class="fw-semibold text-truncate">${song.title}</div>
                                            <div class="small text-dark-300 text-truncate">${song.artist}</div>
                                            <div class="mt-2 d-flex align-items-center gap-2">
                                                <button
                                                    class="btn btn-sm btn-accent-soft rounded-circle p-0 d-flex align-items-center justify-content-center"
                                                    style="width: 32px; height: 32px;" data-id="${song.id}"
                                                    data-title="${song.title}" data-artist="${song.artist}"
                                                    data-cover="${pageContext.request.contextPath}${song.coverPath}"
                                                    data-file="${pageContext.request.contextPath}${song.filePath}"
                                                    onclick="event.stopPropagation(); Player.playSongFromElement(this)">
                                                    <i class="bi bi-play-fill"></i>
                                                </button>
                                                <span class="small text-white-50"><i
                                                        class="bi bi-play-fill me-1"></i>${song.plays}</span>
                                                <span class="badge bg-accent-soft ms-auto"><i
                                                        class="bi bi-heart-fill"></i>
                                                    ${song.likes}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center text-dark-300 py-5">
                                Belum ada lagu yang diunggah.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <section id="descriptions" class="mt-5 fade-in" style="animation-delay: 0.6s; scroll-margin-top: 100px;">
                <h3 class="mb-4">Deskripsi Lagu</h3>
                <div class="row g-4" id="description-container">
                    <c:choose>
                        <c:when test="${not empty songs}">
                            <c:forEach items="${songs}" var="song" varStatus="status">
                                <div class="col-md-6 col-lg-4 song-desc-item ${status.index >= 6 ? 'd-none' : ''}">
                                    <div class="card song p-3 h-100">
                                        <div class="d-flex align-items-start gap-3">
                                            <img src="${pageContext.request.contextPath}${song.coverPath}" width="96"
                                                height="96" class="rounded-3 object-fit-cover" alt="${song.title}">
                                            <div class="flex-fill">
                                                <div class="fw-semibold">${song.title}</div>
                                                <div class="small text-dark-300 mb-2">${song.artist}</div>
                                                <p class="small text-dark-200 mb-0">${song.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center text-dark-300">
                                Belum ada deskripsi lagu.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${not empty songs && songs.size() > 6}">
                    <div class="text-center mt-4">
                        <button id="loadMoreBtn" class="btn btn-outline-accent rounded-pill px-4">
                            Lihat Selengkapnya <i class="bi bi-chevron-down ms-1"></i>
                        </button>
                    </div>
                    <script>
                        const loadMoreBtn = document.getElementById('loadMoreBtn');
                        let isExpanded = false;

                        loadMoreBtn.addEventListener('click', function () {
                            const hiddenItems = document.querySelectorAll('.song-desc-item');

                            isExpanded = !isExpanded;

                            hiddenItems.forEach((item, index) => {
                                if (index >= 6) {
                                    if (isExpanded) {
                                        item.classList.remove('d-none');
                                        item.classList.add('fade-in');
                                    } else {
                                        item.classList.add('d-none');
                                        item.classList.remove('fade-in');
                                    }
                                }
                            });

                            if (isExpanded) {
                                this.innerHTML = 'Lihat Lebih Sedikit <i class="bi bi-chevron-up ms-1"></i>';
                            } else {
                                this.innerHTML = 'Lihat Selengkapnya <i class="bi bi-chevron-down ms-1"></i>';

                            }
                        });
                    </script>
                </c:if>
            </section>
        </div>

        <jsp:include page="layout/footer.jsp" />

        <c:if test="${not empty songs}">
            <c:set var="topSong" value="${songs[0]}" />
            <script>
                document.addEventListener('DOMContentLoaded', () => {

                    setTimeout(() => {
                        if (!localStorage.getItem('queue') || JSON.parse(localStorage.getItem('queue')).length === 0) {
                            const defaultSong = {
                                id: '${topSong.id}',
                                title: '${topSong.title}',
                                artist: '${topSong.artist}',
                                coverPath: '${pageContext.request.contextPath}${topSong.coverPath}',
                                filePath: '${pageContext.request.contextPath}${topSong.filePath}'
                            };
                            console.log("Seeding default song:", defaultSong.title);
                            Player.playContext([defaultSong], 0, false);
                        }
                    }, 100);
                });
            </script>
        </c:if>