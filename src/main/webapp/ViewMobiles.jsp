<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mobiles</title>
</head>
<%-- Validating login --%>
<%
if (session.getAttribute("isLogin") == null) {
	response.sendRedirect("login.jsp");
}
%>
<%@ include file="sidebar.jsp"%>
<body>
	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />
	<div class="col-lg-10 col-md-11 col-12 bg-light p-5"
		style="overflow-y: auto">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="mobiles.jsp">Mobiles</a></li>
				<li class="breadcrumb-item active">View Mobiles</li>

			</ol>
		</nav>
		<div class="p-0 m-0 shadow card">
			<sql:setDataSource url="jdbc:mysql://localhost:3306/mobile_store"
				driver="com.mysql.cj.jdbc.Driver" user="root"
				password="kirtan2004khatri" var="db" />
			<c:set value='<%=request.getParameter("id")%>' var="mobile_id"></c:set>
			<c:if test="${mobile_id!=null}">
				<sql:query dataSource="${db}" var="data">
					SELECT * FROM MOBILES WHERE ID=?
					<sql:param value="${mobile_id}"></sql:param>
				</sql:query>
				<c:forEach items="${data.rows}" var="item">
					<div class="card-body p-5">
						<table class="table table-bordered bg-light">
							<tr class="table-primary">
								<td colspan="2">
									<h5 class="text-center m-0">Mobile Details</h5>
								</td>
							</tr>
							<tr>
								<th style="width: 15rem">Brand Name</th>
								<sql:query dataSource="${db}" var="brand">
									SELECT * FROM BRANDS WHERE ID=?
									<sql:param value="${item.brand_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${brand.rows}" var="i">
										<c:out value="${i.brand_name}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>Product Name</th>
								<td><c:out value="${item.model_name}" /></td>
							</tr>
							<tr>
								<th>RAM</th>
								<sql:query dataSource="${db}" var="ram">
									SELECT * FROM RAM_LIST WHERE ID=?
									<sql:param value="${item.ram_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${ram.rows}" var="i">
										<c:out value="${i.ram}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>ROM</th>
								<sql:query dataSource="${db}" var="rom">
									SELECT * FROM ROM_LIST WHERE ID=?
									<sql:param value="${item.rom_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${rom.rows}" var="i">
										<c:out value="${i.size}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>Internal Memory</th>
								<sql:query dataSource="${db}" var="im">
									SELECT * FROM INTERNAL_MEMORY WHERE ID=?
									<sql:param value="${item.im_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${im.rows}" var="i">
										<c:out value="${i.size}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>External Memory</th>
								<sql:query dataSource="${db}" var="em">
									SELECT * FROM EXTERNAL_MEMORY WHERE ID=?
									<sql:param value="${item.em_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${em.rows}" var="i">
										<c:out value="${i.size}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>Screen Size</th>
								<sql:query dataSource="${db}" var="screen">
									SELECT * FROM SCREEN_SIZE WHERE ID=?
									<sql:param value="${item.screen_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${screen.rows}" var="i">
										<c:out value="${i.size}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>Network Type</th>
								<sql:query dataSource="${db}" var="network">
									SELECT * FROM NETWORK_LIST WHERE ID=?
									<sql:param value="${item.network_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${network.rows}" var="i">
										<c:out value="${i.network_type}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>Rear Camera</th>
								<sql:query dataSource="${db}" var="camera">
									SELECT * FROM CAMERA_LIST WHERE ID=?
									<sql:param value="${item.rear_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${camera.rows}" var="i">
										<c:out value="${i.megapixel}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>Front Camera</th>
								<sql:query dataSource="${db}" var="camera">
									SELECT * FROM CAMERA_LIST WHERE ID=?
									<sql:param value="${item.front_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${camera.rows}" var="i">
										<c:out value="${i.megapixel}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>SIM Type</th>
								<sql:query dataSource="${db}" var="sim">
									SELECT * FROM SIM_TRAY WHERE ID=?
									<sql:param value="${item.sim_id}"></sql:param>
								</sql:query>
								<td><c:forEach items="${sim.rows}" var="i">
										<c:out value="${i.tray}" />
									</c:forEach></td>
							</tr>
							<tr>
								<th>Cost Price</th>
								<td><i class="bi bi-currency-rupee"></i> <c:out
										value="${item.cost_price}" /></td>
							</tr>
							<tr>
								<th>Sales Price</th>
								<td><i class="bi bi-currency-rupee"></i> <c:out
										value="${item.sales_price}" /></td>
							</tr>
						</table>
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</body>
</html>