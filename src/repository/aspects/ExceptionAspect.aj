package repository.aspects;

import java.io.IOException;

public aspect ExceptionAspect {
	declare soft :IOException: execution(public String repository.Document.getContent());
}
