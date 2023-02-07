<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.lang.Math"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mobiles</title>
<style>
table th {
	font-size: 15px;
}

table td {
	font-size: 14px;
}
</style>
</head>
<%-- Validating login --%>
<%
if (session.getAttribute("isLogin") == null) {
	response.sendRedirect("login.jsp");
}
%>
<%@ include file="sidebar.jsp"%>
<body>
	<div class="col-lg-10 col-md-11 col-12 bg-light p-5">

		<sql:setDataSource var="db"
			url="jdbc:mysql://localhost:3306/mobile_store"
			driver="com.mysql.cj.jdbc.Driver" user="root"
			password="kirtan2004khatri" />

		<c:set
			value='<%=request.getParameter("from_date") == ""
		? null
		: request.getParameter("from_date") == null ? null : request.getParameter("from_date")%>'
			var="from_date"></c:set>

		<c:set
			value='<%=request.getParameter("to_date") == ""
		? null
		: request.getParameter("to_date") == null ? null : request.getParameter("to_date")%>'
			var="to_date"></c:set>

		<!-- 		 		INNER JOIN MOBILES M ON C.BRAND_NAME=M.BRAND_ID
		 		INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME -->
		<c:if test="${ from_date!=null && to_date!=null }">
			<sql:query dataSource="${ db }" var="data">
		 		SELECT C.FIRST_NAME,C.LAST_NAME,C.MIDDLE_NAME,C.DATE_ORDER,C.MOBILE_ID FROM CUSTOMERS C
		 		WHERE C.DATE_ORDER BETWEEN ? AND ?;
		 		<sql:param value="${ from_date }"></sql:param>
				<sql:param value="${ to_date }"></sql:param>
			</sql:query>
			<sql:query dataSource="${ db }" var="data2">
		 		SELECT B.BRAND_NAME,M.MODEL_NAME,M.SALES_PRICE,M.COST_PRICE,SUM(qty) AS UNITS,
                SUM(M.SALES_PRICE) AS TOTAL_SALES,
                SUM(M.COST_PRICE) AS
		 		TOTAL_COST
		 		FROM MOBILES M INNER JOIN BRANDS B ON 
		 		B.ID=M.BRAND_ID INNER JOIN CUSTOMERS
		 		C ON C.MOBILE_ID = M.ID WHERE C.DATE_ORDER BETWEEN ? AND ? GROUP BY C.MOBILE_ID WITH ROLLUP;
		 		<sql:param value="${ from_date }"></sql:param>
				<sql:param value="${ to_date }"></sql:param>
			</sql:query>
		</c:if>
		<c:set var="total_sales" value="0"></c:set>
		<c:set var="total_cost" value="0"></c:set>
		<c:set var="total_units" value="0"></c:set>
		<c:forEach items="${ data2.rows }" var="item">
			<c:set value="${ item.total_sales }" var="total_sales"></c:set>
			<c:set value="${ item.total_cost }" var="total_cost"></c:set>
			<c:set value="${ item.units }" var="total_units"></c:set>
		</c:forEach>
		<div class="card">
			<h4 class="card-header bg-white">Sales</h4>
			<div class="card-body">
				<form action="sales.jsp">
					<div
						class="p-0 d-flex justify-content-end align-items-center gap-3">
						<div class="m-0 p-0">
							<h6 class="my-auto">From :</h6>
						</div>
						<div
							class="m-0 p-0 d-flex align-items-center justify-content-between">
							<input type="date" class="form-control" name="from_date"
								id="from_date" style="height: 2rem; font-size: 12px"
								value="${ from_date }">
						</div>
						<div class="m-0 p-0">
							<h6 class="my-auto">To :</h6>
						</div>
						<div
							class="m-0 p-0 d-flex align-items-center justify-content-between">
							<input type="date" class="form-control" name="to_date"
								id="to_date" style="height: 2rem; font-size: 12px"
								value="${ to_date }">
						</div>
						<button class="btn btn-primary btn-sm rounded-0 align-self-end">Filter</button>
					</div>
				</form>
				<div
					class="d-flex justify-content-center align-items-center p-0 mt-3 gap-2">
					<div
						class="w-50 bg-white rounded-3 p-2 border d-flex flex-column justify-content-center align-items-center">
						<h6>Total Sales</h6>
						<h3>					
							<i class="bi bi-currency-rupee"></i>
							<c:out value="${ total_sales }" />
						</h3>
					</div>
					<div
						class="w-50 bg-white rounded-3 p-2 border d-flex flex-column justify-content-center align-items-center">
						<h6>Total Cost</h6>
						<h3>					
							<i class="bi bi-currency-rupee"></i>
							<c:out value="${ total_cost }" />
						</h3>
					</div>
					<div
						class="w-50 bg-white rounded-3 p-2 border d-flex flex-column justify-content-center align-items-center">
						<h6>Profit Margin</h6>
						<h3>					
							<i class="bi bi-currency-rupee"></i>
							<c:out value="${ (total_sales-total_cost) }" />
						</h3>
					</div>
					<div
						class="w-50 bg-white rounded-3 p-2 border d-flex flex-column justify-content-center align-items-center">
						<h6>Profit Margin Ration</h6>
						<h3>					
							<c:if test="${ total_sales==0 && total_cost==0 }">
								<c:out value="0%" />						
							</c:if>
							<c:if test="${ total_sales!=0 && total_cost!=0 }">
								<c:out value="${ (total_sales-total_cost)*100/(total_sales) }%" />						
							</c:if>
						</h3>
					</div>
				</div>
				<div
					class="d-flex align-items-start justify-content-center m-0 p-0 gap-2 mt-3">
					<div class="w-50">
						<table class="table table-bordered text-center">
							<thead class="table-info">
								<th style="width: 2rem" class="h6">#</th>
								<th style="width: 8rem" class="h6">Fullname</th>
								<th style="width: 3rem" class="h6">Purchase Date</th>
								<th style="width: 5rem" class="h6">Model</th>
							</thead>
							<tbody>
								<c:if test="${ fn:length(data.rows) == 0 }">
									<tr>
										<td colspan="4" class="p-5">No data available</td>
									</tr>
								</c:if>
								<c:if test="${ fn:length(data.rows)!=0 }">
									<c:forEach items="${ data.rows }" var="item" varStatus="index">
										<tr>
											<td><c:out value="${ index.count }"></c:out></td>
											<td class="px-0"><c:out
													value="${ item.first_name } ${ item.middle_name } ${ item.last_name }"></c:out></td>
											<td class="px-0"><c:out
													value="${ fn:substring(item.date_order,0,10) }"></c:out></td>
											<sql:query dataSource="${ db }" var="mobile">
											SELECT * FROM MOBILES WHERE ID=?
											<sql:param value="${item.mobile_id }"></sql:param>
											</sql:query>
											<c:if test="${ fn:length(mobile.rows) > 0 }">
												<c:forEach items="${ mobile.rows }" var="phone">
													<td class="px-0"><c:out value="${ phone.model_name }"></c:out></td>
												</c:forEach>
											</c:if>
											<c:if test="${ fn:length(mobile.rows) == 0 }">
												<td class="px-0">-</td>
											</c:if>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="w-50">
						<table class="table table-bordered text-center">
							<thead class="table-warning">
								<th style="width: 2rem" class="h6">#</th>
								<th style="width: 5rem" class="h6">Brand Name</th>
								<th style="width: 4rem" class="h6">Model</th>
								<th style="width: 4rem" class="h6">Price</th>
								<th style="width: 4rem" class="h6">Sold Units</th>
							</thead>
							<tbody>
								<c:if test="${ fn:length(data2.rows) == 0 }">
									<tr>
										<td colspan="5" class="p-5">No data available</td>
									</tr>
								</c:if>
								<c:if test="${ fn:length(data2.rows)!=0 }">
									<c:forEach items="${ data2.rows }" var="item" varStatus="index">
										<tr>
											<c:if test="${ fn:length(data2.rows)!=index.count }">
											<td><c:out value="${ index.count }"></c:out></td>
											<td class="px-0"><c:out value="${ item.brand_name }"></c:out></td>
											<td class="px-0"><c:out value="${ item.model_name }"></c:out></td>
											<td class="px-0"><c:out value="${ item.SALES_PRICE }"></c:out></td>
											<td class="px-0"><c:out value="${ item.units }"></c:out></td>										
											</c:if>
											<c:if test="${ fn:length(data2.rows)==index.count }">
												<td class="px-4 text-end" colspan="4">Total:</td>
												<td class="px-0"><c:out value="${ item.units }"></c:out></td>										
											</c:if>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
<script>
	let to_date=document.getElementById('to_date');
	let from_date=document.getElementById('from_date');
	
	from_date.addEventListener('change',(e)=>{
		if(to_date.value == ''){
			from_date.setAttribute("min",e.target.value)
			to_date.value=e.target.value;
			to_date.setAttribute("min",e.target.value)
		}
	});
	
</script>
</html>