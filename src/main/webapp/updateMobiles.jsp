<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" buffer="100kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.mobile_store.Mobile"%>
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

<title>Mobiles</title>
</head>
<%-- Validating login --%>
<%
if (session.getAttribute("isLogin") == null) {
	//response.sendRedirect("login.jsp");
}
%>
<%@ include file="sidebar.jsp"%>
<body>
	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store" user="root"
		password="kirtan2004khatri" driver="com.mysql.cj.jdbc.Driver" />

	<div class="col-lg-10 col-md-11 col-12 bg-light p-5"
		style="overflow-y: auto">
	<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="mobiles.jsp">Mobiles</a></li>
				<li class="breadcrumb-item active">Update Mobiles</li>

			</ol>
		</nav>
		<c:if test='<%=request.getParameter("id") != null%>'>

			<c:set value='<%=request.getParameter("id")%>' var="update_id"></c:set>

			<sql:query dataSource="${db}" var="mob_data">
				SELECT * FROM MOBILES WHERE ID=?
				<sql:param value="${update_id}"></sql:param>
			</sql:query>

			<c:if test="${fn:length(mob_data.rows)>0}">


				<div class="card p-0 m-0 shadow">

					<h3 class="card-header rounded-top py-2 bg-white text-center">Update
						Mobile</h3>

					<c:forEach var="main_item" items="${mob_data.rows}">

						<form action="updateMobiles.jsp" class="px-5 py-3 card-body"
							method="POST">
							<div class="my-3">
								<label for="pname" class="form-label">Model name : </label> <input
									class="form-control" name="product_name" id="pname" type="text"
									placeholder="Enter the product name" required
									value="${main_item.model_name}" />
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM BRANDS
                    </sql:query>
								<label for="bname" class="form-label">Brand name : </label> <select
									name="brand_name" class="form-select" id="bname" required>

									<c:if test="${main_item.brand_id!=null}">
										<option value="${main_item.brand_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM BRANDS WHERE ID=?
                      							<sql:param value="${main_item.brand_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.brand_name}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select brand</option>
									</c:if>

									<c:if test="${main_item.brand_id==null}">
										<option value="" selected>Select brand</option>
									</c:if>

									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}" <c:out value="${ data.is_active==true ? '' : 'disabled' }" />>
											<c:out value="${data.brand_name}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM RAM_LIST
                    </sql:query>
								<label for="ram" class="form-label">RAM : </label> <select
									name="ram" class="form-select" id="ram" required>
									<c:if test="${main_item.ram_id!=null}">
										<option value="${main_item.ram_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM RAM_LIST WHERE ID=?
                      							<sql:param value="${main_item.ram_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.ram}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select RAM</option>
									</c:if>

									<c:if test="${main_item.brand_id==null}">
										<option value="" selected>Select brand</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.ram}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM ROM_LIST
                    </sql:query>
								<label for="rom" class="form-label">ROM : </label> <select
									name="rom" class="form-select" id="ram" required>
									<c:if test="${main_item.rom_id!=null}">
										<option value="${main_item.rom_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM ROM_LIST WHERE ID=?
                      							<sql:param value="${main_item.rom_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.size}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select ROM</option>
									</c:if>

									<c:if test="${main_item.brand_id==null}">
										<option value="" selected>Select brand</option>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.size}" />
										</option>
									</c:forEach>
									</c:if>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM INTERNAL_MEMORY
                    </sql:query>
								<label for="imem" class="form-label">Internal Memory: </label> <select
									name="internal_memory" class="form-select" id="imem" required>
									<c:if test="${main_item.im_id!=null}">
										<option value="${main_item.im_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM INTERNAL_MEMORY WHERE ID=?
                      							<sql:param value="${main_item.im_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.size}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select Internal Memory</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.size}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM EXTERNAL_MEMORY
                    </sql:query>
								<label for="emem" class="form-label">External Memory: </label> <select
									name="external_memory" class="form-select" id="emem" required>
									<c:if test="${main_item.em_id!=null}">
										<option value="${main_item.em_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM EXTERNAL_MEMORY WHERE ID=?
                      							<sql:param value="${main_item.em_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.size}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select External Memory</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.size}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM SCREEN_SIZE
                    </sql:query>
								<label for="sszie" class="form-label">Screen Size: </label> <select
									name="screen_size" class="form-select" id="ssize" required>
									<c:if test="${main_item.screen_id!=null}">
										<option value="${main_item.screen_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM SCREEN_SIZE WHERE ID=?
                      							<sql:param value="${main_item.screen_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.size}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select Screen Size</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.size}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM NETWORK_LIST
                    </sql:query>
								<label for="ncon" class="form-label">Network Type: </label> <select
									name="network_type" class="form-select" id="ncon" required>
									<c:if test="${main_item.network_id!=null}">
										<option value="${main_item.network_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM NETWORK_LIST WHERE ID=?
                      							<sql:param value="${main_item.network_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.network_type}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select Network Type</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.network_type}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM CAMERA_LIST
                    </sql:query>
								<label for="rcam" class="form-label">Rear Camera: </label> <select
									name="rear_camera" class="form-select" id="rcam" required>
									<c:if test="${main_item.rear_id!=null}">
										<option value="${main_item.rear_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM CAMERA_LIST WHERE ID=?
                      							<sql:param value="${main_item.rear_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.megapixel}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select Rear Camera</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.megapixel}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM CAMERA_LIST
                    </sql:query>
								<label for="fcam" class="form-label">Front Camera: </label> <select
									name="front_camera" class="form-select" id="fcam" required>
									<c:if test="${main_item.front_id!=null}">
										<option value="${main_item.front_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM CAMERA_LIST WHERE ID=?
                      							<sql:param value="${main_item.front_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.megapixel}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select Front Camera</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.megapixel}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<sql:query var="item" dataSource="${db}">
                      SELECT * FROM SIM_TRAY
                    </sql:query>
								<label for="stray" class="form-label">SIM Tray: </label> <select
									name="sim_tray" class="form-select" id="stray" required>
									<c:if test="${main_item.sim_id!=null}">
										<option value="${main_item.sim_id}" selected>
											<sql:query var="data" dataSource="${db}">
                      							SELECT * FROM SIM_TRAY WHERE ID=?
                      							<sql:param value="${main_item.sim_id}"></sql:param>
											</sql:query>
											<c:forEach items="${data.rows}" var="i">
												<c:out value="${i.tray}"></c:out>
											</c:forEach>
										</option>
										<option value="">Select SIM Tray</option>
									</c:if>
									<!-- Here goes the sql foreach loop -->
									<c:forEach var="data" items="${item.rows}">
										<option value="${data.id}">
											<c:out value="${data.tray}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="my-3">
								<label for="mprice" class="form-label">Cost Price: </label> <input
									name="cost_price" id="mprice" class="form-control"
									placeholder="Enter the price of the mobile" type="number"
									min="5000" required value="${main_item.cost_price}">
							</div>
							<div class="my-3">
								<label for="sprice" class="form-label">Sales Price: </label> <input
									name="sales_price" id="sprice" class="form-control"
									placeholder="Enter the price of the mobile" type="number"
									min="5000" required value="${main_item.sales_price}">
							</div>
							<div class="my-3">
								<label for="qty" class="form-label">Quantity: </label> <input
									name="qty" id="qty" class="form-control" type="number"
									placeholder="Enter quantity of mobile" min="1" value="${main_item.quantity}"
									required>
							</div>
							<input type="hidden" value="${ update_id }" name="id">
							<div class="my-3">
								<button class="btn btn-primary ms-auto d-block">Submit</button>
							</div>
						</form>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${fn:length(mob_data.rows)==0}">
				<div class="card p-0 m-0 shadow-sm">
					<h4 class="text-center">No mobile found</h4>
				</div>
			</c:if>
		</c:if>
	</div>
	<c:if test='<%=request.getParameter("brand_name") != null%>'>
		<sql:update dataSource="${db}" var="update_query">
				UPDATE MOBILES SET BRAND_ID=?,MODEL_NAME=?,RAM_ID=?,ROM_ID=?,REAR_ID=?,FRONT_ID=?,
				SCREEN_ID=?,SIM_ID=?,IM_ID=?,EM_ID=?,NETWORK_ID=?,COST_PRICE=?,SALES_PRICE=?,QUANTITY=? WHERE ID=?;
			<sql:param value='<%=request.getParameter("brand_name")%>'></sql:param>
			<sql:param value='<%=request.getParameter("product_name")%>'></sql:param>
			<sql:param value='<%=request.getParameter("ram")%>'></sql:param>
			<sql:param value='<%=request.getParameter("rom")%>'></sql:param>
			<sql:param value='<%=request.getParameter("rear_camera")%>'></sql:param>
			<sql:param value='<%=request.getParameter("front_camera")%>'></sql:param>
			<sql:param value='<%=request.getParameter("screen_size")%>'></sql:param>
			<sql:param value='<%=request.getParameter("sim_tray")%>'></sql:param>
			<sql:param value='<%=request.getParameter("internal_memory")%>'></sql:param>
			<sql:param value='<%=request.getParameter("external_memory")%>'></sql:param>
			<sql:param value='<%=request.getParameter("network_type")%>'></sql:param>
			<sql:param value='<%=request.getParameter("cost_price")%>'></sql:param>
			<sql:param value='<%=request.getParameter("sales_price")%>'></sql:param>
			<sql:param value='<%=request.getParameter("qty")%>'></sql:param>
			<sql:param value="${update_id}"></sql:param>
		</sql:update>
		<c:redirect url="mobiles.jsp"></c:redirect>
	</c:if>

</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
</html>