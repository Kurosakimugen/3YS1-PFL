module Main where

{- Aqui dá-se import ao ficheiro de parsing fornecido pelo professor. Não houve alterações no ficheiro de parsing e nos imports-}
import Parsing
import Data.Char

{- Tipo auxiliar para representar o ambiente de variáveis.
   Cada elemento da lista associa um nome de variável (String) ao seu valor (Integer). -}
type Env = [( String , Integer )] 

{- 
Lista com todas as possibilidades do Expr significar
É de notar que foi adicionado o caso da subtração, da divisão e do resto.
Posteriormente também foi necessário introduzir a variavel para permitir contas do tipo x+1
-}
data Expr = Num Integer
          | Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
          | Div Expr Expr 
          | Mod Expr Expr 
          | Var String    
          deriving Show

{- 
Tipo para representar comandos.
Pode ser:
1. Uma atribuição (Assign), onde uma variável recebe o valor de uma expressão;
2. Uma expressão simples (ExprCmd), que é apenas avaliada e imprime o resultado.
-}
data Command = Assign String Expr
             | ExprCmd Expr
             deriving Show

{-
Aqui sucede a lista de como é avaliado cada caso na arvore
Primeiramente atualizou-se a lista para poder incluir metodo de como proceder quando na arvore tem uma subtração, divisão e resto
Após isso, atualizou-se o formato para ser capaz de lidar com variaveis
Para isso foi necessário adicionar o caso de quando é uma variavel e verificar se a mesma existe-}
eval :: Env -> Expr -> Integer
eval env (Num n) = n
eval env (Var v) = case lookup v env of
    Just val -> val
    Nothing  -> error ("Variable not defined: " ++ v)
eval env (Add e1 e2) = eval env e1 + eval env e2
eval env (Sub e1 e2) = eval env e1 - eval env e2
eval env (Mul e1 e2) = eval env e1 * eval env e2
eval env (Div e1 e2) = div (eval env e1) (eval env e2)
eval env (Mod e1 e2) = mod (eval env e1) (eval env e2)

{-
O parser segue as seguintes regras a multiplicação, divisão e resto tem maior prioridade que a adição e subtração e entre eles segue esta ordem
-}

{-
Função intermediária antes de avançar com o caso de qual expr é
Estar separado permite separar a logistica de gramatica e ser lida pela arvore
-}
expr :: Parser Expr
expr = do t <- term
          exprCont t

{-
Função que classifica qual caso é e indica como se deve proceder para resolve em cada caso
É preciso que o <|> esteja no mesmo nivel de identação que o primeiro do ou então vai dar erro e não executar
Para cada caso o valor em T é a indicação do resultado da conta e o acc é o resultado acumulado até então
Caso por algum motivo não dê certo então apenas retorna o acumulado
-}
exprCont :: Expr -> Parser Expr
exprCont acc = do char '+'
                  t <- term
                  exprCont (Add acc t)
               <|> do char '-'
                      t <- term
                      exprCont (Sub acc t)
               <|> return acc

{-
Mesmo pensamento que expr
-}           
term :: Parser Expr
term = do f <- factor
          termCont f

{-
Mesmo pensamento que exprCont
-}  
termCont :: Expr -> Parser Expr
termCont acc =  do char '*'
                   f <- factor  
                   termCont (Mul acc f)
                 <|>
                do char '/' 
                   f <- factor  
                   termCont (Div acc f)
                 <|>
                do char '%' 
                   f <- factor  
                   termCont (Mod acc f)
                 <|> return acc

{-
Função utlizada para determinar se algo na parte final era uma variavel ou um numero
E depois disso coloca essa expressão entre parentisis para ficar mais facil de ler e isolar cada parte
-}
factor :: Parser Expr
factor = do n <- natural
            return (Num n)
          <|>
         do v <- variable
            return (Var v)
          <|>
          do char '('
             e <- expr
             char ')'
             return e

{-
Função que indica como proceder quando é um comando
-}
command :: Parser Command
command =
      do v <- variable
         char '='
         e <- expr
         return (Assign v e)
  <|> do e <- expr
         return (ExprCmd e)

{-
Função para verificar que o numero é válido
-}
natural :: Parser Integer
natural = do xs <- many1 (satisfy isDigit)
             return (read xs)

{-
Função usada para verificar a string
-}
variable :: Parser String 
variable = do
  v <- many1 (satisfy isAlpha)
  return v

----------------------------------------------------------------         

{-
Adicionou-se um [] no final para agora estar a considerar o ambiente
-}
main :: IO ()
main = do
  txt <- getContents
  calculator [] (lines txt)

{-
Função utilizada para criar o loop de ler o obtido, avaliar usando as funções corretas e depois mostrar o resultado e voltar a ler
-}
calculator :: Env -> [String] -> IO ()
calculator _ [] = return () {- Caso onde não tem contas escritas para serem avaliadas-}
calculator env (l:ls) = do
  let (out, env') = execute env l {- Atualizar o ambiente com as novas variaveis-}
  putStrLn out
  calculator env' ls {- chamar a seguinte conta linha para ser avaliada -}

{-
Função para indicar como deve ser avaliada a arvore
-}
execute :: Env -> String -> (String, Env)
execute env txt =
  case parse command txt of {- Separar os casos possiveis de command -}
    [(Assign v e, "")] ->
      let val = eval env e
          envSemV = [(nome, valor) | (nome, valor) <- env, nome /= v] {- Limpar a lista de todos os valores antigos que tinha com aquele nome -}
          env' = (v, val) : envSemV {- Introduzir o novo conjunto no incio da lista -}
      in (show val, env')
    [(ExprCmd e, "")] -> {- Caso base onde se aplica as contas mais simples sem atribuição do resultado a variaveis -}
      (show (eval env e), env)
    _ ->
      ("parse error; try again", env) {- Caso em que a análise sintática falhou: o programa não termina abruptamente, mas devolve uma mensagem de erro genérica. -}