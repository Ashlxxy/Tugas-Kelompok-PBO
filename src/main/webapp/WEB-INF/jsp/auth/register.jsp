<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <div class="container d-flex justify-content-center align-items-center min-vh-100" style="margin-top: -60px;">
            <div class="auth-card card-dark p-4 rounded-4 shadow-lg fade-in" style="width: 400px;">
                <h3 class="text-center mb-4 fw-bold">Daftar</h3>
                <form action="${pageContext.request.contextPath}/register" method="POST">
                    <div class="mb-3">
                        <label for="name" class="form-label text-dark-200">Nama Lengkap</label>
                        <input type="text" class="form-control form-control-dark" id="name" name="name" required
                            autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label text-dark-200">Alamat Email</label>
                        <input type="email" class="form-control form-control-dark" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label text-dark-200">Kata Sandi</label>
                        <input type="password" class="form-control form-control-dark" id="password" name="password"
                            required>
                    </div>
                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-accent">Daftar</button>
                    </div>
                    <div class="text-center mt-3 small text-dark-300">
                        Sudah punya akun? <a href="${pageContext.request.contextPath}/login" class="link-accent">Login
                            di sini</a>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />