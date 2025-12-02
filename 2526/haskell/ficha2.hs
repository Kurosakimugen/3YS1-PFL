{-
Write two definitions, one using conditional expressions and another using
guards for the function classify :: Int -> String that gives a qualititive
marks for a grade from 0 to 20 according to the following table.
≤ 9 "failed"
10–12 "passed"
13–15 "good"
16–18 "very good"
19–20 "excellent"

Usando expressões condicionais (if then else):

classify :: Int -> String
classify n = if n <= 9 then "Failed"
                else if n <= 12 then "Passed"
                else if n <= 15 then "Good"
                else if n <= 18 then "Very good"
                else if n <= 20 then "Excellent"
                else "Invalid grade"

Outra alternativa para expressões condicionais
classify :: Int -> String
classify n = if n <= 9 then "Failed" else if n <= 12 then "Passed" else if n <= 15 then "Good" else if n <= 18 then "Very good" else if n <= 20 then "Excellent" else "Invalid grade"

Usando guardas (|):
classify :: Int -> String
classify n                  Aqui é suposto ter apenas o nome da função e os argumentos apenas não pode ter o = de seguida
    | n <= 9  = "Failed"
    | n <= 12 = "Passed"
    | n <= 15 = "Good"
    | n <= 18 = "Very good"
    | n <= 20 = "Excellent"
    | otherwise = "Invalid grade"
-}

classify :: Int -> String
classify n
    | n <= 9  = "Failed"
    | n <= 12 = "Passed"
    | n <= 15 = "Good"
    | n <= 18 = "Very good"
    | n <= 20 = "Excellent"
    | otherwise = "Invalid grade"

{-
The body mass index (BMI) is a simple measure for classifying the weight of adult individuals.
The BMI is computed from the individual’s weight and height (in Kg and meters):
BMI = weight/height^2
For example: an individual with 70Kg and 1.70m height has a BMI of 70/1.702 ≈ 24.22. 
We can classify the result in the following intervals:
BMI < 18.5 "underweight"
18.5 ≤ BMI < 25 "normal weight"
25 ≤ BMI < 30 "overweight"
30 ≤ BMI "obese"
Write a definition of the functions classifyBMI :: Float -> Float -> String
to implement the above classification table. The two function arguments are,
respectively, the weight and height.

Usando guardas apenas têm que se adicionar && ao de antes para sinalizar que é esta condição e esta caso fosse || seria esta ou esta
-}

classifyBMI :: Float -> Float -> String
classifyBMI peso altura
    | bmi < 18.5               = "Underweight"
    | 18.5 <= bmi && bmi < 25  = "Normal weight"
    | 25 <= bmi && bmi < 30    = "Overweight"
    | 30 <= bmi                = "Obese"
    where bmi = peso / (altura * altura)

{-
Consider two definitions of the max e min from the standard Prelude:
max, min :: Ord a => a -> a -> a
max x y = if x>=y then x else y
min x y = if x<=y then x else y
(a) Write similar definitions for two functions max3 e min3 that compute the
maximum and minimum between three values.

min3 :: Ord a => a -> a -> a -> a
min3 x y z
    | x <= y && x <= z = x
    | y <= x && y <= z = y
    | z <= x && z <= y = z

max3 :: Ord a => a -> a -> a -> a
max3 x y z
    | x >= y && x >= z = x
    | y >= x && y >= z = y
    | z >= x && z >= y = z

(b) Observe that the maximum and minimum operations are associative: to
compute the maximum of three values we can compute the maximum
between two of them and then the maximum between the result and third
value. Re-write the function max3 and min3 using this idea and the Prelude
max e min functions.

As funções têm que estar o mais à esquerda possível de modo a que não haja muita necessidade de usar parentisis para clarificar a ordem das coisas

min3 :: Ord a => a -> a -> a -> a
min3 x y z = min ( min x y ) z

max3 :: Ord a => a -> a -> a -> a
max3 x y z = max ( max x y ) z
-}

min3 :: Ord a => a -> a -> a -> a
min3 x y z = min ( min x y ) z

max3 :: Ord a => a -> a -> a -> a
max3 x y z = max ( max x y ) z

{-
Write a definition of the exclusive or function
xor :: Bool -> Bool -> Bool
using multiple equations with patterns.
[Basicamente escrever todos os casos possíveis de resposta para algo]
-}

xor :: Bool -> Bool -> Bool
xor True False = True
xor False True = True
xor False False = False
xor True True = False

{-
We want to implement a safetail :: [a] -> [a] function that behaves like tail but gives the empty list when the argument is empty.
Write three distinct definitions using conditional expressions, guards and patterns.

Deve-se usar o let para casos onde sei que o padrão é aquele e o case para casos mais incertos sobre a resposta

Usando expressões condicionais:

safetail :: [a] -> [a]
safetail lista = if null lista then [] else let (_:cauda) = lista in cauda

Usando Guardas:

safetail :: [a] -> [a]
safetail lista
    | null lista    = []
    | otherwise     = let (_:cauda) = lista in cauda

Usando pattern matching:

safetail :: [a] -> [a]
safetail [] = []
safetail (_:cauda) = cauda
-}

safetail :: [a] -> [a]
safetail [] = []
safetail (_:cauda) = cauda

{-
Consider a function short :: [a] -> Bool that checks if a list has fewer than three elements.
(a) Write a definition of short using the length function.

Não é preciso fazer if then else, porque a expressão já retorna o bool necessário

short :: [a] -> Bool
short lista = length lista <= 3

(b) Write another definition using multiple equations and patterns.

Para este caso é preciso ser asbtrato na definção dos elementos internos e para além disso é preciso clarificar o resultado de quando não cumpre o objetivo de 3 elementos

short :: [a] -> Bool
short [] = True
short [_] = True
short [_,_] = True
short [_,_,_] = True
short _ = False
-}

short :: [a] -> Bool
short [] = True
short [_] = True
short [_,_] = True
short [_,_,_] = True
short _ = False

{-
The median of three values is the middle value when we place them in ascending order. For example: median 2 3 (-1) == 2.
(a) Write a definition of the median function that determines the median of any three values. 
What is its most general type? Note that we only need comparisons to determine the median.

O tipo mais geral é Ord a, uma vez que pode ser qualquer valor no entanto têm que ser possível de comparar de modo a se conseguir determinar a mediana

median :: Ord a => a -> a -> a -> a
median x y z
    | ( x <= y && x >= z) || ( x <= z && x >= y) = x
    | ( y <= x && y >= z) || ( y <= z && y >= x) = y
    | otherwise                                  = z

(b) Instead of defining the median using comparisons you could use the following idea: add all three values e subtract the largest and smallest values.
Re-define median this way. What the most general type for this new definition?

O tipo mais geral para este caso é Num Ord a, porque continua a ser necessário o Ord uma vez que é necessário saber qual o maior e o menor valor.
No entanto agora tem outra restrição que é o valor ser numérico uma vez que se aplica uma conta para se determinar esse valor.

median ::  (Ord a, Num a) => a -> a -> a -> a
median x y z = x + y + z - maximo - minimo
    where maximo = max3 x y z
          minimo = min3 x y z
-}

median :: Ord a => a -> a -> a -> a
median x y z
    | ( x <= y && x >= z) || ( x <= z && x >= y) = x
    | ( y <= x && y >= z) || ( y <= z && y >= x) = y
    | otherwise                                  = z

{-
Define a function propDivs :: Integer -> [Integer] using a list compreension that computes the list of proper divisors of a positive integer 
(d is a proper divisor of n is d divides n and d < n).
Example: propDivs 10 = [1, 2, 5].
-}

propDivs :: Integer -> [Integer]
propDivs numero = [divisor | divisor <- [1..numero-1], (mod numero divisor) == 0]

{-
A positive integer n is perfect if it equals the sum of it proper divisors.
Define a function perfects :: Integer -> [Integer] that computes the list of all perfect number up-to a limit given as argument.
Example: perfects 500 = [6,28,496].
Hint: use a list comprehension and together with the function defined in the previous exercise
-}

perfects :: Integer -> [Integer]
perfects numero = [perfeitos | perfeitos <- [1..numero] , sum (propDivs perfeitos) == perfeitos]

{-
A triple (x, y, z) of positive integers is pythagorical if x^2 + y^2 = z^2.
Define a function pyths :: Integer -> [(Integer,Integer,Integer)] that computes all pythogorical triples whose components are limited by the argument.
Example: pyths 10 = [(3,4,5), (4,3,5), (6,8,10), (8, 6, 10)].
-}

pyths :: Integer -> [(Integer,Integer,Integer)]
pyths numero = [(x,y,z) | x <- [1..numero], y <- [1..numero], z <- [(max x y)..numero], x*x + y*y == z*z]

{-
Define a function isPrime :: Integer -> Bool that tests primality: n is prime if it has exactly two divisors, namely, 1 and n.
Example: isPrime 17 = True, isPrime 21 = False.
Hint: use a list comprehension to get the list of divisors.
-}

isPrime :: Integer -> Bool
isPrime numero = length (propDivs numero) == 1

{-
Show that you can write alternative definitions of the Prelude functions concat, replicate and (!!) using just list compreehensions (not recursion).
Rename your functions to avoid clashes, e.g. myconcat, myreplicate, etc.
-}

myconcat :: [[a]] -> [a]
myconcat megalista = [ elemento | lista <- megalista, elemento <- lista]

myreplicate :: Int -> a -> [a]
myreplicate numero algo = [algo | i <- [1..numero]]

myindex :: [a] -> Int -> a
myindex lista numero = head [alvo | (alvo,indice) <- zip lista [0..], indice == numero]

-- 2.13 Último exercício

factorial :: Integer -> Integer
factorial n = product [1..n]

binom :: Integer -> Integer -> Integer
binom n k = div (factorial n) (factorial k * factorial sub)
    where sub = n - k

pascal :: Integer -> [[Integer]]
pascal n = [ [binom i k | k <- [0..i]] | i <- [0..n] ]