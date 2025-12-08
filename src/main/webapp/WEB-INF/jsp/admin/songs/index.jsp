<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../../layout/header.jsp" />

        <div class="container-xxl py-4 fade-in">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3>Manajemen Lagu</h3>
                <a href="${pageContext.request.contextPath}/admin/songs/create" class="btn btn-accent"><i
                        class="bi bi-plus-lg"></i> Tambah Lagu</a>
            </div>

            <div class="card-dark rounded-4 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-dark table-hover mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="ps-4">#</th>
                                <th>Cover</th>
                                <th>Judul</th>
                                <th>Artis</th>
                                <th>Plays</th>
                                <th>Likes</th>
                                <th class="text-end pe-4">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty songs}">
                                    <c:forEach items="${songs}" var="song" varStatus="status">
                                        <tr>
                                            <td class="ps-4">${status.index + 1}</td>
                                            <td><img src="${pageContext.request.contextPath}${song.coverPath}"
                                                    width="48" class="rounded"></td>
                                            <td><a href="${pageContext.request.contextPath}/songs/${song.id}"
                                                    class="link-accent fw-semibold">${song.title}</a></td>
                                            <td>${song.artist}</td>
                                            <td>${song.plays}</td>
                                            <td>${song.likes}</td>
                                            <td class="text-end pe-4">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/admin/songs/${song.id}/edit"
                                                        class="btn btn-outline-accent"><i class="bi bi-pencil"></i></a>
                                                    <button type="button" class="btn btn-outline-danger"
                                                        data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                        data-url="${pageContext.request.contextPath}/admin/songs/${song.id}/delete">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center py-4 text-dark-300">Belum ada lagu.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="mt-5">
                <h4 class="mb-3 text-start">Feedback Pengguna</h4>
                <div class="card-dark rounded-4 overflow-hidden">
                    <div class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${not empty feedbacks}">
                                <c:forEach items="${feedbacks}" var="feedback">
                                    <div class="list-group-item bg-dark-900 border-dark-700 p-4">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <h5 class="mb-0 text-white fw-bold">${feedback.name}</h5>
                                            <small class="text-dark-300">${feedback.createdAt}</small>
                                        </div>
                                        <div class="small text-dark-300 mb-2">${feedback.email}</div>
                                        <p class="mb-0 text-white">${feedback.message}</p>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-dark-300 py-4">Belum ada feedback.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark-900 border-dark-700">
                    <div class="modal-header border-dark-700">
                        <h5 class="modal-title text-white" id="deleteModalLabel">Konfirmasi Hapus</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-dark-200">
                        Apakah Anda yakin ingin menghapus lagu ini? Tindakan ini tidak dapat dibatalkan.
                    </div>
                    <div class="modal-footer border-dark-700">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Batal</button>
                        <form id="deleteForm" method="POST" class="d-inline">
                            <button type="submit" class="btn btn-danger">Hapus</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../../layout/footer.jsp" />

        <script>
            const deleteModal = document.getElementById('deleteModal');
            deleteModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const deleteUrl = button.getAttribute('data-url');
                const form = deleteModal.querySelector('#deleteForm');
                form.action = deleteUrl;
            });
        </script>