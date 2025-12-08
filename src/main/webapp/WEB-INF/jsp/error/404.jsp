<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="../layout/header.jsp" />

    <div class="container mt-5 text-center">
        <h1 class="display-1">404</h1>
        <p class="lead">${error}</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
    </div>

    <jsp:include page="../layout/footer.jsp" />