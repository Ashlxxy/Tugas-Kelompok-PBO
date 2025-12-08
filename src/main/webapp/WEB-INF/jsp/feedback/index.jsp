<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <div class="container d-flex justify-content-center align-items-center min-vh-100" style="margin-top: -60px;">
            <div class="row w-100 justify-content-center">
                <div class="col-lg-10">
                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert bg-dark-800 border-success text-success mb-4 alert-dismissible fade show"
                            role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.success}
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"
                                aria-label="Close"></button>
                        </div>
                        <c:remove var="success" scope="session" />
                    </c:if>
                    <h3 class="mb-4">Kirim Feedback</h3>
                    <div class="row g-0 rounded-4 overflow-hidden shadow-lg">
                        <!-- Form Section -->
                        <div class="col-md-7 card-dark p-5">
                            <form action="${pageContext.request.contextPath}/feedback" method="POST">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-dark-200">Nama</label>
                                        <input type="text" name="name" class="form-control form-control-dark"
                                            value="${sessionScope.user.name}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-dark-200">Email</label>
                                        <input type="email" name="email" class="form-control form-control-dark"
                                            value="${sessionScope.user.email}" readonly>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label text-dark-200">Pesan</label>
                                    <textarea name="message" class="form-control form-control-dark" rows="5" required
                                        placeholder="Tulis masukan Anda di sini..."></textarea>
                                </div>
                                <div class="d-flex justify-content-end mt-4">
                                    <button type="submit" class="btn btn-accent px-4">Kirim</button>
                                </div>
                            </form>
                        </div>

                        <!-- Contact Info Section -->
                        <div
                            class="col-md-5 bg-dark-900 p-5 border-start border-dark-700 d-flex flex-column justify-content-center">
                            <h4 class="mb-4"><i class="bi bi-telephone me-2"></i>Contact Us</h4>
                            <p class="text-dark-200 mb-4 fw-bold">UKM Band Universitas Telkom</p>

                            <div class="mb-3">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-envelope me-3 text-dark-300"></i>
                                    <span>ukmbandtelkom@gmail.com</span>
                                </div>
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-telephone me-3 text-dark-300"></i>
                                    <span>+62 857 1889 2031</span>
                                </div>
                                <div class="d-flex align-items-start">
                                    <i class="bi bi-geo-alt me-3 mt-1 text-dark-300"></i>
                                    <span>Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa
                                        Barat 40257</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />