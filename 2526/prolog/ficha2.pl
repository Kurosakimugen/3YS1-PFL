/*
Prolog and Backtracking
Consider the following facts:
*/

r(a, b).
r(a, d).
r(b, a).
r(a, c).

s(b, c).
s(b, d).
s(c, c).
s(d, e).

/*
a) Without using the Prolog interpreter, indicate all the answers to the following queries:

O backtrack apenas conta quando tem fazer o redo da primeira regra após ter chegado à segunda regra

i. r(X, Y), s(Y, Z).
(X= a,Y= b,Z= c), (X= a,Y= b,Z= d), (X= a,Y= d,Z= e), (X= a,Y= c,Z= c)
Backtrack = 3 vezes (antes de testar) -> 0
% trace
| ?- r(X,Y),s(Y,Z).
        1      1 Call: r(_803,_843) ? 
?       1      1 Exit: r(a,b) ? 
        2      1 Call: s(b,_957) ? 
?       2      1 Exit: s(b,c) ? 
X = a,
Y = b,
Z = c ? n
        2      1 Redo: s(b,c) ? 
        2      1 Exit: s(b,d) ? 
X = a,
Y = b,
Z = d ? n
        1      1 Redo: r(a,b) ? 
?       1      1 Exit: r(a,d) ? 
        3      1 Call: s(d,_957) ? 
        3      1 Exit: s(d,e) ? 
X = a,
Y = d,
Z = e ? n
        1      1 Redo: r(a,d) ? 
?       1      1 Exit: r(b,a) ? 
        4      1 Call: s(a,_957) ? 
        4      1 Fail: s(a,_957) ? 
        1      1 Redo: r(b,a) ? 
        1      1 Exit: r(a,c) ? 
        5      1 Call: s(c,_957) ? 
        5      1 Exit: s(c,c) ? 
X = a,
Y = c,
Z = c ? n
no
% trace
ii. s(Y, Y), r(X, Y).
(X= c,Y= a)
Backtrack = 0 vezes (antes de testar) -> 0
% trace
| ?- s(Y, Y), r(X, Y).
        1      1 Call: s(_803,_803) ? 
?       1      1 Exit: s(c,c) ? 
        2      1 Call: r(_917,c) ? 
        2      1 Exit: r(a,c) ? 
Y = c,
X = a ? n
        1      1 Redo: s(c,c) ? 
        1      1 Fail: s(_803,_803) ? 
no
% trace

iii. r(X, Y), s(Y, Y).
(X= c,Y= a)
Backtrack = 0 vezes (antes de testar) -> 3
% trace
| ?- r(X,Y), s(Y,Y).
        1      1 Call: r(_803,_843) ? 
?       1      1 Exit: r(a,b) ? 
        2      1 Call: s(b,b) ? 
        2      1 Fail: s(b,b) ? 
        1      1 Redo: r(a,b) ? 
?       1      1 Exit: r(a,d) ? 
        3      1 Call: s(d,d) ? 
        3      1 Fail: s(d,d) ? 
        1      1 Redo: r(a,d) ? 
?       1      1 Exit: r(b,a) ? 
        4      1 Call: s(a,a) ? 
        4      1 Fail: s(a,a) ? 
        1      1 Redo: r(b,a) ? 
        1      1 Exit: r(a,c) ? 
        5      1 Call: s(c,c) ? 
        5      1 Exit: s(c,c) ? 
X = a,
Y = c ? n
no
% trace

b) How many times does Prolog backtrack from the second to the first goal before producing
the first answer for each of the queries? Confirm your answers with the Prolog trace mode.
*/

/*
Backtracking and Search Tree
Consider the following facts and rules:
pairs(X, Y):- d(X), q(Y).
pairs(X, X):- u(X).
u(1).
d(2).
d(4).
q(4).
q(16).
*/

pairs(X, Y):- 
    d(X), 
    q(Y).
pairs(X, X):- 
    u(X).

u(1).

d(2).
d(4).

q(4).
q(16).

/*
a) Without using the Prolog interpreter, draw up a search tree and indicate all the solutions
obtained for the query | ?- pairs(X, Y).
d(2,4), q(4,16) logo as possiveis soluções são:
(X= 2,Y= 4),(X= 2,Y= 16),(X= 4,Y= 4),(X= 4,Y= 16), (X= 1,Y= 1)
b) Confirm your answers with the Prolog trace mode.
*/

/*
Backtracking II, the Sequel
Consider the following facts and rules:
a(a1, 1).
a(A2, 2).
a(a3, N).

b(1, b1).
b(2, B2).
b(N, b3).

c(X, Y):- 
    a(X, Z), 
    b(Z, Y).
d(X, Y):- 
    a(X, Z), 
    b(Y, Z).
d(X, Y):- 
    a(Z, X), 
    b(Z, Y).
c) Without using the Prolog interpreter, indicate the answers to the following queries:
i.      a(A, 2). -> no ?  Versão correta A = a3
ii.     b(A, foobar). -> A = 2
iii.    c(A, b3). -> A = a1,a3,? Versão correta A = a1,a3,a3
iv.     c(A, B). -> A = a1, B = b1 | A = ? (Caso do A2,2), B = ? (Caso do 2,B2) | A = a3 , B = b1 , ? , b3 Versão correta A = a1, B = b1 | A = a1, B = b3 | B = b3 | A = a3, B = b1 | A = a3 | A = a3, B = b3
v.      d(A, B). -> A = a1, B = 2  | A = ? (Caso do A2,2), B = 2                | A = a3, B = 1 , 2 , ? Versão Correta A = a1, B = 2  |  B = 2 | A = a3, B = 1 , 2 | A = a3
                 -> A = 2, B = b1  | A = ? (Caso do A2,2), B = ? (Caso do 2,B2) | A = 1 ,2 , ? , B = b3 Versão Correta A = 1, B = b3 | A = 2, B = b1
d) Confirm your answers with the Prolog trace mode.
*/

/*
 Recursion
a) Implement the factorial(+N, -F) predicate, which calculates the factorial of a number N.
b) Implement sum_rec(+N, -Sum) as a recursive predicate to determine the sum of all
numbers from one to N.
c) Implement the pow_rec(+X, +Y, -P) predicate, which recursively determines the result of
raising X to the power of Y.
d) Implement the square_rec(+N, -S) predicate, which recursively determines the square of a
number N (ie, without using multiplications). Suggestion: you may need to use an auxiliary
predicate with additional arguments.
e) Implement the fibonacci(+N, -F) predicate, which determines the Fibonacci number of
order N.
f) Implement collatz(+N, -S), which receives a positive integer number N and determines the
number of steps necessary to reach 1 following the operations set forth by this sequence: if
N is even, in the next step it will take the value N/2; if N is odd, in the next step it will take
the value 3N+1.
g) Implement the is_prime(+X) predicate, which determines whether X is a prime number.
Suggestion: a number is prime if it is divisible only by itself and one.

+ no enunciado indica necessário na documentação e - indica que vai ser calculado
*/


% Implement the factorial(+N, -F) predicate, which calculates the factorial of a number N.

factorial(N,F):-
    factorial_acc(N,F,1).

factorial_acc(0,Stack,Stack).
factorial_acc(N,F,Stack):-
    N > 0,
    Stack1 is Stack * N,
    N1 is N - 1,
    factorial_acc(N1,F,Stack1).


% Implement sum_rec(+N, -Sum) as a recursive predicate to determine the sum of all numbers from one to N.

sum_rec(N,Sum):-
    sum_rec_stack(N,Sum,0).

sum_rec_stack(0,Stack,Stack).
sum_rec_stack(N,Sum,Stack):-
    N > 0,
    Stack1 is Stack + N,
    N1 is N - 1,
    sum_rec_stack(N1,Sum,Stack1).

% Implement the pow_rec(+X, +Y, -P) predicate, which recursively determines the result of raising X to the power of Y.

pow_rec(X,Y,P):-
    pow_rec_stack(X,Y,P,1).

pow_rec_stack(X,0,STACK,STACK).
pow_rec_stack(X,POW,RES,STACK):-
    POW > 0,
    STACK1 is X * STACK,
    POW1 is POW - 1,
    pow_rec_stack(X,POW1,RES,STACK1).

% Implement the square_rec(+N, -S) predicate, which recursively determines the square of a number N (ie, without using multiplications). 
% Suggestion: you may need to use an auxiliary predicate with additional arguments.

square_rec(NUM,SUM):-
    square_rec_stack(NUM,SUM,0,0).

square_rec_stack(NUM,SUM,NUM,SUM).
square_rec_stack(NUM,SUM,COUNT,STACK):-
    COUNT < NUM,
    STACK1 is STACK + NUM,
    COUNT1 is COUNT + 1,
    square_rec_stack(NUM,SUM,COUNT1,STACK1).

% Implement the fibonacci(+N, -F) predicate, which determines the Fibonacci number of order N.

fibonacci(N,F):-
    fibonacci_stack(N,F,0,1).

fibonacci_stack(0,STACK,STACK,_).
fibonacci_stack(N,F,STACK,STACK1):-
    N > 0,
    N1 is N - 1,
    SUM is STACK + STACK1,
    fibonacci_stack(N1,F,STACK1,SUM).

% Implement collatz(+N, -S), which receives a positive integer number N and determines the number of steps necessary to reach 1 following the operations set forth by this sequence:
% if N is par, in the next step it will take the value N/2;
% if N is impar, in the next step it will take the value 3N+1.

collatz(1,0).

collatz(N,S):- % Caso de valor par
    N > 1,
    0 is N mod 2,
    N1 is N // 2,
    collatz(N1,S1),
    S is S1 + 1.

collatz(N,S):- % Caso de valor impar
    N > 1,
    1 is N mod 2,
    N1 is 3 * N + 1,
    collatz(N1,S1),
    S is S1 + 1.

% Implement the is_prime(+X) predicate, which determines whether X is a prime number.
% Suggestion: a number is prime if it is divisible only by itself and one.

is_prime(1).
is_prime(X):-
    X > 1,
    is_prime_stack(X,2).

is_prime_stack(X,X).
is_prime_stack(X,S):-
    S < X,              
    X mod S =\= 0,        
    S1 is S + 1,          
    is_prime_stack(X,S1).

/*
Greatest Common Divisor and Least Common Multiple
a) Implement gcd(+X, +Y, -G), which receives two positive integer numbers, X and Y, and determines the greatest common divisor (gcd) using Euclid’s algorithm.
This method recursively determines the gcd between two numbers in the following manner: the gcd between X and Y is X when Y is zero; otherwise, it is the gcd between Y and X mod Y.
b) Implement lcm(+X, +Y, -M), which receives two positive integer numbers, X and Y, and determines the least common multiple, which can be given by lcm(X, Y) = X.Y / gcd(X, Y).
*/

% Implement gcd(+X, +Y, -G), which receives two positive integer numbers, X and Y, and determines the greatest common divisor (gcd) using Euclid’s algorithm.
% This method recursively determines the gcd between two numbers in the following manner: the gcd between X and Y is X when Y is zero; otherwise, it is the gcd between Y and X mod Y.

gcd(X,0,X).
gcd(X,Y,G):-
    Y > 0,
    Y1 is X mod Y,
    gcd(Y,Y1,G).

% Implement lcm(+X, +Y, -M), which receives two positive integer numbers, X and Y, and determines the least common multiple, which can be given by lcm(X, Y) = X.Y / gcd(X, Y).

lcm(X,Y,M):-
    TF is X * Y,
    gcd(X,Y,BF),
    M is TF // BF.