package repository;

import java.io.Serializable;

public class Task implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	enum Status {NEW, IN_PROGRESS, FINISHED};
	
	private Integer id;
	private String description;
	private Employee assignee;
	private Employee reporter;
	private Status status;
	
	public Task(final Integer id, String description, final Employee assignee, final Employee reporter) {
		this.id = id;
		this.assignee = assignee;
		this.reporter = reporter;
		this.description = description;
		this.status = Status.NEW;
	}

	public Employee getAssignee() {
		return assignee;
	}
	
	public void setAssignee(Employee assignee) {
		this.assignee = assignee;
	}
	
	public Employee getReporter() {
		return reporter;
	}
	
	public void setReporter(Employee reporter) {
		this.reporter = reporter;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public Integer getId() {
		return id;
	}
	
	public Status getStatus() {
		return status;
	}
	
	public void startProgress() {
		status = Status.IN_PROGRESS;
	}
	
	public void finish() {
		status = Status.FINISHED;
	}
}
