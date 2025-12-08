<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="../layout/header.jsp" />

    <div class="container py-5">
        <div class="card-dark p-4 rounded-4 shadow-lg mx-auto" style="max-width: 600px;">
            <h2 class="mb-4 fw-bold">Buat Playlist Baru</h2>

            <form action="${pageContext.request.contextPath}/playlists" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label text-dark-200">Nama Playlist</label>
                    <input type="text" class="form-control form-control-dark" id="name" name="name" required>
                </div>
                <div class="d-flex justify-content-end gap-2">
                    <a href="${pageContext.request.contextPath}/playlists" class="btn btn-outline-secondary">Batal</a>
                    <button type="submit" class="btn btn-accent">Buat</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />