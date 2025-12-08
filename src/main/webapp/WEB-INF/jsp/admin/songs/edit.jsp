<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../../layout/header.jsp" />

        <div class="container d-flex justify-content-center py-5">
            <div class="card-dark p-4 rounded-4 shadow-lg w-100" style="max-width: 600px;">
                <h3 class="mb-4 fw-bold">Edit Lagu</h3>
                <form action="${pageContext.request.contextPath}/admin/songs/${song.id}" method="POST">
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Judul Lagu</label>
                        <input type="text" name="title" class="form-control form-control-dark" value="${song.title}"
                            required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Artis</label>
                        <input type="text" name="artist" class="form-control form-control-dark" value="${song.artist}"
                            required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Deskripsi</label>
                        <textarea name="description" class="form-control form-control-dark"
                            rows="3">${song.description}</textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Cover Image</label>
                        <input type="text" name="coverPath" class="form-control form-control-dark"
                            value="${song.coverPath}">
                        <small class="text-dark-300">Masukkan path gambar (contoh: /assets/img/covers/song1.jpg)</small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">File Audio</label>
                        <input type="text" name="filePath" class="form-control form-control-dark"
                            value="${song.filePath}" required>
                        <small class="text-dark-300">Masukkan path audio (contoh: /assets/audio/song1.mp3)</small>
                    </div>
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="${pageContext.request.contextPath}/admin/songs"
                            class="btn btn-outline-secondary">Batal</a>
                        <button type="submit" class="btn btn-accent">Update Lagu</button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="../../layout/footer.jsp" />