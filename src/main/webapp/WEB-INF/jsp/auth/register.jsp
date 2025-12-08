<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="id" data-bs-theme="dark">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Daftar - UKM Band</title>
            <!-- Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
            <!-- Custom CSS -->
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            <style>
                body {
                    background-color: #0F0F0F;
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    min-height: 100vh;
                    margin: 0;
                }

                .auth-container {
                    width: 100%;
                    max-width: 1000px;
                    min-height: 600px;
                    background-color: #1a1a1a;
                    border-radius: 20px;
                    overflow: hidden;
                    box-shadow: 0 0 50px rgba(0, 0, 0, 0.5);
                }

                .auth-image-col {
                    min-height: 600px;
                }

                .auth-form-col {
                    padding: 3rem;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .overlay-content {
                    background: rgba(0, 0, 0, 0.3);
                    backdrop-filter: blur(2px);
                    z-index: 20;
                }
            </style>
        </head>

        <body>
            <div class="container d-flex justify-content-center">
                <div class="auth-container row g-0 overflow-hidden">
                    <!-- Left Side: Image Carousel -->
                    <div class="col-md-6 auth-image-col position-relative"
                        style="background: url('${pageContext.request.contextPath}/assets/img/1.png') center/cover no-repeat;">

                        <div id="authCarouselReg"
                            class="carousel slide carousel-fade position-absolute top-0 start-0 w-100 h-100"
                            data-bs-ride="carousel" data-bs-interval="3000">
                            <div class="carousel-inner h-100">
                                <div class="carousel-item active h-100">
                                    <img src="${pageContext.request.contextPath}/assets/img/1.png"
                                        class="d-block w-100 h-100 object-fit-cover" alt="Slide 1">
                                </div>
                                <div class="carousel-item h-100">
                                    <img src="${pageContext.request.contextPath}/assets/img/2.png"
                                        class="d-block w-100 h-100 object-fit-cover" alt="Slide 2">
                                </div>
                                <div class="carousel-item h-100">
                                    <img src="${pageContext.request.contextPath}/assets/img/3.png"
                                        class="d-block w-100 h-100 object-fit-cover" alt="Slide 3">
                                </div>
                                <div class="carousel-item h-100">
                                    <img src="${pageContext.request.contextPath}/assets/img/4.png"
                                        class="d-block w-100 h-100 object-fit-cover" alt="Slide 4">
                                </div>
                                <div class="carousel-item h-100">
                                    <img src="${pageContext.request.contextPath}/assets/img/5.png"
                                        class="d-block w-100 h-100 object-fit-cover" alt="Slide 5">
                                </div>
                            </div>
                        </div>
                        <!-- Overlay -->
                        <div
                            class="position-absolute top-0 start-0 w-100 h-100 d-flex flex-column justify-content-center align-items-center text-center p-4 overlay-content">
                            <h2 class="fw-bold text-white mb-3">Sudah punya akun?</h2>
                            <p class="text-white-50 mb-4 px-4">Masuk kembali untuk mengakses playlist dan lagu favoritmu
                            </p>
                            <a href="${pageContext.request.contextPath}/login"
                                class="btn btn-outline-light px-4 py-2 rounded-3"
                                style="border: 1px solid rgba(255,255,255,0.5); backdrop-filter: blur(5px);">
                                Masuk di sini
                            </a>
                        </div>
                    </div>

                    <!-- Right Side: Register Form -->
                    <div class="col-md-6 auth-form-col bg-dark-900">
                        <div class="text-center mb-4">
                            <img src="${pageContext.request.contextPath}/assets/img/logo.png" width="64"
                                class="mb-3 rounded-circle shadow">
                            <h3 class="fw-bold mb-1 text-white">Selamat Datang</h3>
                            <p class="text-secondary small">Daftar untuk mendengarkan lagu favorit kamu</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="POST"
                            onsubmit="return validatePassword()">
                            <div class="mb-3">
                                <label for="name" class="form-label text-secondary small fw-bold"
                                    style="font-size: 0.75rem; letter-spacing: 0.5px;">NAMA LENGKAP</label>
                                <input type="text" class="form-control bg-dark border-dark-700 text-white py-2"
                                    style="background-color: #111; border: 1px solid #333;" id="name" name="name"
                                    placeholder="UKM Band" required autofocus>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label text-secondary small fw-bold"
                                    style="font-size: 0.75rem; letter-spacing: 0.5px;">EMAIL</label>
                                <input type="email" class="form-control bg-dark border-dark-700 text-white py-2"
                                    style="background-color: #111; border: 1px solid #333;" id="email" name="email"
                                    placeholder="name@example.com" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label text-secondary small fw-bold"
                                    style="font-size: 0.75rem; letter-spacing: 0.5px;">PASSWORD</label>
                                <input type="password" class="form-control bg-dark border-dark-700 text-white py-2"
                                    style="background-color: #111; border: 1px solid #333;" id="passwordREG"
                                    name="password" required>
                            </div>
                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label text-secondary small fw-bold"
                                    style="font-size: 0.75rem; letter-spacing: 0.5px;">KONFIRMASI PASSWORD</label>
                                <input type="password" class="form-control bg-dark border-dark-700 text-white py-2"
                                    style="background-color: #111; border: 1px solid #333;" id="confirmPassword"
                                    required>
                                <div id="passwordError" class="invalid-feedback">Password tidak cocok.</div>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-danger py-2 fw-bold"
                                    style="background-color: #C21818; border: none;">Daftar</button>
                            </div>
                        </form>

                        <!-- Mobile only login link -->
                        <div class="text-center d-md-none mt-4">
                            <p class="text-secondary small">Sudah punya akun? <a
                                    href="${pageContext.request.contextPath}/login"
                                    class="text-danger text-decoration-none">Login di sini</a></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function validatePassword() {
                    const password = document.getElementById('passwordREG').value;
                    const confirm = document.getElementById('confirmPassword').value;
                    if (password !== confirm) {
                        document.getElementById('confirmPassword').classList.add('is-invalid');
                        return false;
                    }
                    return true;
                }
            </script>
        </body>

        </html>