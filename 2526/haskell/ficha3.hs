{-
Write your own recursive definitions for the following Prelude functions.
Use different names in order to avoid clashes, e.g. define a function myand instead of and.
-}

-- (a) and :: [Bool] -> Bool — test if all values are true;
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (h:rs) = if h == True then myAnd rs else False

-- (b) or :: [Bool] -> Bool — test if some value is true;
myOr :: [Bool] -> Bool
myOr [] = False
myOr (h:rs) = if h == False then myOr rs else True

-- (c) concat :: [[a]] -> [a] — concatenate a list of lists;
myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (h:rs) = case h of
    [] -> myConcat rs
    (h1:rs1) -> h1 : myConcat(rs1:rs)

-- (d) replicate :: Int -> a -> [a] — produce a list with repetead values;
myReplicate :: Int -> a -> [a]
myReplicate 0 h = [h]
myReplicate num h = h : myReplicate (num-1) h

-- (e) (!!) :: [a] -> Int -> a — index the n-th value in a list (starting from zero);
myIndex :: [a] -> Int -> a 
myIndex lista 0 = head lista 
myIndex (h:rs) num
    | num == 0 = h
    | otherwise = myIndex rs (num-1)

-- (f) elem :: Eq a => a -> [a] -> Bool — check if a value occurs in a list.
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem target (h:rs)
    | target == h = True
    | otherwise = myElem target rs

{-
In this exercise we want to implement a prime number test that is more efficient than the one in Worksheet 2.
(a) Write a function leastDiv :: Integer -> Integer that computes the smallest divisor greater than 1 of a given number.
We need only try candidate divisors d, i.e. numbers d such that n = d × k. 
However, if d ≥ √n, then k ≤ √n is also a divisor. 
Hence the smallest divisor will always be less than or equal to √n.
-}

leastDiv :: Integer -> Integer
leastDiv num = findDivFrom 2
    where
        findDivFrom d
            | d * d > num     = num
            | mod num d == 0  = d
            | otherwise       = findDivFrom d+1

{-
(b) Use leastDiv to define a function isPrimeFast :: Integer -> Bool
that checks primality: n is prime if n > 1 and the least divisor of n is n
itself.
Test that the fast version gives the same results as the original slow one
with some examples, e.g. numbers from 1 to 10.
-}
isPrimeFast :: Integer -> Bool
isPrimeFast num
    | num < 1   = False
    | otherwise = leastDiv num == num 