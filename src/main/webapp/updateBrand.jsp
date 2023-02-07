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
	<c:set value='<%=request.getParameter("id")%>' var="b_id"></c:set>
	<c:set value='<%=request.getParameter("brand_name")%>' var="brand_name"></c:set>
	<c:set value='<%=request.getParameter("is_active")==null ? false : request.getParameter("is_active") %>' var="is_active"></c:set>
<%--  	<c:out value="------------${ is_active }"></c:out> --%>
	<c:url value="updateBrand.jsp" var="requestUrl">
		<c:param name="id" value="${b_id}"></c:param>
	</c:url>
	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />
	<c:if test="${b_id!=null}">
		<sql:query dataSource="${db}" var="result">
			SELECT * FROM BRANDS WHERE ID=?;
			<sql:param value="${b_id}"></sql:param>
		</sql:query>
		<div class="col-lg-10 col-md-11 col-12 bg-light p-5">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="brands.jsp">Brands</a></li>
					<li class="breadcrumb-item active">Update Brands</li>
				</ol>
			</nav>
			<h4 class="card-header border px-4 py-2 bg-white">Update Brand</h4>
			<div class="card-body bg-white border">
				<c:forEach items="${result.rows}" var="data">
					<form action="${request.url}" method="POST">
						<div class="my-3">
							<label for="bname" class="form-label">Brand name: </label> <input
								type="text" class="form-control" id="bname" name="brand_name"
								placeholder="Enter the brand name" value="${data.brand_name}" />
						</div>
						<div class="my-3 form-check">
							<label for="is_active" class="form-check-label">Acitve</label> <input
								type="checkbox" class="form-check-input" name="is_active"
								id="is_active" value="1" <c:out value="${ data.is_active=='true' ? 'checked' : '' }" /> >
						</div>
						<div class="my-3">
							<button class="btn btn-success rounded-0">Submit</button>
						</div>
						<input name="id" value="${ data.id }" type="hidden" />
					</form>
				</c:forEach>
			</div>
		</div>
	</c:if>
	<c:if test="${brand_name!=null}">
		<sql:update dataSource="${db}" var="result">
			UPDATE BRANDS SET BRAND_NAME=?,IS_ACTIVE=? WHERE ID=?;
			<sql:param value="${brand_name}"></sql:param>
			<sql:param value="${is_active}"></sql:param>
			<sql:param value="${b_id}"></sql:param>
		</sql:update>
 		<c:redirect url="brands.jsp"></c:redirect>
	</c:if>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

</html>