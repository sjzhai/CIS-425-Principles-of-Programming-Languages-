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
  | RES_FUN   of (string * term)
  | RES_CLOSURE of (string * term * env) and env = Env of (string * result) list;

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
fun interp_static (exp, env) = 

  case exp of
    AST_NUM  x                    => RES_NUM x
  | AST_BOOL b                    => RES_BOOL b
  | AST_SUCC                      => RES_SUCC
  | AST_PRED                      => RES_PRED
  | AST_ISZERO                    => RES_ISZERO
  | AST_IF (exp1, exp2, exp3)     => let val b = interp_static(exp1, env) 
                                     in if b = RES_BOOL(true)
                                        then interp_static (exp2, env)
                                        else if b = RES_BOOL(false)
                                        then interp_static (exp3, env)
                                        else RES_ERROR "Error: Not valid boolean value"
                                     end
  | AST_APP (exp1, exp2)          => let val v1 = interp_static(exp1, env)
                                         val v2 = interp_static(exp2, env)
                                     in case(v1, v2) of 
                                          (RES_SUCC, RES_NUM x) => RES_NUM(x+1)
                                        | (RES_PRED, RES_NUM x) => if x = 0
                                                                   then RES_NUM 0
                                                                   else RES_NUM (x-1)
                                        | (RES_ISZERO, RES_NUM x) => if x = 0
                                                                     then RES_BOOL(true)
                                                                     else RES_BOOL(false)
                                        | (RES_CLOSURE(var, exp, env_static), closure_list) => let val new_static_env = extend_env(env_static, var, closure_list) 
                                                                                               in interp_static(exp, new_static_env)
                                                                                               end
                                        | (RES_FUN(str, exp), list) => let val new_static_env = extend_env(env, str, list) 
                                                                       in interp(exp, new_static_env)
                                                                       end
                                        | (_, _) => RES_ERROR "Error: Not valid output"
                                     end
  | AST_ID name                   => lookup_env (env, name)
  | AST_FUN (var, ty, exp)        => RES_FUN (var, exp)
  | AST_LET (var, ty, exp1, exp2) => let val extEnv = extend_env (env, var, interp(exp1, env))
                                     in interp(exp2, extEnv)
                                     end
  | AST_REC (var, ty, exp)        => RES_ERROR "Not yet implemented"

