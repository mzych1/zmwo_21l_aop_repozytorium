package repository.aspects;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Scanner;

import repository.*;

public aspect UserLoginAspect {
	private boolean isUserLogged = false;
	private HashMap<String, String> users;
	
	public UserLoginAspect() {
		users = new HashMap<>();
		try {
			FileInputStream fileInputStream = new FileInputStream("users.txt");       
			Scanner scanner = new Scanner(fileInputStream);
			while(scanner.hasNextLine()) {  
				String login = scanner.nextLine();
				String password = scanner.nextLine();
				users.put(login, password);
			}  
			scanner.close();
		} catch(IOException e) {  
			e.printStackTrace();  
		}
	}

	pointcut modification():
		execution(public void repository.Repository.addProject(Project))
		|| execution(public void repository.Repository.updateProject(Project))
		|| execution(public void repository.Repository.deleteProject(Project));
	
	before(): modification(){
		Scanner in = new Scanner(System.in);
		while(!isUserLogged) {
			System.out.println("Operacja wymaga zalogowania");
			System.out.println("Nazwa u¿ytkownika: ");
			String login = in.nextLine();
			System.out.println("Has³o: ");
			String password = in.nextLine();
			String correctPassword = users.get(login);
			if(password != null && password.equals(correctPassword)) {
				isUserLogged = true;
				System.out.println("Zalogowano");
			}else {
				System.out.println("Podano niepoprawn¹ nazwê u¿ytkownika lub has³o");
			}
		}
		in.close();
	}
}
