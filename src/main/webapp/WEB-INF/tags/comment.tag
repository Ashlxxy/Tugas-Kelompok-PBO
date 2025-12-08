<%@ tag description="Recursive Comment Tree" pageEncoding="UTF-8"%>
<%@ attribute name="comment" type="com.example.tubes.entity.Comment" required="true" %>
<%@ attribute name="songId" type="java.lang.Long" required="true" %>
<%@ attribute name="depth" type="java.lang.Integer" required="true" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!-- Indentation Container -->
<div class="comment-item position-relative" style="margin-left: ${depth * 32}px;">
    
    <!-- Connector Line for Threading -->
    <c:if test="${depth > 0}">
        <div class="position-absolute border-start border-dark-600" 
             style="top: -10px; left: -16px; height: 30px; width: 15px; border-bottom: 1px solid #4a4a4a; border-radius: 0 0 0 10px;"></div>
    </c:if>

    <div class="d-flex gap-3 mb-3 animate__animated animate__fadeIn">
        <!-- Avatar (Initials) -->
        <div class="flex-shrink-0">
            <div class="rounded-circle d-flex align-items-center justify-content-center fw-bold shadow-sm"
                 style="width: 40px; height: 40px; background: ${comment.user.role == 'admin' ? 'var(--accent)' : '#3A3A3A'}; color: #fff; font-size: 1rem;">
                ${fn:substring(comment.user.name, 0, 1).toUpperCase()}
            </div>
        </div>

        <!-- Comment Content Card -->
        <div class="flex-grow-1">
            <div class="bg-dark-800 p-3 rounded-4 border border-dark-700 shadow-sm transition-hover">
                <div class="d-flex justify-content-between align-items-start mb-1">
                    <div class="d-flex align-items-center gap-2">
                        <!-- User Name -->
                        <span class="fw-bold text-white shadow-sm-text" style="font-size: 0.95rem;">
                            ${comment.user.name}
                        </span>
                        
                        <!-- Admin Badge -->
                        <c:if test="${comment.user.role == 'admin'}">
                            <span class="badge bg-danger bg-opacity-75 text-white py-0 px-2 rounded-pill" 
                                  style="font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.5px;">
                                Admin
                            </span>
                        </c:if>
                    </div>

                    <!-- Timestamp -->
                    <small class="text-secondary" style="font-size: 0.75rem;">
                        <c:out value="${comment.createdAt}" />
                    </small>
                </div>

                <!-- Comment Text -->
                <p class="mb-2" style="color: #E0E0E0; font-size: 0.95rem; line-height: 1.5;">
                    ${comment.content}
                </p>

                <!-- Actions (Reply & Delete & Toggle) -->
                <div class="d-flex align-items-center gap-3 flex-wrap">
                    <!-- Reply Button -->
                    <c:if test="${not empty sessionScope.user}">
                        <button class="btn btn-sm btn-dark px-3 py-1 rounded-pill text-dark-300 hover-text-white d-flex align-items-center gap-1 transition-all"
                                style="font-size: 0.75rem; background: rgba(255,255,255,0.05);"
                                onclick="document.getElementById('reply-form-${comment.id}').classList.toggle('d-none')">
                            <i class="bi bi-reply-fill"></i> Balas
                        </button>
                    </c:if>

                    <!-- Toggle Replies Button -->
                    <c:if test="${not empty comment.replies}">
                        <button class="btn btn-sm btn-link text-decoration-none text-dark-300 hover-text-accent p-0 d-flex align-items-center gap-1 transition-all"
                                style="font-size: 0.75rem;"
                                type="button" 
                                data-bs-toggle="collapse" 
                                data-bs-target="#replies-${comment.id}" 
                                aria-expanded="false" 
                                aria-controls="replies-${comment.id}">
                            <i class="bi bi-chevron-down"></i> Lihat ${fn:length(comment.replies)} Balasan
                        </button>
                    </c:if>

                    <!-- Delete Button -->
                    <c:if test="${not empty sessionScope.user and (sessionScope.user.id == comment.user.id or sessionScope.user.role == 'admin')}">
                        <button type="button" 
                                class="btn btn-link p-0 text-secondary hover-text-danger transition-colors text-decoration-none" 
                                style="font-size: 0.85rem;" 
                                title="Hapus"
                                onclick="confirmDeleteComment('${pageContext.request.contextPath}/songs/${songId}/comments/${comment.id}/delete')">
                            <i class="bi bi-trash"></i>
                        </button>
                    </c:if>
                </div>
            </div>

            <!-- Inline Reply Form -->
            <div id="reply-form-${comment.id}" class="d-none mt-2 animate__animated animate__fadeInDown">
                <form action="${pageContext.request.contextPath}/songs/${songId}/comments" method="POST">
                    <input type="hidden" name="parentId" value="${comment.id}">
                    <div class="d-flex gap-2">
                         <div class="flex-grow-1">
                             <input type="text" name="content" 
                                    class="form-control form-control-dark rounded-pill px-3 py-2 border-dark-600" 
                                    style="font-size: 0.9rem;"
                                    placeholder="Balas ${comment.user.name}..." required>
                         </div>
                        <button class="btn btn-accent rounded-circle d-flex align-items-center justify-content-center shadow-lg" 
                                style="width: 38px; height: 38px;" type="submit">
                            <i class="bi bi-send-fill" style="font-size: 0.9rem;"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Recursive Call (Collapsible) -->
<c:if test="${not empty comment.replies}">
    <div class="collapse" id="replies-${comment.id}">
        <c:forEach items="${comment.replies}" var="reply">
            <t:comment comment="${reply}" songId="${songId}" depth="${depth + 1}" />
        </c:forEach>
    </div>
</c:if>
