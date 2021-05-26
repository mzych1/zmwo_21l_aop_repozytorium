package repository.aspects;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import repository.*;

public aspect SaveRepositoryAspect {
	declare parents: Repository implements Serializable;
	
	pointcut creation():
		execution(public Repository.new())
		&& !within(SaveRepositoryAspect);

	pointcut modification():
		execution(public void repository.Repository.addProject(Project))
		|| execution(public void repository.Repository.updateProject(Project))
		|| execution(public void repository.Repository.deleteProject(Project));
	
	after(): modification(){
		Repository repo = (Repository) thisJoinPoint.getTarget();
		try (ObjectOutputStream outputStream = new ObjectOutputStream(
				new FileOutputStream("serialized_repository.bin"))) {
		    outputStream.writeObject(repo);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	Object around(): creation(){
		Repository repo = null;
		try (ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream("serialized_repository.bin"))) {
			repo = (Repository) inputStream.readObject();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return repo;
	}
}
