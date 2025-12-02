-- Função que aumenta em 1 o valor atribuido
incr :: Int -> Int
incr x = x+1

-- Função que triplica o valor atribuido
triple :: Int -> Int
triple x = 3*x

-- Função que dá print ao texo Olá alguem com base no nome dado
welcome :: String -> String
welcome name = "Hello, " ++ name ++ "!"

-- Função que conta quantos caracters tem a string, incluindo espaço e outros simbolos
count :: String -> String
count str = show (length str) ++ " characters."

{-
incr (triple 3)
Resultado = 10, indicando que os parentisis dão prioridade

triple (incr (3+1))
Resultado = 15
Garante que a adição é adicionada antes de aplicar a função

triple (incr 3 + 1)
Resultado = 15
A ausencia dos parentises não permite que a soma seja calculada antes de aplicar a função

triple (incr 3) + 1
Resultado = 13
As funções têm maior precedência que operações binárias logo ao colocar a soma fora dos parentises e perde qualquer tipo de prioridade sendo apenas calculado no fim

welcome "Harry" ++ welcome "Potter"
Resultado = "Hello, Harry!Hello, Potter!"
Mostra que não existe espaço no final de cada Hello e que para além disso assum que o nome atribuido não é para a mesma pessoa

welcome ("Harry" ++ " Potter")
Resultado = "Hello, Harry Potter!"
Uma maneira de resolver é colocar o nome todo na string ou então concatenar as duas strings para que apenas um hello seja usado

welcome (welcome "Potter")
Resultado = "Hello, Hello, Potter!!"
Neste caso a segunda frase é criada dentro da primeira logo está em volta por completo da primeira ficando assim com dois hello no incio e acabando com dois !

count "Expelliarmus!"
Resultado = "13 characters."
São registado 13 uma vez que o ! também é considerado na contagem

count (count "Expelliarmus!")
Resultado = "14 characters."
Neste segundo caso ele conta o resultado impresso anteriormente e assim mostra que tambem conta os espaços logo o resultado será 14 em vez de 13
-}

-- Função que calcula a metade da esquerda de uma lista
leftHalf :: [Int] -> [Int]
leftHalf x = take (div (length x) 2) x 

-- Função que calcula a metade da direita de uma lista
rightHalf :: [Int] -> [Int]
rightHalf x = drop (div (length x) 2) x
-- Quando a lista é vazia o resultado é lista vazia em ambos os casos, no entanto quando apenas possui um elemento, o resultado dá vazio para a esquerda no entanto para a direita dá o elemento único

-- Função que pega o segundo elemento de uma lista
second :: [Int] -> Int
second x = x !! 1
-- Quando a lista tem menos que dois elementos dá erro 

-- Função que obtem o ultimo elemento de uma lista
lastElement :: [Int] -> Int
lastElement x = head (drop ( (length x) - 1) x)
{- 
head (reverse x)
head (drop ( (length x) - 1) x)
-}

-- Função que remove o ultimo elemento da lista
initE :: [Int] -> [Int]
initE x = reverse ( drop 1 ( reverse x ) )
{-
take ( (length x) - 1) x 
reverse ( drop 1 ( reverse x ) )
-}

-- Função que obtem 1 ou dois elementos do meio da lista com base no comprimento da lista ser par ou impar
middle :: [Int] -> [Int]
middle x = if mod (length x) 2 == 0 then [head (reverse ( leftHalf x ) )] ++ [head ( rightHalf x )] else [head ( rightHalf x )]

-- Função que verifica se a primeira metade da String corresponde com a segunda metade da String
checkPalindrome :: String -> Bool
checkPalindrome x = take ( div (length x) 2) x == reverse ( drop (div (length x) 2) x)

-- Função que verifica se todos os lados dos triângulos tem tamanho menor que a soma dos outros dois
checkTriangle :: Float -> Float -> Float -> Bool
checkTriangle a b c = a < b + c && b < a + c && c < a + b

-- Função que calcula a area de um triângulo
triangleArea :: Float -> Float -> Float -> Float
triangleArea a b c = sqrt (s * (s - a) * (s - b) * (s - c) )
    where s = ( a + b + c ) / 2

{-
(a) (’a’,’2’)                   (1) Bool
(b) (’b’,1)                     (2) [Char]
(c) [’a’,’b’,’c’]               (3) (Char,Char)
(d) 1+2 == 4                    (4) (Char,Int)
(e) not                         (5) [(Bool,Bool)]
(f) sqrt                        (6) ([Bool],[Bool])
(g) [sqrt, sin, cos]            (7) Float -> Float
(h) [tail, init, reverse]       (8) Bool -> Bool
(i) ([False,True],[True,False]) (9) [[a] -> [a]]
(j) [(False,True),(True,False)] (10) [Float -> Float]
a -> 03 | c -> 02 | e -> 08 | g -> 10 | i -> 05 
b -> 04 | d -> 01 | f -> 07 | h -> 09 | j -> 06

(a) 1 + 1.5
(b) 1 + False
(c) 'a' + 'b'
(d) 'a' ++ 'b'
(e) "a" ++ "b"
(f) "1+2" == "3"
(g) 1+2 == "3"
(h) show (1+2) == "3"
(i) 'a' < 'b'
(j) 'a' < "ab"
(k) (1 <= 2) <= 3
(l) (1 <= 2) < (3 <= 4)
(m) head [1,2]
(n) head (1,2)
(o) tail "abc"

Que dão erro:
b,c,d,g,j,k,n

(a) second xs = head (tail xs)          = [a] -> a
(b) swap (x,y) = (y,x)                  = (a,a) -> (a,a)
(c) pair x = (x,x)                      = a -> (a,a)
(d) double x = 2*x                      = a -> a
(e) half x = x/2                        = Fractional a -> a
(f) average x y = (x+y)/2               = Fractional a -> a
(g) isLower x = x>=’a’ && x<=’z’        = char -> bool
(h) inRange x lo hi = x>=lo && x<= hi   = a -> bool
(i) isPalindrome xs = xs == reverse xs  = a -> bool
(j) twice f x = f (f x)                 = a -> a -> a
-}
