<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	response.sendRedirect("login.jsp");
}
%>
<%@ include file="sidebar.jsp"%>
<body>

	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store" user="root"
		password="kirtan2004khatri" driver="com.mysql.cj.jdbc.Driver" />

	<div class="col-lg-10 col-md-11 col-12 bg-light p-5"
		style="overflow-y: scroll">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="mobiles.jsp">Mobiles</a></li>
				<li class="breadcrumb-item active">Add Mobiles</li>
			</ol>
		</nav>
		<div class="card p-0 m-0 shadow">
			<h3 class="card-header rounded-top py-2 bg-white text-center">Add
				Mobile</h3>
			<form action="addmobiles.jsp" class="px-5 py-3 card-body"
				method="POST">
				<div class="my-3">
					<label for="pname" class="form-label">Model name : </label> <input
						class="form-control" name="product_name" id="pname" type="text"
						placeholder="Enter the product name" required />
				</div>
				<div class="my-3">
					<sql:query var="item" dataSource="${db}">
                      SELECT * FROM BRANDS
                    </sql:query>
					<label for="bname" class="form-label">Brand name : </label> <select
						name="brand_name" class="form-select" id="bname" required>
						<option value="" selected>Select brand</option>
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
						<option value="" selected>Select RAM</option>
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
						<option value="" selected>Select ROM</option>
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
                      SELECT * FROM INTERNAL_MEMORY
                    </sql:query>
					<label for="imem" class="form-label">Internal Memory: </label> <select
						name="internal_memory" class="form-select" id="imem" required>
						<option value="" selected>Select Internal Memory</option>
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
						<option value="" selected>Select External Memory</option>
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
						<option value="" selected>Select Screen Size</option>
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
						<option value="" selected>Select Network Type</option>
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
						<option value="" selected>Select Rear Camera</option>
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
						<option value="" selected>Select Front Camera</option>
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
						<option value="" selected>Select SIM tray</option>
						<!-- Here goes the sql foreach loop -->
						<c:forEach var="data" items="${item.rows}">
							<option value="${data.id}">
								<c:out value="${data.tray}" />
							</option>
						</c:forEach>
					</select>
				</div>
				<!-- <div class="my-3">
					<label for="image1" class="form-label">Mobile Image 1: </label> <input
						type="file" name="image1" id="img1" class="form-control"
						accept=".jpg,.png" r>
				</div>
				<div class="my-3">
					<label for="image2" class="form-label">Mobile Image 2: </label> <input
						type="file" name="image2" id="img2" class="form-control"
						accept=".jpg,.png" r>
				</div>
				<div class="my-3">
					<label for="image3" class="form-label">Mobile Image 3: </label> <input
						type="file" name="image3" id="img3" class="form-control"
						accept=".jpg,.png" r>
				</div> -->
				<div class="my-3">
					<label for="mprice" class="form-label">Cost Price: </label> <input
						name="cost_price" id="mprice" class="form-control"
						placeholder="Enter the price of the mobile" type="number"
						min="5000" required>
				</div>
				<div class="my-3">
					<label for="mprice" class="form-label">Sales Price: </label> <input
						name="sales_price" id="mprice" class="form-control"
						placeholder="Enter the price of the mobile" type="number"
						min="5000" required>
				</div>
				<div class="my-3">
					<label for="qty" class="form-label">Quantity: </label> <input
						name="qty" id="qty" class="form-control" type="number"
						placeholder="Enter quantity of mobile" min="1" value="1" required>
				</div>
				<div class="my-3">
					<button class="btn btn-primary ms-auto d-block">Submit</button>
				</div>
			</form>
			<c:if test='<%=request.getParameter("brand_name") != null%>'>
				<sql:setDataSource var="db"
					url="jdbc:mysql://localhost:3306/mobile_store"
					driver="com.mysql.cj.jdbc.Driver" user="root"
					password="kirtan2004khatri" />
				<sql:update dataSource="${db}" var="result">
			INSERT INTO MOBILES(model_name,brand_id,ram_id,rom_id,
			im_id,em_id,screen_id,network_id,front_id,rear_id,sim_id,cost_price,sales_price,quantity) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)
					<sql:param value='<%=request.getParameter("product_name")%>'></sql:param>
					<sql:param value='<%=request.getParameter("brand_name")%>'></sql:param>
					<sql:param value='<%=request.getParameter("ram")%>'></sql:param>
					<sql:param value='<%=request.getParameter("rom")%>'></sql:param>
					<sql:param value='<%=request.getParameter("internal_memory")%>'></sql:param>
					<sql:param value='<%=request.getParameter("external_memory")%>'></sql:param>
					<sql:param value='<%=request.getParameter("screen_size")%>'></sql:param>
					<sql:param value='<%=request.getParameter("network_type")%>'></sql:param>
					<sql:param value='<%=request.getParameter("front_camera")%>'></sql:param>
					<sql:param value='<%=request.getParameter("rear_camera")%>'></sql:param>
					<sql:param value='<%=request.getParameter("sim_tray")%>'></sql:param>
					<sql:param value='<%=request.getParameter("cost_price")%>'></sql:param>
					<sql:param value='<%=request.getParameter("sales_price")%>'></sql:param>
					<sql:param value='<%=request.getParameter("qty")%>'></sql:param>
				</sql:update>
				<c:redirect url="mobiles.jsp"></c:redirect>
			</c:if>
		</div>
	</div>


</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

</html>