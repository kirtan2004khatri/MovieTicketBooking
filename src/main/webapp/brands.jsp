<% response.setStatus(200); %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" buffer="20kb" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.lang.Math"%>
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
	<c:set
		value='<%=request.getParameter("brand_name") == "" ? null : request.getParameter("brand_name")%>'
		var="filter_brand_name"></c:set>

	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />

	<c:set var="page"
		value='<%=request.getParameter("page") == null ? 1 : request.getParameter("page")%>'></c:set>
	<c:set var="perPage"
		value='<%=request.getParameter("perPage") == null ? 5 : request.getParameter("perPage")%>'></c:set>
		
	<c:set var="status" value='<%=request.getParameter("status") == null ? 3 : request.getParameter("status")%>'></c:set>

	<sql:query dataSource="${db}" var="data">
		<c:if test="${ filter_brand_name==null}">
			SELECT *,(SELECT COUNT(*) FROM BRANDS
						<c:if test="${ status==1 }">
				<c:out value=" WHERE IS_ACTIVE=TRUE "></c:out>
			</c:if>
			<c:if test="${ status==2 }">
				<c:out value=" WHERE IS_ACTIVE=FALSE "></c:out>
			</c:if>
						) AS TOTAL FROM BRANDS
			<c:if test="${ status==1 }">
				<c:out value="WHERE IS_ACTIVE=TRUE"></c:out>
			</c:if>
			<c:if test="${ status==2 }">
				<c:out value="WHERE IS_ACTIVE=FALSE"></c:out>
			</c:if>
			<c:if test="${ page==1 && perPage!=-1 }">
				<c:out value=" LIMIT ${ perPage } ;" />
			</c:if>
			<c:if test="${ page>1 }">
				<c:out value=" LIMIT ${ (page-1)*perPage } , ${ perPage } ;" />
			</c:if>
		</c:if>
		<c:if test="${ filter_brand_name!=null }">
			SELECT *,(SELECT COUNT(*) FROM BRANDS WHERE BRAND_NAME LIKE ?
			<c:if test="${ status==1 }">
				<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
			</c:if>
			<c:if test="${ status==2 }">
				<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
			</c:if>
			) AS TOTAL FROM BRANDS WHERE BRAND_NAME LIKE ? 
			<c:if test="${ status==1 }">
				<c:out value=" AND IS_ACTIVE=TRUE"></c:out>
			</c:if>
			<c:if test="${ status==2 }">
				<c:out value=" AND IS_ACTIVE=FALSE"></c:out>
			</c:if>
			<c:if test="${ page==1 && perPage!=-1}">
				<c:out value="LIMIT ${ perPage } ;" />
			</c:if>
			<c:if test="${ perPage==-1 }">
				<c:out value=";" />
			</c:if>
			<c:if test="${ page>1 && perPage!=-1 }">
				<c:out value=" lIMIT ${ (page-1)*perPage } , ${ perPage } ;" />
			</c:if>
			<sql:param value="%${ filter_brand_name }%"></sql:param>
			<sql:param value="%${ filter_brand_name }%"></sql:param>
		</c:if>
	</sql:query>

	<c:forEach items="${ data.rows }" var="item">
		<c:set var="count"
			value="${ Math.round(Math.ceil(item.total/perPage)) }"></c:set>
	</c:forEach>


	<div class="col-lg-10 col-md-11 col-12 bg-light p-5">
		<div class="card pb-4">
			<div
				class="card-header border-bottom bg-white px-4 py-2 m-0 d-flex align-items-center justify-content-between">
				<h4 class="m-0">Brands</h4>
				<a class="btn btn-outline-success btn-sm rounded-0"
					href="addBrand.jsp" style="width: 5rem">Add</a>
			</div>
			<div class="card-body px-4">
				<form action="brands.jsp" method="POST">
					<div
						class="m-0 p-0 d-flex align-items-center justify-content-between gap-2">
						<sql:query var="total_brands" dataSource="${ db }">SELECT * FROM BRANDS;</sql:query>
						<h5 class="m-0 p-0">
							<span class="badge bg-primary"
								style="font-weight: 500; width: 11rem"> <c:out
									value="TOTAL BRANDS : ${ fn:length(total_brands.rows) }" />
							</span>
						</h5>
						<div
							class="d-flex align-items-center gap-2 justify-content-between">
							<input type="text" class="form-control"
								placeholder="Filter brands" name="brand_name"
								value="${ filter_brand_name }"
								style="height: 2rem; font-size: 12px; width: 10rem" /> 
								
								<select
								name="status" class="form-select"
								style="height: 2rem; font-size: 12px; width: 5.5rem">
								<option value="3" <c:out value="${ status==3 ? 'selected' : '' }" /> >Both</option>
								<option value="1" <c:out value="${ status==1 ? 'selected' : '' }" /> >Active</option>
								<option value="2" <c:out value="${ status==2 ? 'selected' : '' }" /> >In-Active
							</select> 
							
							<select name="perPage" class="form-select"
								style="height: 2rem; font-size: 12px; width: 5rem">
								<option value="5"
									<c:out value='${ perPage==5 ? "selected" : "" }' />>5</option>
								<option value="10"
									<c:out value='${ perPage==10 ? "selected" : "" }' />>10</option>
								<option value="20"
									<c:out value='${ perPage==20 ? "selected" : "" }' />>20</option>
								<option value="-1"
									<c:out value='${ perPage==-1 ? "selected" : "" }' />>All</option>
							</select>
							<button class="btn btn-sm btn-primary rounded-0"
								style="width: 5rem">FILTER</button>
						</div>
					</div>
				</form>
				<table class="table table-bordered text-center mt-4">
					<thead class="table-warning">
						<tr>
							<th scope="col" class="h6">Sr no.</th>
							<th scope="col" class="h6">Brand Name</th>
							<th scope="col" class="h6">Active</th>
							<th scope="col" class="h6" style="width: 10rem">Action</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${fn:length(data.rows)>0}">
							<c:forEach items="${data.rows}" var="records" varStatus="index">
								<tr class="">
									<td scope="row">${index.count + (page-1)*perPage}</td>
									<td><c:out value="${records.brand_name}" /></td>
									<td><c:if test="${ records.is_active==true }">
											<img src="./bootstrap/img/check.png"
												style="height: 1.2rem; width: 1.2rem;">
										</c:if> <c:if test="${ records.is_active==false }">
											<img src="./bootstrap/img/remove.png"
												style="height: 1.2rem; width: 1.2rem;">
										</c:if></td>
									<td
										class="d-flex justify-content-center border-start-0 align-items-center">
										<form action="updateBrand.jsp" method="POST">
											<button type="submit" class="bg-white border-0" name="id"
												value="${ records.id }">
												<i class="bi bi-pencil-square fs-5 text-warning"></i>
											</button>
										</form>
										<form action="brands.jsp" method="POST">
											<button type="submit" class="bg-white border-0" name="id"
												value="${ records.id }">
												<i class="bi bi-trash-fill fs-5 text-danger"></i>
											</button>
										</form> <a href="brands.jsp?id=${records.id}"> </a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(data.rows)==0}">
							<tr>
								<td colspan="4" class="p-5">No data found</td>
							</tr>
						</c:if>
					</tbody>
					<c:if test="${ count>1 && perPage!=-1 }">
						<tfoot>
							<tr>
								<td colspan="4">
									<div
										class="d-flex px-2 align-items-center justify-content-between">
										<h6 class="m-0">
											<c:out value="Page ${ page } of ${ count }" />
										</h6>
										<ul class="pagination pagination-sm m-0">
											<c:forEach begin="1" end="${ count }" var="item">
												<form action="${ request.url }"
													class="page-item ${ item==page ? 'active' : ''} rounded-0"
													method="GET">
													<input type="hidden" class="d-none" value="${ item }"
														name="page" /> <input type="hidden" class="d-none"
														value="${ filter_brand_name }" name="brand_name" /> <input
														type="hidden" class="d-none" value="${ perPage }"
														name="perPage" />
													<button class="page-link" type="submit">
														<c:out value="${ item }"></c:out>
													</button>
												</form>
											</c:forEach>
										</ul>
									</div>
								</td>
							</tr>
						</tfoot>
					</c:if>
				</table>
			</div>
		</div>
	</div>
	<c:set value='<%=request.getParameter("id")%>' var="toDel"></c:set>
	<c:if test="${toDel!=null}">
		<sql:update dataSource="${db}" var="result">
			DELETE FROM BRANDS WHERE ID=?;
			<sql:param value="${toDel}"></sql:param>
		</sql:update>
		<c:redirect url="brands.jsp"></c:redirect>
	</c:if>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
</html>