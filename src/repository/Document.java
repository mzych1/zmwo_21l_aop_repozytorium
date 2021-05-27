package repository;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Serializable;

public class Document implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String name;

	public Document(String name)
	{
		this.name = name;
	}

	public String getName()
	{
		return name;
	}

	public String getContent()
	{
		StringBuilder content = new StringBuilder();
		BufferedReader input = null;
		String line = null;
		
		// modyfikacje na potrzeby zadania 5
		input = new BufferedReader(new FileReader(name));
		while ((line = input.readLine()) != null)
		{
			content.append(line);
			content.append(System.getProperty("line.separator"));
		}
			if(input != null) {
				input.close();
			}		
		return content.toString();
	}
	
	public void setContent(String content) {
		BufferedWriter output = null;
		try
		{
			output = new BufferedWriter(new FileWriter(name));
			output.write(content);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		finally {
			try
			{
				if(output != null) {
					output.close();
				}
			}
			catch (IOException e)
			{
				e.printStackTrace();
			}
		}
	}
}
