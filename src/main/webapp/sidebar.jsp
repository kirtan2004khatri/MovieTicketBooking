<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&family=Poppins:wght@500&family=Roboto:wght@500&family=Rubik:wght@500&display=swap"
	rel="stylesheet">
<title>Dashboard</title>
<style>
* {
	/* font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; */
	font-family: 'Montserrat', sans-serif;
}

#sidebar {
	background: linear-gradient(45deg, black, rgb(49, 49, 49));
	/* background:linear-gradient(135deg,#2EB62C,#57C84D); */
	/* background-color:#17B169; */
}

.sidebar-items {
	color: white;
	cursor: pointer;
	text-decoration: none;
	font-size: 1.3vw;
	outline: 0px;
}

.sidebar-items:hover {
	background-color: white;
	color: black;
	transition: 0.2s;
}

#anchor {
	text-decoration: none;
}

::-webkit-scrollbar-track
{
	-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
	border-radius: 10px;
	background-color: #F5F5F5;
}

::-webkit-scrollbar
{
	width: 12px;
	background-color: #F5F5F5;
}

::-webkit-scrollbar-thumb
{
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
	background-color: #555;
}
</style>
</head>
<body>
	<div class="m-0 p-0 d-flex" style="height: 100vh; width: 100%">
		<div class="row g-0 w-100">
			<div class="col-lg-2 col-md-1 d-none d-md-block d-lg-block"
				id="sidebar">
				<div class="logo text-center text-white pt-4 pb-3"
					style="font-size: 2vw">KING</div>
				<div class="m-0 p-0 pt-4">
					<div
						class="sidebar-items fs-5 d-flex align-items-center justify-content-lg-start justify-content-center">
						<a href="dashboard.jsp"
							class="d-flex p-3 gap-4 sidebar-items w-100 justify-content-center justify-content-lg-start">
							<i class="bi bi-grid-fill"></i> <span class="d-lg-block d-none">Dashboard</span>
						</a>
					</div>

					<div
						class="sidebar-items fs-5 d-flex align-items-center justify-content-lg-start justify-content-center">
						<a href="brands.jsp"
							class="d-flex p-3 gap-4 sidebar-items w-100 justify-content-center justify-content-lg-start">
							<i class="bi bi-tags-fill "></i> <span class="d-lg-block d-none">Brands</span>
						</a>
					</div>

					<div
						class="sidebar-items fs-5 d-flex align-items-center justify-content-lg-start justify-content-center">
						<a href="mobiles.jsp"
							class="d-flex p-3 gap-4 sidebar-items w-100 justify-content-center justify-content-lg-start">
							<i class="bi bi-phone-fill	 "></i> <span
							class="d-lg-block d-none">Mobiles</span>
						</a>
					</div>

					<div
						class="sidebar-items fs-5 d-flex align-items-center justify-content-lg-start justify-content-center">
						<a href="customers.jsp"
							class="d-flex p-3 gap-4 sidebar-items w-100 justify-content-center justify-content-lg-start">
							<i class="bi bi-person-fill "></i> <span
							class="d-lg-block d-none">Customer</span>
						</a>
					</div>
					
					<div
						class="sidebar-items fs-5 d-flex align-items-center justify-content-lg-start justify-content-center">
						<a href="sales.jsp"
							class="d-flex p-3 gap-4 sidebar-items w-100 justify-content-center justify-content-lg-start">
							<i class="bi bi-coin "></i> <span
							class="d-lg-block d-none">Sales</span>
						</a>
					</div>

				</div>
			</div>
			<!-- <div class="container-fluid border border border-5"></div> -->
</body>
<script src="./bootstrap/js/bootstrap.min.js"></script>
</html>