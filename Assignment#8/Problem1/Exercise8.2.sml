(*
8.2 Exceptions
Since the result of evaluating g(nil) is nil. The reason is that in the fun g(l), "hd(l)::tl(l)" is to return list head to tail which is whole list. Since hd(nil) and tl(nil) are both raise exception Hd and Tl when apply empty list nil. Therefore, hd(l)::tl(l) also raise the exception. In fun g(l), it cannot return whole list that it have to catch the exception by excecute handle Hd which apply to "nil". Therefore, the result should be nil.
To make the function g return properly without handling exception Tl. The parameter need to follow by dummy types (X1,X2,...) which is construct values of a list.
*) 