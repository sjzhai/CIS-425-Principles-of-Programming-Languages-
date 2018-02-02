--Problem 4: The I/O Monad

import Data.Char

--a.
forever :: IO () -> IO ()
forever a = a >> forever a

--b.
repeatN :: Int -> IO () -> IO ()
repeatN 0 a = return (); repeatN n a = a >> repeatN (n-1) a

--c.
each :: [IO a] -> IO [a]
each [] = return []; each (a:as) = do x <- a; xs <- each as; return (x : xs)

--d.
--write function to strip symbols
sp [] = []; sp (x:xs) = if (isSpace x || isPunctuation x) then sp xs else toLower x : sp xs 

isPalindrome :: String -> Bool
isPalindrome s = if (sp s) == reverse (sp s) then True else False

main :: IO ()  --input then output
main = do putStrLn "Please enter a phrase:"; text <- getLine; if isPalindrome text == True then putStrLn "yes" else putStrLn "no"