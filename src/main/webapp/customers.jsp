<%@page import="jakarta.servlet.jsp.PageContext"%>
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
<title>Customers</title>
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

	<!-- for deletion -->
	<c:set value='<%=request.getParameter("del_id")%>' var="del"></c:set>

	<!-- for pagination -->
	<c:set var="page"
		value='<%=request.getParameter("page") == null ? 1 : request.getParameter("page")%>'></c:set>
	<c:set var="perPage"
		value='<%=request.getParameter("perPage") == null ? 5 : request.getParameter("perPage")%>'></c:set>

	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store" user="root"
		password="kirtan2004khatri" driver="com.mysql.cj.jdbc.Driver" />

	<c:set
		value='<%=request.getParameter("full_name") == "" ? null
		: request.getParameter("full_name") == null ? null : request.getParameter("full_name")%>'
		var="full_name" />
	<c:set
		value='<%=request.getParameter("brand_id") == "" ? null : request.getParameter("brand_id")%>'
		var="brand_id" />
	<c:set
		value='<%=request.getParameter("date") == "" ? null
		: request.getParameter("date") == null ? null : request.getParameter("date")%>'
		var="date" />
		
	<c:set var="status"
			value='<%=request.getParameter("status") == null ? 3 : request.getParameter("status")%>'></c:set>
	<%-- 	<h4><c:out value="${ page }"></c:out></h4> --%>
	<sql:query var="table_data" dataSource="${db}">

		<c:if test="${ page!=null && perPage!=null }">

			<c:if
				test="${ page>=1 && full_name==null && date==null && brand_id==null }">
				
					SELECT C.ID,B.BRAND_NAME,C.MOBILE_ID,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.DATE_ORDER ,B.IS_ACTIVE, 
					(SELECT COUNT(*) FROM  CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME
						<c:if test="${ status==1 }">
							<c:out value=" WHERE IS_ACTIVE=TRUE"></c:out>
						</c:if>
						<c:if test="${ status==2 }">
							<c:out value=" WHERE IS_ACTIVE=FALSE"></c:out>
						</c:if>					
					) AS TOTAL FROM 
					CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME 
					<c:if test="${ status==1 }">
						<c:out value=" WHERE IS_ACTIVE=TRUE"></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" WHERE IS_ACTIVE=FALSE"></c:out>
					</c:if>
					<c:if test="${ perPage==-1 }">
						<c:out value=";" />
					</c:if>
					<c:if test="${ perPage!=-1 }">				
						<c:if test="${ page>1 }">
							<c:out value=" LIMIT ${ (page-1)*perPage },${ perPage }"></c:out>
						</c:if>	
						<c:if test="${ page==1 }">
							<c:out value=" LIMIT ${ perPage }"></c:out>
						</c:if>						
					</c:if>
			</c:if>


			<c:if
				test="${ page>=1 && ( full_name!=null || date!=null || brand_id!=null )}">

				<c:if test="${ full_name!=null && brand_id==null && date==null }">
				
					SELECT C.ID,B.BRAND_NAME,C.MOBILE_ID,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.DATE_ORDER, B.IS_ACTIVE, 
					(SELECT COUNT(*) FROM CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE
						<c:if test="${ status==1 }">
							<c:out value=" B.IS_ACTIVE=TRUE AND "></c:out>
						</c:if>
						<c:if test="${ status==2 }">
							<c:out value=" B.IS_ACTIVE=FALSE AND "></c:out>
						</c:if>
					FIRST_NAME LIKE ? OR LAST_NAME LIKE ? OR MIDDLE_NAME LIKE ? 
					) AS TOTAL FROM 
					CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE 
					<c:if test="${ status==1 }">
						<c:out value=" B.IS_ACTIVE=TRUE AND "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" B.IS_ACTIVE=FALSE AND "></c:out>
					</c:if>
					FIRST_NAME LIKE ? OR LAST_NAME LIKE ? OR MIDDLE_NAME LIKE ? 
					<c:if test="${ perPage>1 }">
						<c:out value=" LIMIT ${ perPage }" />
					</c:if>
					<c:if test="${ perPage<1 }">
						<c:out value=" ;" />
					</c:if>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
				</c:if>

				<c:if test="${ full_name==null && brand_id!=null && date==null }">
				
					SELECT C.ID,B.BRAND_NAME,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.MOBILE_ID,C.DATE_ORDER ,B.IS_ACTIVE, 
					(SELECT COUNT(*) FROM CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.BRAND_NAME=? 
					<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
					) AS TOTAL FROM 
					CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.BRAND_NAME=?
					<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
					<c:if test="${ perPage>1 }">
						<c:out value=" LIMIT ${ perPage }" />
					</c:if>
					<c:if test="${ perPage<1 }">
						<c:out value=" ;" />
					</c:if>
					<sql:param value="${ brand_id }"></sql:param>
					<sql:param value="${ brand_id }"></sql:param>
				</c:if>

				<c:if test="${ full_name==null && brand_id==null && date!=null }">
				
					SELECT C.ID,B.BRAND_NAME,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.MOBILE_ID,C.DATE_ORDER ,B.IS_ACTIVE, 
					(SELECT COUNT(*) FROM 
					CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.DATE_ORDER LIKE ? 
					<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
					) AS TOTAL FROM 
					CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.DATE_ORDER LIKE ?
					<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
					<c:if test="${ perPage>1 }">
						<c:out value=" LIMIT ${ perPage }" />
					</c:if>
					<c:if test="${ perPage<1 }">
						<c:out value=" ;" />
					</c:if>
					<sql:param value="%${ date }%"></sql:param>
					<sql:param value="%${ date }%"></sql:param>
				</c:if>

				<c:if
					test="${ full_name!=null && brand_id!=null && date==null && perPage!=null}">
					
					SELECT C.ID,B.BRAND_NAME,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.MOBILE_ID,C.DATE_ORDER ,B.IS_ACTIVE, 
					(SELECT COUNT(*) FROM CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.FIRST_NAME LIKE ? AND C.MIDDLE_NAME LIKE ?
				 	OR C.LAST_NAME LIKE ? AND C.BRAND_NAME=? 
					<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
				 	) AS TOTAL FROM
			 		CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.FIRST_NAME LIKE ? AND C.MIDDLE_NAME LIKE ?
				 	OR C.LAST_NAME LIKE ? AND C.BRAND_NAME=? 
				 	<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
				 	<c:if test="${ perPage>1 }">
						<c:out value=" LIMIT ${ perPage }" />
					</c:if>
					<c:if test="${ perPage<1 }">
						<c:out value=" ;" />
					</c:if>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="${brand_id}"></sql:param>

					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="${brand_id}"></sql:param>
				</c:if>

				<c:if
					test="${ full_name!=null && brand_id==null && date!=null && perPage!=null}">
					
			 		SELECT C.ID,B.BRAND_NAME,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.MOBILE_ID,C.DATE_ORDER ,B.IS_ACTIVE, 
			 		(SELECT COUNT(*) FROM CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.FIRST_NAME LIKE ? OR C.MIDDLE_NAME LIKE ? 
			 		OR C.LAST_NAME LIKE ? AND C.DATE_ORDER LIKE ? 
					<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
			 		) AS TOTAL FROM
			 		CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.FIRST_NAME LIKE ? OR C.MIDDLE_NAME LIKE ? 
			 		OR C.LAST_NAME LIKE ? AND C.DATE_ORDER LIKE ? 
			 		<c:if test="${ status==1 }">
						<c:out value=" AND IS_ACTIVE=TRUE "></c:out>
					</c:if>
					<c:if test="${ status==2 }">
						<c:out value=" AND IS_ACTIVE=FALSE "></c:out>
					</c:if>
			 		<c:if test="${ perPage>1 }">
						<c:out value=" LIMIT ${ perPage }" />
					</c:if>
					<c:if test="${ perPage<1 }">
						<c:out value=" ;" />
					</c:if>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${ date }%"></sql:param>

					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${ date }%"></sql:param>
				</c:if>

				<c:if
					test="${ full_name!=null && brand_id!=null && date!=null && perPage!=null}">
					
			 		SELECT C.ID,B.BRAND_NAME,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.MOBILE_ID,C.DATE_ORDER ,B.IS_ACTIVE, 
			 		(SELECT COUNT(*) FROM CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.FIRST_NAME LIKE ? OR C.MIDDLE_NAME LIKE ? 
			 		OR C.LAST_NAME LIKE ? AND C.DATE_ORDER LIKE ? AND C.BRAND_NAME=? ) AS TOTAL FROM
			 		CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.FIRST_NAME LIKE ? OR C.MIDDLE_NAME LIKE ? 
			 		OR C.LAST_NAME LIKE ? AND C.DATE_ORDER LIKE ? AND C.BRAND_NAME=? 
			 		
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${ date }%"></sql:param>
					<sql:param value="${brand_id}"></sql:param>

					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${full_name}%"></sql:param>
					<sql:param value="%${ date }%"></sql:param>
					<sql:param value="${brand_id}"></sql:param>
				</c:if>

				<c:if
					test="${ full_name==null && brand_id!=null && date!=null && perPage!=null}">
					
					SELECT C.ID,B.BRAND_NAME,C.FIRST_NAME,C.MIDDLE_NAME,C.LAST_NAME,C.MOBILE_ID,C.DATE_ORDER,B.IS_ACTIVE, 
					(SELECT COUNT(*) FROM 
					CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.BRAND_NAME=? ) AS TOTAL FROM 
					CUSTOMERS C INNER JOIN BRANDS B ON B.ID=C.BRAND_NAME WHERE C.BRAND_NAME=?
			 		AND C.DATE_ORDER LIKE ? 
			 		<c:if test="${ perPage>1 }">
						<c:out value=" LIMIT ${ perPage }" />
					</c:if>
					<c:if test="${ perPage<1 }">
						<c:out value=" ;" />
					</c:if>
					<sql:param value="${brand_id}"></sql:param>
					<sql:param value="%${ date }%"></sql:param>

					<sql:param value="${brand_id}"></sql:param>
					<sql:param value="%${ date }%"></sql:param>
				</c:if>

			</c:if>
		</c:if>
	</sql:query>


	<%-- To save number of pages in the data --%>

	<c:forEach items="${ table_data.rows }" var="item">
		<c:set value="${ Math.round(Math.ceil(item.total/perPage)) }"
			var="count"></c:set>
	</c:forEach>

	<div class="col-lg-10 col-md-11 col-12 bg-light p-5"
		style="overflow-y: auto">
		<div class="card">
			<div
				class="card-header d-flex justify-content-between bg-white align-items-center">
				<h4 class="text-center m-0">Customers</h4>
				<form action="addCustomer.jsp" action="POST">
					<button class="btn btn-outline-success btn-sm rounded-0"
						style="width: 5rem">Add</button>
				</form>
			</div>
			<div class="card-body pb-4">
				<div
					class="mx-0 mb-4 d-flex justify-content-between align-items-center gap-2">
					<h5 class="m-0">
						<sql:query dataSource="${db}" var="customer">
						SELECT * FROM CUSTOMERS;
					</sql:query>
						<span class="badge bg-primary bg-gradient"
							style="font-weight: 500"> <c:out
								value="TOTAL CUSTOMERS : ${fn:length(customer.rows)}" />
						</span>
					</h5>
					<form action="customers.jsp" method="POST">
						<div
							class="m-0 p-0 d-flex align-items-center justify-content-between gap-1"
							style="width: 38rem">
							<input type="text" name="full_name" class="form-control"
								placeholder="Filter by fullname" value="${full_name}"
								style="height: 2rem; font-size: 12px">
							<sql:query dataSource="${db}" var="brands">
							SELECT * FROM BRANDS;
						</sql:query>
							<select name="brand_id" class="form-select"
								style="height: 2rem;width:6rem;font-size: 12px">
								<option value="" <c:out value="${ brand_id==null }"/> >All</option>
								<c:forEach items="${brands.rows}" var="item">
										<option value="${ item.id }" <c:out value="${ brand_id==item.id ? 'selected' : '' }"/> ><c:out
												value="${ item.brand_name }" /></option>
								</c:forEach>
							</select> 
							<select name="status"
								class="form-select"
								style="height: 2rem; font-size: 12px; width: 5.5rem">
								<option value="3"
									<c:out value="${ status==3 ? 'selected' : '' }" />>Both</option>
								<option value="1"
									<c:out value="${ status==1 ? 'selected' : '' }" />>Active</option>
								<option value="2"
									<c:out value="${ status==2 ? 'selected' : '' }" />>In-Active
							</select>
							<input type="date" name="date" value="${date}"
								class="form-control" placeholder="Filter by date"
								style="height: 2rem; font-size: 12px"> <select
								class="form-select" name="perPage"
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
							<button class="btn btn-primary p-0 rounded-0" type="submit"
								style="width: 23rem; height: 2rem">Filter</button>
						</div>
					</form>
				</div>
				<div class="m-0 p-0">
					<table class="table table-bordered">
						<thead class="text-center table-warning">
							<th style="width: 5rem" class="h6">#</th>
							<th style="width: 15rem" class="h6">Full Name</th>
							<th style="width: 10rem" class="h6">Brand</th>
							<th scope="col" style="width: 2rem" class="h6">Active(Brand)</th>
							<th style="width: 10rem" class="h6">Model</th>
							<th style="width: 10rem" class="h6 px-0">Date Of Purchase</th>
							<th style="width: 5rem" class="h6">Actions</th>
						</thead>
						<tbody class="text-center">

							<c:if test="${fn:length(table_data.rows)==0}">
								<tr>
									<td colspan="6" class="bg-light p-5">No Customer Data</td>
								</tr>
							</c:if>

							<c:if test="${fn:length(table_data.rows)!=0}">
								<c:forEach items="${table_data.rows}" var="item"
									varStatus="index">
									<tr>
										<td class=""><c:out
												value="${index.count + (page-1)*perPage }" /></td>
										<td class=""><c:out
												value="${item.first_name} ${item.middle_name} ${item.last_name}" /></td>
										<td class=""><c:out value="${item.brand_name}" /></td>

										<td><c:if test="${ item.is_active==true }">
												<img src="./bootstrap/img/check.png"
													style="height: 1.2rem; width: 1.2rem;">
											</c:if> <c:if test="${ item.is_active==false }">
												<img src="./bootstrap/img/remove.png"
													style="height: 1.2rem; width: 1.2rem;">
											</c:if></td>

										<sql:query dataSource="${ db }" var="mobile">
											SELECT MODEL_NAME FROM MOBILES WHERE ID = ?
											<sql:param value="${ item.mobile_id }"></sql:param>
										</sql:query>

										<c:if test="${ fn:length(mobile.rows) > 0 }">
											<c:forEach items="${ mobile.rows }" var="phone">
												<td class=""><c:out value="${phone.model_name}" /></td>
											</c:forEach>
										</c:if>
										<c:if test="${ fn:length(mobile.rows) == 0 }">
											<td class="">-</td>
										</c:if>

										<td class=""><c:out
												value="${fn:substring(item.date_order,0,10)}" /></td>
										<td
											class="d-flex justify-content-center border-start-0 gap-2 align-items-center">
											<form action="updateCustomer.jsp" method="POST">
												<button type="submit" name="updt_id" <c:out value="${ item.is_active==true ? '' : 'disabled' }" />
													class="bg-white p-0 m-0 border-0" value="${ item.id }">
													<i class="bi bi-pencil-square fs-5  <c:out value="${ item.is_active==true ? 'text-warning' : 'text-secondary' }" />"></i>
												</button>
											</form>
											<form action="customers.jsp" method="POST">
												<button type="submit" name="del_id" <c:out value="${ item.is_active==true ? '' : 'disabled' }" />
													class="bg-white p-0 m-0 border-0" value="${ item.id }">
													<i class="bi bi-trash-fill fs-5  <c:out value="${ item.is_active==true ? 'text-danger' : 'text-secondary' }" />"></i>
												</button>
											</form>
											<form action="viewCustomer.jsp" method="POST">
												<button type="submit" name="view_id" <c:out value="${ item.is_active==true ? '' : 'disabled' }" />
													class="bg-white p-0 m-0 border-0" value="${ item.id }">
													<i class="bi bi-eye-fill fs-5  <c:out value="${ item.is_active==true ? 'text-primary' : 'text-secondary' }" />"></i>
												</button>
											</form>
										</td>
									</tr>
								</c:forEach>
							</c:if>


						</tbody>
						<tfoot>
							<tr>
								<td colspan="7">
									<nav
										class="d-flex align-items-center justify-content-between py-1 px-2">
										<div>
											<h6>
												<c:if test="${ count > 1}">
													<c:out value="Page ${page} of ${count}" />
												</c:if>
												<c:if test="${ count < 1}">
													<c:out value=" " />
												</c:if>
											</h6>
										</div>
										<c:if test="${ count>1 }">
											<div class="pagination pagination-sm m-0">
												<c:forEach begin="1" end="${count}" var="item">
													<form action="${ request.url }"
														class="page-item ${ item==page ? 'active' : ''} rounded-0"
														method="POST">
														<input type="hidden" class="d-none" value="${ item }"
															name="page" /> <input type="hidden" class="d-none"
															value="${ full_name }" name="full_name" /> <input
															type="hidden" class="d-none" value="${ brand_id }"
															name="brand_id" /> <input type="hidden" class="d-none"
															value="${ date }" name="date" /> <input type="hidden"
															class="d-none" value="${ perPage }" name="perPage" />
														<button class="page-link" type="submit">
															<c:out value="${ item }"></c:out>
														</button>
													</form>
												</c:forEach>
											</div>
										</c:if>
									</nav>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
		</form>
	</div>
	<c:if test="${ del!=null }">
		<sql:update dataSource="${db}">
			DELETE FROM CUSTOMERS WHERE ID=?
			<sql:param value="${ del }"></sql:param>
		</sql:update>
		<c:redirect url="customers.jsp"></c:redirect>
	</c:if>
</body>
</html>