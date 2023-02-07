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

<title>Brands</title>
</head>
<%-- Validating login --%>
<%
if (session.getAttribute("isLogin") == null) {
	response.sendRedirect("login.jsp");
}
%>
<%@ include file="sidebar.jsp"%>
<body>
	<div class="col-lg-10 col-md-11 col-12 bg-light p-3">
		<div class="container-fluid p-5" style="height: 100vh; width: 100%">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="brands.jsp">Brands</a></li>
					<li class="breadcrumb-item active">Add Brands</li>
				</ol>
			</nav>
			<h3 class="card-header border px-4 py-2 bg-white">Add Brand</h3>
			<form action="addBrand.jsp" method="POST"
				class="px-4 py-3 rounded-3 shadow">
				<div class="my-3">
					<label for="bname" class="form-label">Brand name: </label> <input
						type="text" class="form-control" id="bname" name="brand_name"
						placeholder="Enter the brand name" />
				</div>
				<div class="my-3 form-check">
					<label for="is_active" class="form-check-label">Acitve</label> <input
						type="checkbox" class="form-check-input" name="is_active"
						id="is_active" value="1">
				</div>
				<div class="my-3">
					<button class="btn btn-success">Submit</button>
				</div>
			</form>
		</div>
	</div>
	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />
	<c:set value='<%=request.getParameter("brand_name")%>' var="brand_name"></c:set>
	<c:set value='<%=request.getParameter("is_active")=="" ? "false" : request.getParameter("is_active") %>' var="is_active"></c:set>
	<c:if test="${brand_name!=null}">
		<sql:update dataSource="${db}" var="result">
			INSERT INTO BRANDS(BRAND_NAME,IS_ACTIVE) VALUES(?,?);
		<sql:param value="${brand_name}"></sql:param>
		<sql:param value="${is_active}"></sql:param>
		</sql:update>
		<c:redirect url="brands.jsp"></c:redirect>
	</c:if>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

</html>