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
<%-- Validating login --%>
<%
if (session.getAttribute("isLogin") == null) {
	response.sendRedirect("login.jsp");
}
%>
<%@ include file="sidebar.jsp"%>
<body style="overflow-y: auto">

	<c:set value="<%=null%>" var="showError"></c:set>

	<sql:setDataSource var="db"
		url="jdbc:mysql://localhost:3306/mobile_store"
		driver="com.mysql.cj.jdbc.Driver" user="root"
		password="kirtan2004khatri" />
	<div class="col-lg-10 col-md-11 col-12 bg-light p-5">

		<!-- FOR SHOWING ERROR  -->
		<c:set value='<%=request.getParameter("age")%>' var="age"></c:set>
		<c:set value='<%=request.getParameter("brand_id_option")%>'
			var="brand_id_option"></c:set>

		<c:if test="${ age<18 }">
			<c:remove var="showError"></c:remove>
			<c:set value="Age should not be less than 18" var="showError"></c:set>
		</c:if>
		<c:if test="${ age>100 }">
			<c:remove var="showError"></c:remove>
			<c:set value="Age should not be greater than 100" var="showError"></c:set>
		</c:if>

		<%!public boolean contact_checker(String number) {
		boolean check = false;
		int length = number.length();
		int temp = 0;
		char non_alpha[] = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};
		for (char n : non_alpha) {
			for (int i = 0; i < length; i++) {
				if (n != number.toCharArray()[i]) {
					break;
				} else {
					if (temp != 10) {
						temp++;
					}
				}
			}
		}
		if (temp == length && length == 10) {
			return true;
		} else {
			return false;
		}
	};%>
		<c:if test="dd">
			<c:remove var="showError"></c:remove>
			<c:set value="Age should not be less than 18" var="showError"></c:set>
		</c:if>
		<c:if test="${ age>100 }">
			<c:remove var="showError"></c:remove>
			<c:set value="Age should not be greater than 100" var="showError"></c:set>
		</c:if>

		<c:set value='<%=request.getParameter("fname")%>' var="fname"></c:set>


		<c:if test="${ showError!=null }">
			<div class="alert alert-danger alert-dismissible fade show"
				role="alert">
				<strong>Incorrect age!</strong>
				<c:out value="${ showError }"></c:out>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
		</c:if>
		<!-- ----------------------------- -->
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="customers.jsp">Customers</a></li>
				<li class="breadcrumb-item active">Add Customers</li>
			</ol>
		</nav>
		<div class="card">
			<h3 class="card-header text-center bg-white">Customer Details</h3>
			<div class="card-body p-0">
				<form action="addCustomer.jsp" method="POST"
					class="px-5 py-3 card-body">
					<h5 class="mb-4 mt-3">Mobile Details</h5>
					<div class="my-3">
						<label for="bname" class="form-label">Brand name : </label>
						<sql:query var="brands" dataSource="${db}">
                    	SELECT * FROM BRANDS
                    </sql:query>
						<select name="brand_name" class="form-select" id="bname" required>
							<option value="" selected>Select brand</option>
							<c:forEach items="${ brands.rows }" var="item">
								<option value="${item.id}" <c:out value="${ brand_id_option == item.id ? 'selected' : '' }"/> >
									<c:out value="${item.brand_name }" />
								</option>
							</c:forEach>
							<!-- Here goes the sql foreach loop -->
						</select>
					</div>
					<div class="my-3">
						<label for="pname" class="form-label">Model name : </label>
						<c:if test="${ brand_id_option!=null }">
							<sql:query var="option" dataSource="${ db }">
								SELECT ID,MODEL_NAME FROM MOBILES WHERE BRAND_ID = ? GROUP BY BRAND_ID;
								<sql:param value="${ brand_id_option }"></sql:param>
							</sql:query>
							<select class="form-select" name="product_name" required>
								<c:forEach items="${ option.rows }" var="item">
									<option value="${ item.id }"><c:out
											value="${ item.model_name }"></c:out>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${ brand_id_option==null }">
							<input class="form-control" name="model_name" id="pname"
								type="text" placeholder="Enter the product name" disabled />
						</c:if>
					</div>
					<div class="my-3">
						<label for="qty" class="form-label">Qty : </label> <input
							class="form-control" name="qty" id="qty" type="number"
							placeholder="Enter the quantity" min="1" value="1" required />
					</div>
					<h5 class="mt-5 mb-4">Customer Details</h5>
					<div class="my-3">
						<label for="fname" class="form-label">First Name : </label> <input
							class="form-control" name="fname" placeholder="Eg. Jhon" required />
					</div>
					<div class="my-3">
						<label for="mname" class="form-label">Middle Name : </label> <input
							class="form-control" name="mname" placeholder="Eg. Jhon" required />
					</div>
					<div class="my-3">
						<label for="lname" class="form-label">Last Name : </label> <input
							class="form-control" name="lname" placeholder="Eg. Jhon" required />
					</div>
					<div class="my-3 d-flex align-items-center justify-content-between">
						<div class="mt-1 p-0">
							<label for="gender" class="form-label">Gender : </label>
						</div>
						<div
							class="m-0 px-5 d-flex align-items-center flex-grow-1 justify-content-start gap-5">
							<div class="form-check">
								<label class="form-check-label">Male</label> <input type="radio"
									class="form-check-input" name="gender" value="M" required />
							</div>
							<div class="form-check">
								<label class="form-check-label">Female</label> <input
									type="radio" class="form-check-input" name="gender" value="F" />
							</div>
						</div>
					</div>
					<div class="my-3">
						<label for="age" class="form-label">Age : </label> <input
							class="form-control" id="age" name="age" type="number"
							placeholder="Eg. 18" required />
					</div>
					<div class="my-3">
						<label for="contact_no" class="form-label">Contact No : </label> <input
							class="form-control" name="contact_no" placeholder="Eg. Jhon"
							required />
					</div>
					<div class="my-3">
						<label for="address" class="form-label">Address : </label>
						<textarea name="address" id="address" cols="30" rows="3"
							placeholder="Enter the address here" class="form-control"
							required></textarea>
					</div>
					<h5 class="mb-4 mt-5">Payment Mode</h5>
					<div
						class="m-0 p-0 d-flex justify-content-start align-items-center gap-5">
						<div class="form-check">
							<label class="form-check-label">CASH</label> <input
								class="form-check-input" name="pmode" value="1" type="radio"
								required />
						</div>
						<div class="form-check">
							<label class="form-check-label">Credit/Debit Card</label> <input
								class="form-check-input" name="pmode" value="2" type="radio"
								required />
						</div>
						<div class="form-check">
							<label class="form-check-label">Net Banking</label> <input
								class="form-check-input" name="pmode" value="3" type="radio"
								required />
						</div>
					</div>
					<div class="my-3">
						<button class="btn btn-primary ms-auto d-block">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<form action="addCustomer.jsp" class="d-none" method="POST"
		id="api_form">
		<input type="text" name="brand_id_option" id="hidden_text">
	</form>

	<c:if test="${ fname!=null && showError==null }">

		<sql:update var="result" dataSource="${db}">
     		INSERT INTO CUSTOMERS(BRAND_NAME,MOBILE_ID,QTY,FIRST_NAME,MIDDLE_NAME,LAST_NAME,ADDRESS,CONTACT_NO,PAYMENT_METHOD,GENDER,AGE)
     		VALUES (?,?,?,?,?,?,?,?,?,?,?);
     		<sql:param value='<%=request.getParameter("brand_name")%>'></sql:param>
			<sql:param value='<%=request.getParameter("product_name")%>'></sql:param>
			<sql:param value='<%=request.getParameter("qty")%>'></sql:param>
			<sql:param value='<%=request.getParameter("fname")%>'></sql:param>
			<sql:param value='<%=request.getParameter("mname")%>'></sql:param>
			<sql:param value='<%=request.getParameter("lname")%>'></sql:param>
			<sql:param value='<%=request.getParameter("address")%>'></sql:param>
			<sql:param value='<%=request.getParameter("contact_no")%>'></sql:param>
			<sql:param value='<%=request.getParameter("pmode")%>'></sql:param>
			<sql:param value='<%=request.getParameter("gender")%>'></sql:param>
			<sql:param value='<%=request.getParameter("age")%>'></sql:param>
		</sql:update>
		<c:redirect url="customers.jsp"></c:redirect>
	</c:if>
</body>
<script>
	let brand_name=document.getElementById('bname');
	let model_name=document.getElementById('pname');
	let api=document.getElementById('api_form');
	let hidden_text=document.getElementById('hidden_text');
	
	brand_name.addEventListener('change',(e)=>{
		e.preventDefault();
		hidden_text.value=e.target.value;
		console.log(e.target.value,hidden_text.value);
		api.submit();
	});
</script>
</html>