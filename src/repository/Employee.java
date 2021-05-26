package repository;

import java.io.Serializable;

public class Employee implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String lastName;
	
	public Employee(String name, String lastName) {
		this.name = name;
		this.lastName = lastName;
	}
	
	public String getName() {
		return name;
	}
	
	public String getLastName() {
		return lastName;
	}
}
