(*
8.4 Exceptions and Recursion
When f(11) is executed, the following steps will be performed:
	call f(11) 
	call f(9) 
	call f(7)

The remaining steps:
	call f(5)
	call f(3)
	call f(1)
	raise exception Odd
	pop activation record of function off stack
	handle an exception Odd
	return ~5
*)