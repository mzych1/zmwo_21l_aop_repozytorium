package repository;

import java.io.Serializable;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

public class Project implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private String name;
	private HashMap<Integer, Task> tasks;
	private HashMap<String, Document> documents;
	
	public Project(final String name) {
		this.name = name;
		this.tasks = new HashMap<Integer, Task>();
		this.documents = new HashMap<String, Document>();
	}
	
	public String getName() {
		return name;
	}
	
	public List<Task> getTaks() {
		return new LinkedList<Task>(tasks.values());
	}
	
	public Task getTask(Integer taskId) {
		return tasks.get(taskId);
	}
	
	public void addTask(Task task) {
		tasks.put(task.getId(), task);
	}
	
	public void updateTask(Task task) {
		tasks.put(task.getId(), task);
	}
	
	public void deleteTask(Task task) {
		tasks.remove(task.getId());
	}
	
	public List<Document> getDocuments() {
		return new LinkedList<Document>(documents.values());
	}

	public Document getDocument(String name) {
		return documents.get(name);
	}
	
	public void addDocument(Document document) {
		documents.put(document.getName(), document);
	}
	
	public void updateDocument(Document document) {
		documents.put(document.getName(), document);
	}
	
	public void deleteDocument(Document document) {
		documents.remove(document.getName());
	}
	
}
