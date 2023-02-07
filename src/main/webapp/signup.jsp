<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

<title>Signup</title>
</head>

<body style="height: 100vh; width: 100%"
	class="d-flex justify-content-center align-items-center">
	<div class="container d-flex justify-content-center align-items-center">
		<form action="signup.jsp"
			class="contanier border px-md-5 px-4 py-md-4 py-3 shadow-lg rounded-3"
			style="width: 25rem" method="POST">
			<h2 class="text-center mb-md-5 mb-4">Signup</h2>
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
			<div class="my-3">
				<label for="cpasswd" class="form-label">Confirm Password: </label> <input
					type="password" class="form-control"
					placeholder="Enter your password again" id="cpasswd"
					name="cpassword" required oninput="setCustomValidity('')"
					oninvalid="setCustomValidity('Confirm password field cannot be blank')">
			</div>
			<div class="my-4">
				<button class="btn btn-primary d-block rounded-0 w-100 p-2 fw-bold">Signup</button>
				<a href="login.jsp" class="text-center mt-4 d-block">Already
					have a account ?</a>
			</div>
		</form>
	</div>
	<!-- Here goes again -->
	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />

	<c:set value='<%=request.getParameter("user_name")%>' var="username"></c:set>
	<c:set value='<%=request.getParameter("password")%>' var="password"></c:set>
	<c:set value='<%=request.getParameter("cpassword")%>' var="cpassword"></c:set>
	<c:set value="false" var="showAlert"></c:set>

	<c:if test="${username!=null && password!=null && cpassword!=null}">
		<sql:query dataSource="${db}" var="result">
    		SELECT * FROM USER_DETAILS WHERE USERNAME=(?);
    	<sql:param value="${username}"></sql:param>
		</sql:query>
		<c:out value="${fn:length(result.rows)}" />
		<c:choose>
			<c:when test="${fn:length(result.rows)!=0}">
				<c:forEach items="${result.rows}" var="data">
					<div
						class="alert alert-danger alert-dismissible fade show position-absolute top-0 mt-1	"
						role="alert">
						<strong>Username already exist try another...</strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${password==cpassword}">
						<sql:update dataSource="${db}" var="result">
    						INSERT INTO USER_DETAILS(USERNAME,PASSWORD) VALUES(?,?);
    						<sql:param value="${username}"></sql:param>
							<sql:param value="${password}"></sql:param>
						</sql:update>
						<c:redirect url="login.jsp"></c:redirect>
					</c:when>
					<c:otherwise>
						<div
							class="alert alert-danger alert-dismissible fade show position-absolute top-0 mt-1	"
							role="alert">
							<strong>Both password does not match....</strong>
							<button type="button" class="btn-close" data-bs-dismiss="alert"
								aria-label="Close"></button>
						</div>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
		<%--     		<c:if test="${data.username!=username}">
    			<c:if test="${password==cpassword}">
    				<sql:update dataSource="${db}" var="result">
    					INSERT INTO USER_DETAILS(USERNAME,PASSWORD) VALUES(?,?);
    					<sql:param value="${username}"></sql:param>
    					<sql:param value="${password}"></sql:param>
    				</sql:update>
    				<c:if test="${result==1}">
    					<c:redirect url="login.jsp"></c:redirect>
    				</c:if>
    			</c:if>
    			<c:if test="${password!=cpassword}">
	    			<c:set value="true" var="showPasswdAlert"></c:set>
    			</c:if>
    		</c:if> --%>
	</c:if>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	if(${showAlert}){
		alert("Username already exist");
	}
/* 	if(${showPasswdError}){
		alert("Username already exist");
	} */
</script>
</html>