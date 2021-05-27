package repository.aspects;

import java.io.PrintStream;
import java.util.HashMap;
import java.util.List;

import repository.Document;
import repository.Project;
import repository.Task;

public aspect FastProjectExporterAspect {
	
	public HashMap<String, String> projectsInfo;
	static String EOL = System.getProperty("line.separator");
	
	public FastProjectExporterAspect() {
		projectsInfo = new HashMap<>();
	}
	
	pointcut projectModification():
		execution(public Project.new(..))
		|| execution(* Project.add*(..))
		|| execution(* Project.update*(..))
		|| execution(* Project.delete*(..));
	
	pointcut projectExport():
		call(public void export(Project, PrintStream));
	
	after(): projectModification(){
		Project modifiedProject = (Project) thisJoinPoint.getTarget();
		String modifiedProjectName = modifiedProject.getName();
		projectsInfo.put(modifiedProjectName, null);
	}
		
	void around(): projectExport(){
		Project project = (Project) thisJoinPoint.getArgs()[0];
		String projectName = project.getName();
		PrintStream printStream = (PrintStream) thisJoinPoint.getArgs()[1];
		
		String exportedProjectInfo = projectsInfo.get(projectName);
		
		if(exportedProjectInfo == null) {
			printStream.println("--- Pierwsze wypisywanie projektu po modyfikacji ---");
			exportedProjectInfo = "Projekt: " + projectName + EOL;
			
			List<Task> tasks = project.getTaks();
			exportedProjectInfo += "Liczba zadañ: " + tasks.size() + EOL;
			for (Task task : tasks)
			{
				exportedProjectInfo += "Zadanie: " + task.getId() + EOL;
				exportedProjectInfo += "Opis: " + task.getDescription() + EOL;
				exportedProjectInfo += "Zg³aszaj¹cy: " + task.getReporter().getName() + " " + task.getReporter().getLastName() + EOL;
				exportedProjectInfo += "Przypisany: "  + task.getAssignee().getName() + " " + task.getAssignee().getLastName() + EOL;
				exportedProjectInfo += "Status: " + task.getStatus() + EOL;
			}
			
			List<Document> documents = project.getDocuments();
			exportedProjectInfo += "Liczba dokumentów: " + documents.size() + EOL;
			for (Document document : documents)
			{
				exportedProjectInfo += "Dokument: " + document.getName() + EOL;
			}
			
			projectsInfo.put(projectName, exportedProjectInfo);
		}else {
			printStream.println("--- Wypisywanie niezmienionego projektu ---");
		}
		
		printStream.println(exportedProjectInfo);
	}
}
