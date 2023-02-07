package com.mobile_store;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class Test extends HttpServlet{
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException{
		
		PrintWriter out=res.getWriter();
		out.println(req.getParameter("product_name"));
		out.println(req.getParameter("brand_name"));
		out.println(req.getParameter("ram"));
		out.println(req.getParameter("rom"));
	}
}
