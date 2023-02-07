<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- Validating login --%>
<%
if (session.getAttribute("isLogin")!=null) {
 	response.sendRedirect("dashboard.jsp");
}
%>
<%-- <c:if test="${ sessionScope:isLogin !=null }">
	<c:out value="${ sessionScope:isLogin }"></c:out>
</c:if>
<c:out value="${ sessionScope:isLogin }"></c:out> --%>

<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet" href="./bootstrap/css/bootstrap.min.css">
<title>Login</title>
</head>

<body style="height: 100vh; width: 100%"
	class="d-flex justify-content-center align-items-center bg-dark bg-gradient">
	<div class="container d-flex justify-content-center align-items-center">
		<form action="login.jsp" method="POST"
			class="contanier border px-5 py-4 shadow-lg rounded-3 bg-white"
			style="width: 25rem">
			<h2 class="text-center mb-5">Login</h2>
			<div class="my-3">
				<label for="uname" class="form-label">Username: </label> <input
					type="text" class="form-control" placeholder="Enter your username"
					id="uname" name="user_name" required
					oninput="setCustomValidity('')"
					oninvalid="setCustomValidity('Username field cannot be blank')">
			</div>
			<div class="my-3">
				<label for="passwd" class="form-label">Password: </label> <input
					type="password" class="form-control"
					placeholder="Enter your password" id="passwd" name="password"
					required oninput="setCustomValidity('')"
					oninvalid="setCustomValidity('Password field cannot be blank')">
			</div>
			<div class="my-4">
				<button class="btn btn-primary d-block rounded-0 w-100 p-2">Login</button>
  <!-- 				<a href="signup.jsp" class="text-center mt-4 d-block">Create
					account ?</a> -->
			</div>
		</form>
	</div>
	<%
	String username = request.getParameter("user_name");
	String password = request.getParameter("password");
	%>
	<!-- Sql Connection -->
	<c:if test="<%=username != null && password != null%>">
		<sql:setDataSource var="db"
			url="jdbc:mysql://localhost:3306/mobile_store"
			driver="com.mysql.cj.jdbc.Driver" user="root"
			password="kirtan2004khatri" />
		<sql:query var="user" dataSource="${db}">
  				SELECT * FROM USER_DETAILS;
  			</sql:query>
		<c:set value='<%=request.getParameter("user_name")%>' var="username" />
		<c:set value='<%=request.getParameter("password")%>' var="password" />
		<c:forEach items="${user.rows}" var="i">
			<c:choose>
				<c:when test="${username==i.username && password==i.password}">
					<%
						session.setAttribute("isLogin", "true");
					%>
					<c:redirect url="dashboard.jsp"></c:redirect>
				</c:when>
				<c:otherwise>
					<div
						class="alert alert-danger alert-dismissible fade show position-absolute top-0 mt-3"
						role="alert">
						<strong>Wrong username or password</strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:if>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

</html>