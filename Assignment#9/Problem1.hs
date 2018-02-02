--Problem 1: Lazy Lists Revisited

--a. 
ones = 1 : ones
--ones = [1,1 ..]

--b. 
intList n = n : intList (n+1)

--c. 
takeN n (x:y) = if n == 0 then [] else x : takeN (n-1) y
