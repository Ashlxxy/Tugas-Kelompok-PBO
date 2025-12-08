<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:include page="../layout/header.jsp" />

        <h2>Top Songs Report (JDBC)</h2>
        <p>This data is fetched using raw JDBC via JdbcTemplate.</p>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Artist</th>
                    <th>Plays</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${stats}" var="row">
                    <tr>
                        <td>${row.title}</td>
                        <td>${row.artist}</td>
                        <td>${row.plays}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <jsp:include page="../layout/footer.jsp" />