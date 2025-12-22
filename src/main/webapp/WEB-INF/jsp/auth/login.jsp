<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <!DOCTYPE html>
            <html lang="id">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Masuk & Daftar &mdash; UKM Band</title>
                <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/logo.ico">

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
                    rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                    rel="stylesheet">


                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth-animated.css">
                <style>
                    .carousel,
                    .carousel-inner,
                    .carousel-item {
                        height: 100%;
                    }

                    .carousel-item img {
                        object-fit: cover;
                        height: 100%;
                        width: 100%;
                        filter: brightness(0.6);
                    }

                    .carousel-caption {
                        top: 50%;
                        transform: translateY(-50%);
                        bottom: auto;
                    }

                    .overlay {
                        background: none !important;
                        background-color: #121212 !important;
                    }
                </style>
            </head>

            <body class="auth-body">


                <script src="${pageContext.request.contextPath}/js/toast.js"></script>
                <script>
                    document.addEventListener('DOMContentLoaded', () => {
                        <c:if test="${not empty success}">
                            Toast.show("${success}", 'success');
                        </c:if>
                        <c:if test="${not empty error}">
                            Toast.show("${error}", 'error');
                        </c:if>
                    });
                </script>

                <div class="container-auth ${not empty registerError or not empty showRegister ? 'active' : ''}">


                    <div class="form-box Login">
                        <div class="w-100">
                            <div class="text-center mb-4">
                                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Logo" width="50"
                                    class="mb-2 rounded-circle">
                                <h2 class="fw-bold text-accent">Selamat Datang Kembali</h2>
                                <p class="text-dark-300 small">Masuk untuk menikmati playlist kamu</p>
                            </div>



                            <form action="${pageContext.request.contextPath}/login" method="POST">
                                <div class="mb-3">
                                    <label class="form-label text-dark-200">Email</label>
                                    <input type="email" class="form-control form-control-dark" name="email" value=""
                                        required placeholder="name@example.com">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-dark-200">Password</label>
                                    <input type="password" class="form-control form-control-dark" name="password"
                                        required placeholder="********">
                                </div>

                                <div class="d-grid mt-4">
                                    <button type="submit" class="btn btn-accent btn-lg">Masuk</button>
                                </div>
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/" class="text-decoration-none"
                                        style="color: red;">Kembali ke Beranda</a>
                                </div>
                                <div class="text-center mt-3 d-md-none">
                                    <p class="small text-dark-300 mb-0">Belum punya akun?
                                        <a href="#" class="text-accent text-decoration-none SignUpLink">Daftar
                                            sekarang</a>
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>


                    <div class="form-box Register">
                        <div class="w-100">
                            <div class="text-center mb-4">
                                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Logo" width="50"
                                    class="mb-2 rounded-circle">
                                <h2 class="fw-bold text-accent">Selamat Datang</h2>
                                <p class="text-dark-300 small">Daftar untuk mendengarkan lagu favorit kamu</p>
                            </div>



                            <form action="${pageContext.request.contextPath}/register" method="POST">
                                <div class="mb-3">
                                    <label class="form-label text-dark-200">Nama Lengkap</label>
                                    <input type="text" class="form-control form-control-dark" name="name"
                                        value="${user.name}" required placeholder="UKM Band">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-dark-200">Email</label>
                                    <input type="email" class="form-control form-control-dark" name="email"
                                        value="${user.email}" required placeholder="name@example.com">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-dark-200">Password</label>
                                    <input type="password" class="form-control form-control-dark" name="password"
                                        required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-dark-200">Konfirmasi Password</label>
                                    <input type="password" class="form-control form-control-dark"
                                        name="password_confirmation" required>
                                </div>

                                <div class="d-grid mt-4">
                                    <button type="submit" class="btn btn-accent btn-lg">Daftar</button>
                                </div>
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/" class="text-decoration-none"
                                        style="color: red;">Kembali ke Beranda</a>
                                </div>
                                <div class="text-center mt-3 d-md-none">
                                    <p class="small text-dark-300 mb-0">Sudah punya akun?
                                        <a href="#" class="text-accent text-decoration-none SignInLink">Masuk di
                                            sini</a>
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>


                    <div class="overlay-container">
                        <div class="overlay">

                            <div id="authCarousel"
                                class="carousel slide carousel-fade h-100 w-100 position-absolute top-0 start-0"
                                data-bs-ride="carousel" style="z-index: -1;">
                                <div class="carousel-inner h-100">
                                    <div class="carousel-item active h-100">
                                        <img src="${pageContext.request.contextPath}/assets/img/1.png"
                                            class="d-block w-100 h-100" alt="Image 1">
                                    </div>
                                    <div class="carousel-item h-100">
                                        <img src="${pageContext.request.contextPath}/assets/img/2.png"
                                            class="d-block w-100 h-100" alt="Image 2">
                                    </div>
                                    <div class="carousel-item h-100">
                                        <img src="${pageContext.request.contextPath}/assets/img/3.png"
                                            class="d-block w-100 h-100" alt="Image 3">
                                    </div>
                                    <div class="carousel-item h-100">
                                        <img src="${pageContext.request.contextPath}/assets/img/4.png"
                                            class="d-block w-100 h-100" alt="Image 4">
                                    </div>
                                    <div class="carousel-item h-100">
                                        <img src="${pageContext.request.contextPath}/assets/img/5.png"
                                            class="d-block w-100 h-100" alt="Image 5">
                                    </div>
                                </div>
                            </div>


                            <div class="overlay-panel overlay-left">
                                <h2 class="fw-bold mb-3">Sudah punya akun?</h2>
                                <p class="mb-4">Masuk kembali untuk mengakses playlist dan lagu favoritmu.</p>
                                <button class="btn btn-outline-accent-white btn-lg SignInLink">Masuk di sini</button>
                            </div>
                            <div class="overlay-panel overlay-right">
                                <h2 class="fw-bold mb-3">Belum punya akun?</h2>
                                <p class="mb-4">Daftar sekarang untuk mulai mendengarkan karya UKM Band.</p>
                                <button class="btn btn-outline-accent-white btn-lg SignUpLink">Daftar sekarang</button>
                            </div>
                        </div>
                    </div>

                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script src="${pageContext.request.contextPath}/js/auth-animated.js"></script>

            </body>

            </html>