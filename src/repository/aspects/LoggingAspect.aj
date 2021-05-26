package repository.aspects;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import org.aspectj.lang.reflect.CodeSignature;

public aspect LoggingAspect {
	
	private FileWriter file = null;
	String separator = "; ";
	
	pointcut logging():
		execution(* *.*( .. )) && within(repository.*);
	
		Object around(): logging(){	

			// klasa obiektu, na rzecz którego zosta³a wykonana metoda
			String line = "Klasa: " + thisJoinPoint.getSignature().getDeclaringType().toString() + separator; 
			line += "Metoda: " + thisJoinPoint.getSignature().getName() + separator; // nazwa metody
			
		    long startTime = Calendar.getInstance().getTimeInMillis();
			Object ret = proceed();
			long endTime = Calendar.getInstance().getTimeInMillis();
			long executionTime = endTime - startTime;
			
			line += "Zwrócony wynik: " + ret + separator; // wynik zwracany przez metodê
			line += "Czas wykonania [ms]: " + executionTime + separator; // czas wykonania metody


			CodeSignature sig = (CodeSignature) thisJoinPoint.getSignature();
			String [] parameterNames = sig.getParameterNames();
			line += "Argumenty: ";
			if(parameterNames.length == 0) {
				line += "Brak";
			} else {
				int i = 0;
		        for (Object arg : thisJoinPoint.getArgs()) {
		        	line += (i + 1) + ". ";
		        	line += "Typ: " + arg.getClass() + ", "; // typ argumentu
		        	line += "Nazwa: " + parameterNames[i] + ", "; // nazwa argumentu
		        	line += "Wartoœæ: " + arg + separator; // wartosc argumentu
		        	++i;
		        }
			}
			
			writeToFile(line);
			return ret;
		}
		
		private void writeToFile(String text) {
			try {
				if(file == null) {
					file = new FileWriter("log.txt");
				}
				
				file.write(text);
				file.write(System.getProperty("line.separator"));
				file.flush();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
}
