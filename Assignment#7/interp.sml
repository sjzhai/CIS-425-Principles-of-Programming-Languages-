(*  Here's a skeleton file to help you get started on Interpreter 1.
 * Original version by Geoffrey Smith - http://users.cs.fiu.edu/~smithg/
 *)

use "type.sml";

(* Here is a result datatype *)
datatype result =
    RES_ERROR of string
  | RES_NUM   of int
  | RES_BOOL  of bool
  | RES_SUCC
  | RES_PRED
  | RES_ISZERO
  | RES_FUN   of (string * term);

(* Here is a basic environment implementation *)
exception not_found;
datatype env = Env of (string * result) list

fun new_env() = Env(nil);
fun extend_env (Env(oldenv), id, value) = Env( (id, value):: oldenv);
fun lookup_env (Env(nil), id) = (print("Free Var!! "^id); raise not_found)
   |lookup_env (Env((id1,value1)::b), id) =  
        if (id1 = id) 
        then value1
	    else lookup_env(Env(b), id) ;

(*  Here's a partial skeleton of interp : (term * env) -> result.
    I've done the first case for you
*)
fun interp (exp, env) = 

  case exp of
    AST_NUM  x                    => RES_ERROR "Not yet implemented"
  | AST_BOOL b                    => RES_ERROR "Not yet implemented"
  | AST_SUCC                      => RES_ERROR "Not yet implemented"
  | AST_PRED                      => RES_ERROR "Not yet implemented"
  | AST_ISZERO                    => RES_ERROR "Not yet implemented"
  | AST_IF (exp1, exp2, exp3)     => RES_ERROR "Not yet implemented"
  | AST_APP (exp1, exp2)          => RES_ERROR "Not yet implemented"
  | AST_ID name                   => RES_ERROR "Not yet implemented"
  | AST_FUN (var, ty, exp)        => RES_ERROR "Not yet implemented"
  | AST_LET (var, ty, exp1, exp2) => RES_ERROR "Not yet implemented"
  | AST_REC (var, ty, exp)        => (* You don't need to implement this *)
                                     RES_ERROR "Not yet implemented"

(*  Once you have defined interp, you can try out simple examples by
      interp (parsestr "succ (succ 7)"), new_env());
    and you can try out larger examples by
      interp (parsefile "your-file-here", new_env());
*)
