package com.mobile_store;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class Mobile implements Serializable{
	private String product_name,
	brand_name,
	ram,rom,
	internal_memory,
	external_memory,
	screen_size,
	network_type,
	rear_camera,
	front_camera,
	sim_tray,
	price,
	qauntity;
	
	public String getQauntity() {
		return qauntity;
	}


	public void setQauntity(String qauntity) {
		this.qauntity = qauntity;
	}


	public void sendMobileData(Mobile mobile) {	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mobile_store","root"
					,"kirtan2004khatri");
			String query="INSERT INTO MOBILES(model_name,brand_id,ram_id,rom_id,im_id,em_id,screen_id,network_id,front_id,rear_id,sim_id,price,quantity) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,mobile.getProduct_name());
			ps.setInt(2,Integer.parseInt(mobile.getBrand_name()));
			ps.setInt(3,Integer.parseInt(mobile.getRam()));
			ps.setInt(4,Integer.parseInt(mobile.getRom()));
			ps.setInt(5,Integer.parseInt(mobile.getInternal_memory()));
			ps.setInt(6,Integer.parseInt(mobile.getExternal_memory()));
			ps.setInt(7,Integer.parseInt(mobile.getScreen_size()));
			ps.setInt(8,Integer.parseInt(mobile.getNetwork_type()));
			ps.setInt(9,Integer.parseInt(mobile.getFront_camera()));
			ps.setInt(10,Integer.parseInt(mobile.getRear_camera()));
			ps.setInt(11,Integer.parseInt(mobile.getSim_tray()));
			ps.setInt(12,Integer.parseInt(mobile.getPrice()));
			ps.setInt(13,Integer.parseInt(mobile.getQauntity()));
			
			ps.executeUpdate();
			System.out.println("---------------- inserted");
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

	public String getRam() {
		return ram;
	}

	public void setRam(String ram) {
		this.ram = ram;
	}

	public String getRom() {
		return rom;
	}

	public void setRom(String rom) {
		this.rom = rom;
	}

	public String getInternal_memory() {
		return internal_memory;
	}

	public void setInternal_memory(String internal_memory) {
		this.internal_memory = internal_memory;
	}

	public String getExternal_memory() {
		return external_memory;
	}

	public void setExternal_memory(String external_memory) {
		this.external_memory = external_memory;
	}

	public String getScreen_size() {
		return screen_size;
	}

	public void setScreen_size(String screen_size) {
		this.screen_size = screen_size;
	}

	public String getNetwork_type() {
		return network_type;
	}

	public void setNetwork_type(String network_type) {
		this.network_type = network_type;
	}

	public String getRear_camera() {
		return rear_camera;
	}

	public void setRear_camera(String rear_camera) {
		this.rear_camera = rear_camera;
	}

	public String getFront_camera() {
		return front_camera;
	}

	public void setFront_camera(String front_camera) {
		this.front_camera = front_camera;
	}

	public String getSim_tray() {
		return sim_tray;
	}

	public void setSim_tray(String sim_tray) {
		this.sim_tray = sim_tray;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

}
