package repository;

import java.io.Serializable;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;


public class Repository implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	public HashMap<String, Project> projects;

	public Repository() {
		this.projects = new HashMap<String, Project>();
	}
	
	public List<Project> getProjects() {
		return new LinkedList<Project>(projects.values());
	}
	
	public Project getProject(String name) {
		return projects.get(name);
	}
	
	public void addProject(Project project) {
		projects.put(project.getName(), project);
	}
	
	public void updateProject(Project project) {
		projects.put(project.getName(), project);
	}
	
	public void deleteProject(Project project) {
		projects.remove(project.getName());
	}
}
