package com.lumiere.project.enums;

public enum EnumsLumiere {
	
	ADMIN("admin"),
	USER("user");
	
	private String role;
	
	private EnumsLumiere (String role) {this.role = role;}

	public String getRole() {
		return role;
	}
	
	

}
