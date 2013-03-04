package errors
{
public class DivisionByZeroError extends Error
{
	public function DivisionByZeroError(message:*="", id:*=0)
	{
		super(message, id);
	}
}
}