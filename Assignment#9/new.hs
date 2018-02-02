
data Comparison = Less | Equal | Greater
	deriving (Show, Eq)

class Comp a where
	(?=) :: a -> a -> Comparison
	
data CompD a = MakeCompD (a -> a -> Comparison)
	(?=) (MakeCompD comp) = comp

f :: CompD x -> CompD y -> Comparison
f x y = let
            xx = (length x, x)
            yy = (length y, y)
        in 
            ( xx ?= yy )


r = f "Hello" "World"
main = print(r)