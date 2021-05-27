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
		call(public Repository.new())
		&& !within(SaveRepositoryAspect);

	pointcut modification():
		execution(public void repository.Repository.addProject(Project))
		|| execution(public void repository.Repository.updateProject(Project))
		|| execution(public void repository.Repository.deleteProject(Project));
	
	after(): modification(){
		Repository repo = (Repository) thisJoinPoint.getTarget();
		try {
		    FileOutputStream fileOutputStream = new FileOutputStream("serialized_repository.bin");
		    ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
		    objectOutputStream.writeObject(repo);
		    objectOutputStream.close();
		    fileOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	Object around(): creation(){
		Repository repo = null;
		try {
			FileInputStream fileInputStream = new FileInputStream("serialized_repository.bin");
		    ObjectInputStream objectInputStream = new ObjectInputStream(fileInputStream);
		    repo = (Repository) objectInputStream.readObject();
		    objectInputStream.close();
		    fileInputStream.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return (Repository)repo;
	}
}
