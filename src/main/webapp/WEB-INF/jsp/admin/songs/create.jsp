<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../../layout/header.jsp" />

        <div class="container d-flex justify-content-center py-5">
            <div class="card-dark p-4 rounded-4 shadow-lg w-100" style="max-width: 600px;">
                <h3 class="mb-4 fw-bold">Tambah Lagu Baru</h3>
                <form action="${pageContext.request.contextPath}/admin/songs" method="POST"
                    enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Judul Lagu</label>
                        <input type="text" name="title" class="form-control form-control-dark" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Artis</label>
                        <input type="text" name="artist" class="form-control form-control-dark" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Deskripsi</label>
                        <textarea name="description" class="form-control form-control-dark" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">Cover Image</label>
                        <input type="file" name="coverFile" class="form-control form-control-dark" accept="image/*">
                        <small class="text-dark-300">Upload gambar cover (opsional)</small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-dark-200">File Audio</label>
                        <input type="file" name="audioFile" class="form-control form-control-dark" accept="audio/*"
                            required>
                        <small class="text-dark-300">Upload file audio (.mp3, .wav)</small>
                    </div>
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="${pageContext.request.contextPath}/admin/songs"
                            class="btn btn-outline-secondary">Batal</a>
                        <button type="submit" class="btn btn-accent">Simpan Lagu</button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="../../layout/footer.jsp" />