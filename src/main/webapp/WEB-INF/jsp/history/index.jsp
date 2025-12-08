<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <div class="container-xxl py-4 fade-in">
            <h3 class="mb-4">Riwayat Pemutaran</h3>
            <div class="list-group list-group-flush rounded-4 overflow-hidden">
                <c:choose>
                    <c:when test="${not empty histories}">
                        <c:forEach items="${histories}" var="item">
                            <a href="${pageContext.request.contextPath}/songs/${item.song.id}"
                                class="list-group-item list-group-item-action bg-dark-900 border-dark-700 d-flex justify-content-between align-items-center p-3">
                                <div class="d-flex align-items-center gap-3">
                                    <img src="${pageContext.request.contextPath}${item.song.coverPath}" width="48"
                                        height="48" class="rounded object-fit-cover">
                                    <div>
                                        <div class="fw-bold text-white">${item.song.title}</div>
                                        <div class="small text-dark-300">${item.song.artist}</div>
                                    </div>
                                </div>
                                <small class="text-dark-300">${item.formattedPlayedAt}</small>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center text-dark-300 py-5">Belum ada riwayat pemutaran.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />