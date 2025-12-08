<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <div class="container d-flex justify-content-center align-items-center min-vh-100" style="margin-top: -60px;">
            <div class="auth-card card-dark p-4 rounded-4 shadow-lg fade-in" style="width: 400px;">
                <div class="text-center mb-4">
                    <img src="${pageContext.request.contextPath}/assets/img/logo.png" width="60"
                        class="mb-3 rounded-circle shadow">
                    <h3 class="fw-bold">Selamat Datang Kembali</h3>
                    <p class="text-dark-300 small">Masuk untuk melanjutkan mendengarkan</p>
                </div>
                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="mb-3 slide-in-left" style="animation-delay: 0.1s;">
                        <label for="email" class="form-label text-dark-200">Alamat Email</label>
                        <input type="email" class="form-control form-control-dark" id="email" name="email" required
                            autofocus placeholder="name@example.com">
                    </div>
                    <div class="mb-3 slide-in-left" style="animation-delay: 0.2s;">
                        <label for="password" class="form-label text-dark-200">Kata Sandi</label>
                        <input type="password" class="form-control form-control-dark" id="password" name="password"
                            required placeholder="••••••••">
                    </div>
                    <div class="d-grid mt-4 slide-in-left" style="animation-delay: 0.3s;">
                        <button type="submit" class="btn btn-accent btn-lg">Masuk</button>
                    </div>
                    <div class="text-center mt-4 small text-dark-300 fade-in" style="animation-delay: 0.4s;">
                        Belum punya akun? <a href="${pageContext.request.contextPath}/register"
                            class="link-accent fw-semibold">Daftar sekarang</a>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />