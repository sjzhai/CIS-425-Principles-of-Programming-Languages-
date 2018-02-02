(*
dang-interp.sml
A solution to Exercise 10 in Friedman's "Applications of Continuations"
*)

structure K = SMLofNJ.Cont
(* use continuation like this:  K.callcc, K.throw, etc. *)
(* alternatively you may open the package *)

datatype bop = PLUS | MINUS | MULT | DIV

datatype exp = 
    Num of int 
|   Bin of exp * bop * exp
|   Lett of string * exp * exp 
|   Var of string 
|   Lambda of string * exp
|   Apply of exp * exp
|   Devil of exp
|   Angel of exp 
|   Milestone of exp

datatype value = 
    Integer of int
|   Closure of string * exp * env
withtype env = (string * value) list

exception VarNotDeclared of string
exception DivideByZero
exception Generic of string

val empty : env = []

fun extend (x:string) (v:value) (e:env) = (x,v) :: e

fun lookup (x:string) (e:env) = 
    case e of 
        [] => raise VarNotDeclared (x)
    |   ((y,v) :: e') => if x = y then v else lookup x e'

fun run (e:exp) = 
    let
        val miles = ref []
        val devils = ref []
        fun interp (e:exp) (env:env) = 
            case e of
                Var (x) => lookup x env
            |   Num (i) => Integer (i)
            |   Bin (e1, bop, e2) => 
                    let
                        val (Integer v1) = interp e1 env 
                        val (Integer v2) = interp e2 env 
                    in
                        case bop of
                            PLUS   => Integer (v1 + v2)
                        |   MINUS  => Integer (v1 - v2)
                        |   MULT   => Integer (v1 * v2)
                        |   DIV    =>
                                if v2 = 0 then
                                    raise DivideByZero
                                else
                                    Integer (v1 div v2)
                    end
            |   Lett (x, init, body) => 
                    interp body (extend x (interp init env) env) 
            |   Lambda (x, body) =>
                    Closure (x, body, env)
            |   Apply (f, arg) =>
                    let
                        val (Closure (x, body, e)) = interp f env 
                        val v = interp arg env 
                    in 
                        interp body (extend x v e) 
                    end
            |   Milestone (e') => 
                    K.callcc(fn m => ((miles := m::(!miles));
                                      interp e' env))
            |   Devil (e') => 
                    let val con = interp e' env
                    in
                      case (!miles) of
                            [] => interp e' env
                        |xn::xs => K.callcc( fn e =>( devils:= e::(!devils);
                                                      miles := xs;
                                                      K.throw xn con ))
                    end
            |   Angel (e') =>
                    let val con = interp e' env
                    in
                      case (!devils) of
                            [] => interp e' env
                        |xn::xs => K.callcc( fn e =>( devils := xs;
                                                      K.throw xn con ))
                    end
    in
        interp e empty
    end


(* Top level *)

(*******************************************************************
let val a = 5
    val b = 6
in
    a + Milestone(b * (Devil(0) div 0))
end
*)

(*  Should return 5 *)

val E1 =
  Lett("a", Num(5),
  Lett("b", Num(6),
    Bin(
      Var("a"),
      PLUS, 
      Milestone(
        Bin(
          Var("b"),
          MULT,
          Bin(
            Devil(Num(0)),
            DIV,
            Num(0)))))));

(******************************************************************
Milestone(40 + Devil(0)) + Angel(2);
*)

(*  Should return 42 *)

val E2 =
  Bin(
    Milestone(
      Bin(
        Num(38),
        PLUS,
        Devil(Num(0)))), 
    PLUS,
    Angel(Num(2)));

(******************************************************************
let fun MakeAdd n => (fn x => x + n)
    fun MakeDiv n => (fn x => x div (Devil n) )
in
    (MakeAdd 15) ((3 * (Milestone ((MakeDiv 0) 18))) + (Angel 2))
end
*)

(* Should return 42 *)

val E3 =
  Lett("MakeAdd", 
    Lambda("n",
      Lambda("x",
        Bin(
          Var("x"),
          PLUS,
          Var("n")))),
  Lett("MakeDiv",
    Lambda("n",
      Lambda("x",
        Bin(
          Var("x"),
          DIV,
          Devil(Var("n"))))),
  Apply(
    Apply(
      Var("MakeAdd"),
      Num(13)),
    Bin(
      Bin(
        Num(3), 
        MULT, 
        Milestone(
          Apply(
            Apply(
              Var("MakeDiv"),
              Num(0)),
            Num(18)))),
      PLUS, 
      Angel(Num(2))))));

