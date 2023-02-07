<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customers</title>
</head>
<%@ include file="sidebar.jsp"%>
<body>
	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />

	<c:set var="customer_id" value='<%=request.getParameter("view_id")%>'></c:set>

	<sql:query dataSource="${db}" var="result">
 		SELECT * FROM CUSTOMERS WHERE ID=?;
 		<sql:param value="${ customer_id }"></sql:param>
	</sql:query>

	<div class="col-lg-10 col-md-11 col-12 bg-light p-5">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="customers.jsp">Customers</a></li>
				<li class="breadcrumb-item active">View Customers</li>
			</ol>
		</nav>
		<div class="card">
			<h4 class="card-header bg-white">Customer Details</h4>
			<div class="card-body pb-5 px-4">
				<table class="table table-bordered mt-4 shadow-sm bg-light">
					<c:forEach items="${ result.rows }" var="item">
						<tr align="center" class="table-success">
							<th colspan="2">Personal Info</th>
						</tr>
						<tr>
							<th style="width: 15rem">First Name</th>
							<td><c:out value="${ item.first_name }"></c:out></td>
						</tr>
						<tr>
							<th>Middle Name</th>
							<td><c:out value="${ item.middle_name }"></c:out></td>
						</tr>
						<tr>
							<th>Last Name</th>
							<td><c:out value="${ item.last_name }"></c:out></td>
						</tr>
						<tr>
							<th>Gender</th>
							<td><c:out value="${ item.gender=='M' ? 'Male' : 'Female' }"></c:out></td>
						</tr>
						<tr>
							<th>Age</th>
							<td><c:out value="${ item.age }"></c:out></td>
						</tr>
						<tr>
							<th>Contact no</th>
							<td><c:out value="${ item.contact_no }"></c:out></td>
						</tr>
						<tr>
							<th style="width: 15rem">Address</th>
							<td><c:out value="${ item.address }"></c:out></td>
						</tr>
				</table>
				<table class="table table-bordered mt-5 shadow-sm bg-light">
					<tr align="center" class="table-primary">
						<th colspan="2">Mobile Info</th>
					</tr>
					<tr>
						<th style="width: 15rem">Brand Name</th>
						<sql:query var="result" dataSource="${db}">
							SELECT * FROM BRANDS WHERE ID=?;
							<sql:param value="${ item.brand_name }"></sql:param>
						</sql:query>
						<c:forEach items="${ result.rows }" var="brand">
							<td><c:out value="${ brand.brand_name }"></c:out></td>
						</c:forEach>
					</tr>
					<tr>
						<th>Model Name</th>
						<sql:query dataSource="${ db }" var="mobile">
							SELECT MODEL_NAME FROM MOBILES WHERE ID = ?
							<sql:param value="${ item.mobile_id }"></sql:param>
						</sql:query>

						<c:if test="${ fn:length(mobile.rows) > 0 }">
							<c:forEach items="${ mobile.rows }" var="phone">
								<td class="bg-light"><c:out value="${phone.model_name}" /></td>
							</c:forEach>
						</c:if>
					</tr>
					<tr>
						<th>Qty</th>
						<td><c:out value="${ item.qty }"></c:out></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>