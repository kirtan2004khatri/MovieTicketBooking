<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>King</title>
</head>
<%@ include file="sidebar.jsp" %>
<body>
<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />
	<div class="col-lg-10 col-md-11 col-12 bg-light p-5">
		<h3 class="mb-5">Dashboard</h3>
		<div class="row">
			<div class="col-3">
				<sql:query dataSource="${ db }" var="mobiles">SELECT * FROM MOBILES</sql:query>
				<div
					class="bg-white border-primary p-4 border-start rounded-3 border-5 d-flex align-items-center justify-content-between
                         shadow-sm" title="Go to Mobiles">
					<h5 class="m-0">Mobiles</h5>
					<h5 class="m-0">
						<c:out value="${ fn:length(mobiles.rows) }"></c:out>
					</h5>
				</div>
			</div>
			<div class="col-3">
				<sql:query dataSource="${ db }" var="brands">SELECT * FROM BRANDS</sql:query>
				<div
					class="bg-white border-success p-4 border-start rounded-3 border-5 d-flex align-items-center justify-content-between
                        shadow-sm" title="Go to Brands">
					<h5 class="m-0">Brands</h5>
					<h5 class="m-0">
						<c:out value="${ fn:length(brands.rows) }"></c:out>
					</h5>
				</div>
			</div>
			<div class="col-3">
				<sql:query dataSource="${ db }" var="customers">SELECT * FROM CUSTOMERS</sql:query>
				<div
					class="bg-white border-warning p-4 border-start rounded-3 border-5 d-flex align-items-center justify-content-between
                        shadow-sm" title="Go to Customers">
					<h5 class="m-0">Customers</h5>
					<h5 class="m-0">
						<c:out value="${ fn:length(customers.rows) }"></c:out>
					</h5>
				</div>
			</div>
			<div class="col-3">
				<sql:query dataSource="${ db }" var="mobiles">SELECT SUM(QUANTITY) AS TOTAL FROM MOBILES</sql:query>
				<c:forEach items="${ mobiles.rows }" var="i">
					<c:set value="${ i.total }" var="stock"></c:set>
				</c:forEach>
				<div
					class="bg-white border-danger  p-4 border-start rounded-3 border-5 d-flex align-items-center justify-content-between
                        shadow-sm" title="Go to Sales">
					<h5 class="m-0">STOCK</h5>
					<h5 class="m-0">
						<c:out value="${ stock }"></c:out>
					</h5>
				</div>
			</div>
		</div>
	<a class="btn btn-primary p-2 mx-auto d-block mt-5" style="width:5rem" href="logout.jsp">Logout</a>
	</div>
</body>
</html>