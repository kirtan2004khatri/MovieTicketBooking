<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" buffer="10kb"%>
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

		<c:set var="page"
			value='<%=request.getParameter("page") == null ? 1 : request.getParameter("page")%>'></c:set>
		<c:set var="perPage"
			value='<%=request.getParameter("perPage") == null ? 5 : request.getParameter("perPage")%>'></c:set>
		<c:set var="brand_id"
			value='<%=request.getParameter("brand_id") == ""
		? -1
		: request.getParameter("brand_id") == null ? -1 : request.getParameter("brand_id")%>'></c:set>
		<c:set var="model_name"
			value='<%=request.getParameter("model_name") == ""
		? null : request.getParameter("model_name")%>'></c:set>

		<c:set var="status"
			value='<%=request.getParameter("status") == null ? 3 : request.getParameter("status")%>'></c:set>

		<sql:query var="result" dataSource="${db}">
			SELECT * FROM BRANDS
		</sql:query>

		<sql:query dataSource="${db}" var="mob_data">

			<c:if test="${ brand_id>1 && model_name!=null }">
				SELECT M.ID,B.BRAND_NAME,M.model_name,M.COST_PRICE,M.SALES_PRICE,B.IS_ACTIVE,
				(SELECT COUNT(*) FROM MOBILES M INNER JOIN BRANDS B ON B.ID=M.BRAND_ID
				WHERE M.BRAND_ID=? AND M.model_name LIKE ?
				<c:if test="${ status==1 }">
					<c:out value=" AND IS_ACTIVE=TRUE"></c:out>
				</c:if>
				<c:if test="${ status==2 }">
					<c:out value=" AND IS_ACTIVE=FALSE"></c:out>
				</c:if>
				) AS TOTAL FROM MOBILES M INNER JOIN BRANDS B
				ON B.ID=M.BRAND_ID WHERE M.BRAND_ID=? AND M.model_name LIKE ?
				<c:if test="${ status==1 }">
					<c:out value=" AND IS_ACTIVE=TRUE"></c:out>
				</c:if>
				<c:if test="${ status==2 }">
					<c:out value=" AND IS_ACTIVE=FALSE"></c:out>
				</c:if>
				<c:if test="${ page==1 && perPage!=-1 }">
					<c:out value=" LIMIT ${ perPage } ;" />
				</c:if>
				<c:if test="${ perPage==-1}">
					<c:out value=";" />
				</c:if>
				<c:if test="${ page>1 && perPage!=-1 }">
					<c:out value=" LIMIT ${ (page-1)*perPage } , ${ perPage } ;" />
				</c:if>
				<sql:param value="${ brand_id }"></sql:param>
				<sql:param value="%${ model_name }%"></sql:param>
				<sql:param value="${ brand_id }"></sql:param>
				<sql:param value="%${ model_name }%"></sql:param>
			</c:if>
			<c:if test="${ brand_id<1 && model_name!=null }">
					SELECT M.ID,B.BRAND_NAME,M.model_name,M.COST_PRICE,M.SALES_PRICE,B.IS_ACTIVE,
					(SELECT COUNT(*) FROM MOBILES M INNER JOIN BRANDS B ON B.ID=M.BRAND_ID WHERE M.MODEL_NAME LIKE ? 
					<c:if test="${ status==1 }">
						<c:out value=" AND B.IS_ACTIVE=TRUE"></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND B.IS_ACTIVE=FALSE"></c:out>
					</c:if>
					) AS TOTAL
					FROM MOBILES M INNER JOIN BRANDS B ON B.ID=M.BRAND_ID WHERE M.MODEL_NAME LIKE ?
				<c:if test="${ status==1 }">
					<c:out value=" AND B.IS_ACTIVE=TRUE"></c:out>
				</c:if>
				<c:if test="${ status==2 }">
					<c:out value=" AND B.IS_ACTIVE=FALSE"></c:out>
				</c:if>
<%-- 				<c:if test="${ page==1 && perPage!=-1 }">
					<c:out value=" LIMIT ${ perPage } ;" />
				</c:if>
				<c:if test="${ perPage==-1}">
					<c:out value=";" />
				</c:if>
				<c:if test="${ page>1 && perPage!=-1}">
					<c:out value=" LIMIT ${ (page-1)*perPage } , ${ perPage } ;" />
				</c:if> --%>
				<sql:param value="%${ model_name }%"></sql:param>
				<sql:param value="%${ model_name }%"></sql:param>
			</c:if>
			<c:if test="${ brand_id<1 && model_name==null }">
					SELECT M.ID,B.BRAND_NAME,M.model_name,M.COST_PRICE,M.SALES_PRICE,B.IS_ACTIVE,
					(SELECT COUNT(*) FROM MOBILES M INNER JOIN BRANDS B ON B.ID=M.BRAND_ID WHERE M.MODEL_NAME LIKE ? 
					<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE"></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND  IS_ACTIVE=FALSE"></c:out>
					</c:if>
					) AS TOTAL
					FROM MOBILES M INNER JOIN BRANDS B ON B.ID=M.BRAND_ID WHERE M.MODEL_NAME LIKE ?
				<c:if test="${ status==1 }">
					<c:out value=" AND IS_ACTIVE=TRUE"></c:out>
				</c:if>
				<c:if test="${ status==2 }">
					<c:out value=" AND IS_ACTIVE=FALSE"></c:out>
				</c:if>
				<c:if test="${ page==1 && perPage!=-1 }">
					<c:out value=" LIMIT ${ perPage } ;" />
				</c:if>
				<c:if test="${ perPage==-1}">
					<c:out value=";" />
				</c:if>
				<c:if test="${ page>1 && perPage!=-1 }">
					<c:out value=" LIMIT ${ (page-1)*perPage } , ${ perPage } ;" />
				</c:if>
				<sql:param value="%${ model_name }%"></sql:param>
				<sql:param value="%${ model_name }%"></sql:param>
			</c:if>
			<c:if test="${ brand_id>1 && model_name==null }">
				SELECT M.ID,B.BRAND_NAME,M.model_name,M.COST_PRICE,M.SALES_PRICE,B.IS_ACTIVE,
				(SELECT COUNT(*) FROM MOBILES M INNER JOIN BRANDS B ON B.ID=M.BRAND_ID
				WHERE M.BRAND_ID=?) AS TOTAL FROM MOBILES M INNER JOIN BRANDS B
				ON B.ID=M.BRAND_ID WHERE M.BRAND_ID=?
				<c:if test="${ status==1 }">
					<c:out value=" AND IS_ACTIVE=TRUE"></c:out>
				</c:if>
				<c:if test="${ status==2 }">
					<c:out value=" AND IS_ACTIVE=FALSE"></c:out>
				</c:if>
				<c:if test="${ page==1 && perPage!=-1 }">
					<c:out value=" LIMIT ${ perPage } ;" />
				</c:if>
				<c:if test="${ page==-1}">
					<c:out value=";" />
				</c:if>
				<c:if test="${ page>1 && perPage!=-1 }">
					<c:out value=" LIMIT ${ (page-1)*perPage } , ${ perPage } ;" />
				</c:if>
				<sql:param value="${ brand_id }"></sql:param>
				<sql:param value="${ brand_id }"></sql:param>
			</c:if>
		</sql:query>

		<c:forEach items="${ mob_data.rows }" var="value">
			<c:set var="count"
				value="${ Math.round(Math.ceil(value.total/perPage)) }"></c:set>
		</c:forEach>

		<sql:query dataSource="${ db }" var="total">
			SELECT M.ID,B.BRAND_NAME,M.model_name,M.COST_PRICE,M.SALES_PRICE,B.IS_ACTIVE FROM MOBILES M INNER JOIN BRANDS B ON B.ID=M.BRAND_ID;
		</sql:query>
		<div class="card">
			<div
				class="card-header bg-light d-flex align-items-center bg-white justify-content-between">
				<h4 class="text-center m-0">Mobiles</h4>
				<a href="addmobiles.jsp"
					class="btn btn-outline-success btn-sm rounded-0"
					style="width: 5rem">Add</a>
			</div>
			<div class="card-body">
				<form action="mobiles.jsp" method="POST">
					<div
						class="mx-0 px-1 d-flex justify-content-between align-items-center">
						<h5 class="m-0">
							<span class="badge bg-primary"
								style="font-weight: 500; width: 11rem"> <c:out
									value="TOTAL MOBILES : ${ fn:length(total.rows) }" />
							</span>
						</h5>
						<div class="d-flex align-items-center gap-1" style="width: 30rem">
							<input class="form-control" name="model_name"
								placeholder="Search by model name" value="${ model_name }"
								style="height: 2rem; font-size: 12px" /> <select name="status"
								class="form-select"
								style="height: 2rem; font-size: 12px; width: 5.5rem">
								<option value="3"
									<c:out value="${ status==3 ? 'selected' : '' }" />>Both</option>
								<option value="1"
									<c:out value="${ status==1 ? 'selected' : '' }" />>Active</option>
								<option value="2"
									<c:out value="${ status==2 ? 'selected' : '' }" />>In-Active
								
							</select> <select name="brand_id" id="brand" class="form-select"
								style="height: 2rem; width: 6rem; font-size: 12px">
									<option value="">Select brand</option>
									<option value="-1"  <c:out value="${ brand_id==-1 ? 'selected' : '' }"/> >All</option>							
									<c:forEach items="${result.rows}" var="item">
										<option value="${item.id}" <c:out value="${ item.id==brand_id ? 'selected' : '' }"/>>
											<c:out value="${item.brand_name}"></c:out>
									</c:forEach>
							</select> <select name="perPage" class="form-select"
								style="height: 2rem; width: 5rem; font-size: 12px">
								<option value="5"
									<c:out value='${ perPage==5 ? "selected" : "" }' />>5</option>
								<option value="10"
									<c:out value='${ perPage==10 ? "selected" : "" }' />>10</option>
								<option value="20"
									<c:out value='${ perPage==20 ? "selected" : "" }' />>20</option>
								<option value="-1"
									<c:out value='${ perPage==-1 ? "selected" : "" }' />>All</option>
							</select>
							<button class="btn btn-primary btn-sm rounded-0"
								style="width: 7rem">Go</button>
						</div>
					</div>
				</form>
				<div class="mx-0 mt-3 mb-5 p-0 px-1">
					<table class="table table-bordered table-responsive">
						<thead class="text-center table-warning">
							<tr>
								<th scope="col" style="width: 5rem" class="h6">Sr no.</th>
								<th scope="col" style="width: 15rem" class="h6">Brand</th>
								<th scope="col" style="width: 2rem" class="h6">Active(Brand)</th>
								<th scope="col" style="width: 15rem" class="h6">Model</th>
								<th scope="col" style="width: 10rem" class="h6">Cost Price(<i
									class="bi bi-currency-rupee" />)
								</th>
								<th scope="col" style="width: 10rem" class="h6">Sales
									Price(<i class="bi bi-currency-rupee" />)
								</th>
								<th scope="col" style="width: 10rem" class="h6">Actions</th>
							</tr>
						</thead>
						<tbody class="text-center">
							<c:if test='${ brand_id!=null }'>
								<c:if test="${fn:length(mob_data.rows)>0}">
									<c:forEach items="${mob_data.rows}" var="item"
										varStatus="index">
										<tr class="align-center">
											<td><c:out value="${index.count+(page-1)*perPage}"></c:out></td>
											<td><c:out value="${item.brand_name}"></c:out></td>
											<td class="px-0"><c:if test="${ item.is_active==true }">
													<img src="./bootstrap/img/check.png"
														style="height: 1.2rem; width: 1.2rem;">
												</c:if> <c:if test="${ item.is_active==false }">
													<img src="./bootstrap/img/remove.png"
														style="height: 1.2rem; width: 1.2rem;">
												</c:if></td>
											<td><c:out value="${item.model_name}"></c:out></td>
											<td><c:out value="${item.cost_price}"></c:out></td>
											<td><c:out value="${item.sales_price}"></c:out></td>
											<td
												class="d-flex justify-content-center border-start-0 gap-2 align-items-center">
												<form action="updateMobiles.jsp" method="POST">
													<button type="submit" name="id"
														<c:out value="${ item.is_active==true ? '' : 'disabled' }" />
														class="bg-white p-0 m-0 border-0" value="${ item.id }">
														<i
															class="bi bi-pencil-square fs-5 <c:out value="${ item.is_active==true ? 'text-warning' : 'text-secondary' }" />"></i>
													</button>
												</form>
												<form action="mobiles.jsp" method="POST">
													<button type="submit" name="id"
														<c:out value="${ item.is_active==true ? '' : 'disabled' }" />
														class="bg-white p-0 m-0 border-0" value="${ item.id }">
														<i
															class="bi bi-trash-fill fs-5 <c:out value="${ item.is_active==true ? 'text-danger' : 'text-secondary' }" />"></i>
													</button>
												</form>
												<form action="ViewMobiles.jsp" method="POST">
													<button type="submit" name="id"
														<c:out value="${ item.is_active==true ? '' : 'disabled' }" />
														class="bg-white p-0 m-0 border-0" value="${ item.id }">
														<i
															class="bi bi-eye-fill fs-5 <c:out value="${ item.is_active==true ? 'text-primary' : 'text-secondary' }" />"></i>
													</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(mob_data.rows)==0}">
									<tr>
										<td colspan=7 class="p-5 text-muted">No data available</td>
									</tr>
								</c:if>
							</c:if>
						</tbody>
						<c:if test="${ count>1 && perPage!=-1 }">
							<tfoot>
								<tr>
									<td colspan="7">
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
															value="${ brand_id }" name="brand_id" /> <input
															type="hidden" class="d-none" value="${ perPage }"
															name="perPage" />
														<button class="page-link" type="submit">
															<c:out value="${ item }"></c:out>
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
		<%-- For mobile deletion --%>
		<c:if test='<%=request.getParameter("id") != null%>'>
			<c:set var="del_id" value='<%=request.getParameter("id")%>'></c:set>
			<sql:update dataSource="${db}">
									DELETE FROM MOBILES WHERE id=?;
									<sql:param value="${del_id}"></sql:param>
			</sql:update>
			<c:redirect url="mobiles.jsp"></c:redirect>
		</c:if>
	</div>
</body>
<script>
	function func(item) {
		console.log(item);
	}
</script>
</html>