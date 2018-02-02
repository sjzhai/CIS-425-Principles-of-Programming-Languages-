(*
8.5 Tail Recursion and Exception Handling
We cannot use tail recursion elimination to optimize the program.
Because in the function, "f(1, count) = raise OddNum" will run first when there emerge odd number and the function cannot run the rest code which handle OddNum exception and it cannot get the correct value of decremention that we cannot use tail recursion. 

And it might be resolved in this way:
	exception OddNum;
	let fun f(0,count) = count
		| f(1, count) = -1
		| f(x, count) = f(x-2, count+1)
*)