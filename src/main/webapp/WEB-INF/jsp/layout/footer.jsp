<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
        </main>


        <c:set var="reqUrl" value="${pageContext.request.requestURI}" />
        <c:set var="isAuthPage" value="${fn:contains(reqUrl, '/login') or fn:contains(reqUrl, '/register')}" />



        <style>
            /* Base Mobile View */
            .desktop-view {
                display: none !important;
            }

            .mobile-view {
                display: flex !important;
            }

            .player-section-left,
            .player-section-right {
                width: auto;
                flex-grow: 1;
            }

            /* Desktop View Breakpoint */
            @media (min-width: 768px) {
                .desktop-view {
                    display: flex !important;
                }

                .mobile-view {
                    display: none !important;
                }

                .player-section-left {
                    width: 30% !important;
                    flex-grow: 0;
                    min-width: 180px;
                }

                .player-section-right {
                    width: 30% !important;
                    flex-grow: 0;
                }
            }
        </style>

        <c:if test="${not isAuthPage}">
            <div id="player-bar"
                class="fixed-bottom bg-dark border-top border-secondary p-3 d-flex flex-nowrap align-items-center justify-content-between text-white"
                style="z-index: 1050; background-color: #181818 !important;">

                <div class="d-flex align-items-center player-section-left">
                    <img id="player-cover" src="" alt="Cover" class="rounded me-3 bg-secondary"
                        style="width: 56px; height: 56px; object-fit: cover;">
                    <div class="d-flex flex-column overflow-hidden me-3">
                        <div id="player-title" class="fw-bold text-truncate" style="font-size: 0.9rem;">Judul Lagu
                        </div>
                        <div id="player-artist" class="small text-secondary text-truncate" style="font-size: 0.75rem;">
                            Artis</div>
                    </div>
                    <button class="btn btn-link link-light p-0 text-secondary desktop-view"><i
                            class="bi bi-heart"></i></button>
                </div>


                <div class="desktop-view flex-column align-items-center justify-content-center"
                    style="width: 40%; max-width: 600px;">
                    <div class="d-flex align-items-center gap-3 mb-1">
                        <button id="btn-shuffle" class="btn btn-link link-secondary p-0 fs-5"><i
                                class="bi bi-shuffle"></i></button>
                        <button id="btn-prev" class="btn btn-link link-secondary p-0 fs-4"><i
                                class="bi bi-skip-start-fill"></i></button>
                        <button id="play-pause-btn"
                            class="btn btn-light rounded-circle p-0 d-flex align-items-center justify-content-center"
                            style="width: 32px; height: 32px; font-size: 1.2rem;">
                            <i class="bi bi-play-fill text-dark"></i>
                        </button>
                        <button id="btn-next" class="btn btn-link link-secondary p-0 fs-4"><i
                                class="bi bi-skip-end-fill"></i></button>
                        <button id="btn-repeat" class="btn btn-link link-secondary p-0 fs-5"><i
                                class="bi bi-repeat"></i></button>
                    </div>
                    <div class="d-flex align-items-center gap-2 w-100 text-secondary" style="font-size: 0.75rem;">
                        <span id="current-time" style="min-width: 35px; text-align: center;">0:00</span>
                        <div id="progress-container" class="progress flex-grow-1"
                            style="height: 4px; cursor: pointer; background-color: #4f4f4f;">
                            <div id="progress-fill" class="progress-bar bg-white rounded-pill" role="progressbar"
                                style="width: 0%;"></div>
                        </div>
                        <span id="total-time" style="min-width: 35px; text-align: center;">0:00</span>
                    </div>
                </div>


                <div class="d-flex align-items-center justify-content-end gap-2 player-section-right">

                    <!-- Mobile Play Button -->
                    <button id="play-pause-mobile-btn" class="btn btn-link text-white p-0 mobile-view fs-2 ms-auto">
                        <i class="bi bi-play-fill"></i>
                    </button>

                    <!-- Desktop Controls -->
                    <div class="desktop-view align-items-center gap-2 w-100 justify-content-end">
                        <i class="bi bi-volume-up text-secondary"></i>
                        <input type="range" id="volume" class="form-range" style="width: 100px;" min="0" max="1"
                            step="0.1" value="1">
                        <button id="btn-expand" class="btn btn-link link-secondary p-0"><i
                                class="bi bi-arrows-angle-expand"></i></button>
                    </div>
                </div>
            </div>


            <div id="player-expanded" class="d-none flex-column align-items-center justify-content-center text-white"
                style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; z-index: 2000; background: #000; overflow: hidden;">


                <div id="player-background"
                    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0.6; pointer-events: none; z-index: -1;">
                    <img id="player-background-image" src="" alt=""
                        style="width: 100%; height: 100%; object-fit: cover; filter: blur(50px) brightness(0.6); transform: scale(1.1);">
                </div>


                <div class="d-flex justify-content-between align-items-center w-100 px-4 py-3"
                    style="position: absolute; top: 0; z-index: 10;">
                    <button class="btn btn-link text-white p-0 fs-4" id="btn-collapse"><i
                            class="bi bi-chevron-down"></i></button>
                    <span class="text-uppercase tracking-wider small text-secondary">Now Playing</span>
                </div>


                <div class="container d-flex flex-column align-items-center px-4" style="max-width: 500px;">

                    <div class="mb-5 position-relative shadow-lg" style="width: 300px; height: 300px;">
                        <img id="player-cover-expanded" src="" alt="Cover"
                            class="w-100 h-100 rounded-4 object-ft-cover shadow-lg">
                    </div>


                    <div class="d-flex justify-content-between align-items-end w-100 mb-4">
                        <div class="overflow-hidden me-3">
                            <h2 id="player-title-expanded" class="fw-bold mb-1 text-truncate">Judul Lagu</h2>
                            <h5 id="player-artist-expanded" class="text-secondary mb-0 text-truncate">Artis</h5>
                        </div>
                        <button id="btn-like-expanded" class="btn btn-link text-secondary p-0 fs-3"><i
                                class="bi bi-heart"></i></button>
                    </div>


                    <div class="w-100 mb-4">
                        <div id="progress-container-expanded" class="progress mb-2"
                            style="height: 6px; cursor: pointer; background-color: rgba(255,255,255,0.1);">
                            <div id="progress-fill-expanded" class="progress-bar bg-white rounded-pill"
                                role="progressbar" style="width: 0%;"></div>
                        </div>
                        <div class="d-flex justify-content-between text-secondary small">
                            <span id="current-time-expanded">0:00</span>
                            <span id="total-time-expanded">0:00</span>
                        </div>
                    </div>


                    <div class="d-flex align-items-center justify-content-between w-100 px-3 opacity-100">
                        <button id="btn-shuffle-expanded" class="btn btn-link text-secondary p-0 fs-4"><i
                                class="bi bi-shuffle"></i></button>
                        <button id="btn-prev-expanded" class="btn btn-link text-white p-0 display-4"><i
                                class="bi bi-skip-start-fill" style="font-size: 2.5rem;"></i></button>
                        <button id="play-pause-btn-expanded"
                            class="btn btn-white bg-white text-dark rounded-circle p-0 d-flex align-items-center justify-content-center hover-scale"
                            style="width: 72px; height: 72px;">
                            <i class="bi bi-play-fill" style="font-size: 2.5rem;"></i>
                        </button>
                        <button id="btn-next-expanded" class="btn btn-link text-white p-0"><i
                                class="bi bi-skip-end-fill" style="font-size: 2.5rem;"></i></button>
                        <button id="btn-repeat-expanded" class="btn btn-link text-secondary p-0 fs-4"><i
                                class="bi bi-repeat"></i></button>
                    </div>
                </div>
            </div>

            <script>
                const contextPath = '${pageContext.request.contextPath}';
            </script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/player.css?v=16">
            <script src="${pageContext.request.contextPath}/js/player.js?v=16"></script>
        </c:if>

        <footer class="py-4 bg-dark-900 text-center text-dark-200 mt-auto border-top border-dark-700"
            style="${not isAuthPage ? 'margin-bottom: 80px;' : ''}">
            <div class="container small">
                &copy; UKM Band Universitas Telkom
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>