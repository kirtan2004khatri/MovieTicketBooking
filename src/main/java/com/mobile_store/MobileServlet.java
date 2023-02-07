package com.mobile_store;

import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

//@MultipartConfig(maxFileSize = 16177215) 

public class MobileServlet extends HttpServlet{
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException{
//		HttpSession session = req.getSession();
//		String updt=session.getAttribute("update").toString();
//		Part img1=req.getPart("image1");
//		Part img2=req.getPart("image2");
//		Part img3=req.getPart("image3");
		String product_name,brand_name,ram,rom,front_camera,rear_camera,
		network_type,internal_memory,external_memory,sim_tray,screen_size,price,quantity;
//		InputStream image1=null;
//		InputStream image2=null;
//		InputStream image3=null;
//		if(img1!=null) {
//			image1=img1.getInputStream();
//		}
//		if(img2!=null) {
//			image2=img2.getInputStream();
//		}
//		if(img3!=null) {
//			image3=img1.getInputStream();
//		}
		System.out.println(req.getParameter("product_name"));
		product_name=req.getParameter("product_name");
		brand_name=req.getParameter("brand_name");
		ram=req.getParameter("ram");
		rom=req.getParameter("rom");
		front_camera=req.getParameter("front_camera");
		rear_camera=req.getParameter("rear_camera");
		network_type=req.getParameter("network_type");
		internal_memory=req.getParameter("internal_memory");
		external_memory=req.getParameter("external_memory");
		sim_tray=req.getParameter("sim_tray");
		screen_size=req.getParameter("screen_size");
		price=req.getParameter("price");
		quantity=req.getParameter("qty");
		
//		System.out.println(product_name);
//		System.out.println(brand_name);
//		System.out.println(ram);
//		System.out.println(rom);
//		System.out.println(front_camera);
//		System.out.println(rear_camera);
//		System.out.println(network_type);
//		System.out.println(internal_memory);
//		System.out.println(external_memory);
//		System.out.println(sim_tray);
//		System.out.println(screen_size);
//		System.out.println(price);
//		System.out.println(quantity);
//		url1=img1.getSubmittedFileName().toString();
//		url2=img2.getSubmittedFileName().toString();
//		url3=img3.getSubmittedFileName().toString();
		
				
		Mobile mobile=new Mobile();
		mobile.setBrand_name(brand_name);
		mobile.setProduct_name(product_name);
		mobile.setRam(ram);
		mobile.setRom(rom);
		mobile.setRear_camera(rear_camera);
		mobile.setFront_camera(front_camera);
		mobile.setNetwork_type(network_type);
		mobile.setInternal_memory(internal_memory);
		mobile.setExternal_memory(external_memory);
		mobile.setSim_tray(sim_tray);
		mobile.setScreen_size(screen_size);
		mobile.setPrice(price);
		mobile.setQauntity(quantity);
		mobile.sendMobileData(mobile);			
		res.sendRedirect("mobiles.jsp");
	}
}
