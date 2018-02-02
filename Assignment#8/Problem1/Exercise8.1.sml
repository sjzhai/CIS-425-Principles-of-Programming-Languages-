(*
8.1 Exceptions
(a) 0
    "twice(pred,1);" in fun twice(f, x), it handle Excpt(x) and x = 1. plug x = 1 into pred(pred(1)), pred(1) will not raise exception and return 0, then pred(1)=0 => pred(0), here the fun pred(x) raised Excpt(x), x = 0.
(b) 1
    "twice(dumb,1);" in fun twice(f, x), it handle Excpt(x) and x = 1. Then plug x = 1 into dumb(dumb(1)), dumb(1) raised Excpt(x), x = 1. And dumb(1) raised Excpt(x), x = 1 again. Finally function return 1.
(c) 1
    "twice(smart,0);" in fun smart(x) it processing handle Excpt(x) which x = 1, plug x = 1 into fun pred(x) it does not raised exception and return 1-1 = 0. Then the fun smart(x) return 1+0 = 1. In fun twice(f, x), it called smart(smart(x)) => smart(1) and it gets no exception then return 1.
*)