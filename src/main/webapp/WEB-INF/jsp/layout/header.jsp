<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="id">

        <head>
            <title>UKM Band —
                <c:out value="${pageTitle}" default="Aplikasi Musik" />
            </title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                /* Toast Container */
                .toast-container {
                    z-index: 1055 !important;
                }

                .toast {
                    backdrop-filter: blur(10px);
                    background-color: rgba(26, 26, 26, 0.95) !important;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
                }

                /* Custom Animations */
                .fade-in {
                    animation: fadeIn 0.8s ease-in-out;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .hover-scale {
                    transition: transform 0.3s ease;
                }

                .hover-scale:hover {
                    transform: scale(1.03);
                }

                /* Custom Audio Player Styling */
                audio {
                    filter: invert(1) hue-rotate(180deg);
                    /* Simple dark mode trick for default player */
                    border-radius: 30px;
                }

                /* Volume Slider Styling */
                input[type=range] {
                    -webkit-appearance: none;
                    background: transparent;
                }

                input[type=range]::-webkit-slider-thumb {
                    -webkit-appearance: none;
                    height: 16px;
                    width: 16px;
                    border-radius: 50%;
                    background: #e63946 !important;
                    cursor: pointer;
                    margin-top: -6px;
                    box-shadow: 0 0 5px rgba(230, 57, 70, 0.5);
                }

                input[type=range]::-webkit-slider-runnable-track {
                    width: 100%;
                    height: 4px;
                    cursor: pointer;
                    background: #4f4f4f;
                    border-radius: 2px;
                }

                /* Firefox support */
                input[type=range]::-moz-range-thumb {
                    height: 16px;
                    width: 16px;
                    border: none;
                    border-radius: 50%;
                    background: #e63946 !important;
                    cursor: pointer;
                    box-shadow: 0 0 5px rgba(230, 57, 70, 0.5);
                }

                input[type=range]::-moz-range-track {
                    width: 100%;
                    height: 4px;
                    cursor: pointer;
                    background: #4f4f4f;
                    border-radius: 2px;
                }
            </style>
        </head>

        <body class="bg-dark-950 text-white d-flex flex-column min-vh-100">

            <nav class="navbar navbar-expand-lg navbar-dark bg-dark-900 sticky-top border-bottom border-dark-700">
                <div class="container-fluid px-3">
                    <a class="navbar-brand fw-bold d-flex align-items-center gap-2"
                        href="${pageContext.request.contextPath}/">
                        <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Logo UKM Band" width="40"
                            height="40" class="rounded-circle">
                        <span>UKM Band</span>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navMain">
                        <form class="ms-lg-3 my-2 my-lg-0 d-flex flex-grow-1"
                            action="${pageContext.request.contextPath}/songs" method="GET">
                            <span class="input-group">
                                <span class="input-group-text bg-dark-800 border-dark-700 text-dark-100"><i
                                        class="bi bi-search"></i></span>
                                <input class="form-control form-control-dark" name="q" type="search"
                                    placeholder="Cari judul lagu atau nama band" aria-label="Search" value="${param.q}">
                            </span>
                        </form>
                        <ul class="navbar-nav ms-lg-3 align-items-lg-center">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/songs"><i
                                        class="bi bi-collection-play me-1"></i>Daftar Lagu</a></li>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/playlists"><i
                                                class="bi bi-music-note-list me-1"></i>Playlist</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/feedback"><i
                                                class="bi bi-envelope me-1"></i>Contact Us</a></li>
                                    <li class="nav-item dropdown ms-lg-2">
                                        <a class="nav-link btn btn-outline-accent px-3 py-1 rounded-pill dropdown-toggle"
                                            href="#" data-bs-toggle="dropdown">
                                            <i
                                                class="bi bi-person-circle me-1"></i><span>${sessionScope.user.name}</span>
                                        </a>
                                        <ul class="dropdown-menu dropdown-menu-end dropdown-dark">
                                            <li><a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/history"><i
                                                        class="bi bi-clock-history me-2"></i>Riwayat</a></li>
                                            <c:if test="${sessionScope.user.role == 'admin'}">
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/admin/songs"><i
                                                            class="bi bi-shield-lock me-2"></i>Admin</a></li>
                                            </c:if>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li>
                                                <form action="${pageContext.request.contextPath}/logout" method="POST">
                                                    <button type="submit" class="dropdown-item text-danger"><i
                                                            class="bi bi-box-arrow-right me-2"></i>Keluar</button>
                                                </form>
                                            </li>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
                                        <a href="${pageContext.request.contextPath}/login"
                                            class="btn btn-outline-accent btn-sm w-100 w-lg-auto">Login</a>
                                    </li>
                                    <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
                                        <a href="${pageContext.request.contextPath}/register"
                                            class="btn btn-accent btn-sm w-100 w-lg-auto">Register</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </nav>

            <main class="flex-grow-1">
                <!-- Toast Logic -->
                <script src="${pageContext.request.contextPath}/js/toast.js"></script>
                <script src="${pageContext.request.contextPath}/js/dialog.js"></script>
                <script>
                    document.addEventListener('DOMContentLoaded', () => {
                        <c:if test="${not empty sessionScope.success}">
                            Toast.show("${sessionScope.success}", 'success');
                            <% session.removeAttribute("success"); %>
                        </c:if>
                        <c:if test="${not empty sessionScope.error}">
                            Toast.show("${sessionScope.error}", 'error');
                            <% session.removeAttribute("error"); %>
                        </c:if>
                    });
                </script>