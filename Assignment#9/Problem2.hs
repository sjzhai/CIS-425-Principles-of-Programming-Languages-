--Problem 2: Stream Equations

--a. 
evens = 0 : map (+2) evens
--evens = [0, 2 ..]

odds = 1 : map (+2) odds
--odds = [1, 3 ..]

--b. 
{merge [] [] = []; merge x [] = x; merge [] y = y; merge (x:xs) (y:ys) = concatMap (\(x,y) -> [x,y]) (zip (x:xs) (y:ys))}

--The call "merge evens odds" cannot be terminated. Because as we defined in part a, 
--the function evens and odds are both return the list of infinite even numbers and the 
--list of infinite odd numbers, when function merge implement those two functions, two lists can be merged but it cannot terminated.

--The call "length (merge evens odds)" cannot be terminated. Because both evens 
--and odds are return the infinite list. If merge two infinite list, the result 
--should be infinite list which the infinite list has no specific length.

--c.    
{merge [] [] = []; merge x [] = x; merge [] y = y; merge (x:xs) (y:ys) = concatMap (\(x,y) -> [x,y]) (zip (x:xs) (y:ys))}
--since we already define function evens, odds and merge--

 --i. 
  map (\x -> x*x*x) (merge evens odds)

 --ii. 
  timeThree = 1 : map (*3) timeThree

 --iii. 
 	merge (merge evens odds) (map (\x -> x * x) (merge evens odds))

 --iv. 
  drop 1 (map (\x -> (-1) * x) (merge evens odds))
  --[-1, -2 ..]