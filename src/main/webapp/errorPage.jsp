<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  </head>
  <body class="bg-dark bg-gradient d-flex flex-column justify-content-center align-items-center" style="height:100vh">
    <h1 class="text-white p-0 m-0">
    	<c:if test="<%= response.getStatus()==500 %>">
    		500 | Internal Server Error
    	</c:if>
    	<c:if test="<%= response.getStatus()==404 %>">
    		404 | Page Not Found
    	</c:if>
    	<c:if test="<%= response.getStatus()!=404 && response.getStatus()!=500 %>">
    		<%= response.getStatus() %> | Something Went Wrong
    	</c:if>
    </h1>
    <a class="btn btn-light my-5" href="dashboard.jsp" style="width:10rem">Home</a>
  </body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</html>