/*
Exercícios a fazer:
1,2,3,4
5a,5d,5e
6a e 6b

Cut serve como bloqueio que não permite voltar para atrás na função
Green cut
O cut não muda o significado lógico do programa

Red cut
O cut muda o significado lógico do programa
*/

/*
1. How the Cut works
Consider the following code:

s(1).
s(2):- !.
s(3).

Without using the interpreter, state the result of each of the following queries:
a) | ?- s(X). -> X = 1, 2
b) | ?- s(X), s(Y). -> X = 1,2 Y = 1,2
c) | ?- s(X), !, s(Y). X = 1, Y = 1,2

2. The effect of a Cut
Consider the following code:

data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a(‘five’).
cut_test_b(X):- data(X), !.
cut_test_b(‘five’).
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c(‘five’, ‘five’).

Without using the interpreter, state the result of each of the following queries:
a) | ?- cut_test_a(X), write(X), nl, fail. -> X = one,two,three,five
b) | ?- cut_test_b(X), write(X), nl, fail. -> X = one
c) | ?- cut_test_c(X, Y), write(X-Y), nl, fail. -> X = one Y = one,two,three

3. State, justifying, whether each of the cuts in the code is red or green.
immature(X):- adult(X), !, fail.                -> Red
immature(_X).
adult(X):- person(X), !, age(X, N), N >=18.     -> Red
adult(X):- turtle(X), !, age(X, N), N >=50.     -> Red
adult(X):- spider(X), !, age(X, N), N>=1.       -> Red
adult(X):- bat(X), !, age(X, N), N >=5.         -> Red

4. Maximum Value
Implement max(+A, +B, +C, ?Max), which determines the maximum value between three
numbers. Note: avoid behaviors such as shown below:
| ?- max(2,3,3,X).
X = 3 ? ;
X = 3 ? ;
no
*/

max(A,B,C,Max):-
    A >= B,
    A >= C,
    Max = A,
    !.

max(A,B,C,Max):-
    B >= A,
    B >= C,
    Max = B,
    !.

max(_,_,C,C).

/*
5. Data Input and Output
Implement the following predicates without using the format/2 predicate.
a) Implement print_n(+N, +S) which prints symbol S to the terminal N times.
b) Implement print_text(+Text, +Symbol, +Padding) which prints the text received in the
first argument (using double quotes) with the padding received in the third argument
(number of spaces before and after the text), and surrounded by Symbol. Example:
| ?- print_text("Hello!", '* ', 4).
* Hello! *
c) Implement print_banner(+Text, +Symbol, +Padding) which prints the text received in the
first argument (using double quotes) using the format of the example below:
| ?- print_banner("Hello World!", '* ', 4).
**********************
* *
* Hello World! *
* *
**********************
d) Implement read_number(-X), which reads a number from the standard input, digit by digit (i.e., without using read), returning that number (as an integer). Suggestion: use peek_code to determine when to terminate the reading cycle (the ASCCI code for Line Feed is 10).
e) Implement read_until_between(+Min, +Max, -Value), which asks the user to insert an integer number between Min and Max, and succeeds only when the value inserted is within those limits. Hint: ensure that the read_number/1 predicate is determinate.
f) Implement read_string(-X), which reads a string of characters from the standard input,
character by character, returning a string (i.e., a list of ASCII codes).
g) Implement banner/0, which asks the user for the arguments to use in a call to
print_banner/3, reads those arguments, and invokes the predicate.
h) Implement print_multi_banner(+ListOfTexts, +Symbol, +Padding) which prints several
lines of texto in the format of a banner, using the longest line to determine the padding to
use in the remaining lines.
| ?- print_multi_banner(["Hello World", "Bye"], '*', 4).
*********************
* *
* Hello World *
* Bye *
* *
*********************
yes
| ?- print_multi_banner(["Hello World!", [73,32,9829,32,80,114,111,
108,111,103], [73,116,32,82,117,108,122,33]], '*', 4).
i) Implement oh_christmas_tree(+N) which prints a tree of size N.
| ?- oh_christmas_tree(5).
     *
    ***
   *****
  *******
 *********
     *
*/

% Implement print_n(+N, +S) which prints symbol S to the terminal N times.

print_n(0,_):-
    !.

print_n(N,S):-
    N > 0,
    write(S),
    N1 is N - 1,
    print_n(N1,S).

% Implement read_number(-X), which reads a number from the standard input, digit by digit (i.e., without using read), returning that number (as an integer). 
% Suggestion: use peek_code to determine when to terminate the reading cycle (the ASCCI code for Line Feed is 10). (Numeros são do 48 ao 57)

read_number(X):-
    read_number_stack(X,0).

read_number_stack(X,Stack):-
    peek_code(10),              % Verifica que o proximo code é 10 = fim do numero
    !,
    get_code(_),                % Não compreendo bem a necessidade, mas talvez seja util caso chame duas vezes a função e tenha numeros separados pelo newline?
    X = Stack.

read_number_stack(X,Stack):-
    peek_code(Code),
    Code >= 48,
    Code <= 57,                 % Garantir que o code está dentro das margens para numero
    get_code(Code),
    Digit is Code - 48,         % Conversão para do code para inteiro
    Stack1 is Stack * 10 + Digit,
    read_number_stack(X,Stack1).

% Implement read_until_between(+Min, +Max, -Value), which asks the user to insert an integer number between Min and Max, and succeeds only when the value inserted is within those limits. 
% Hint: ensure that the read_number/1 predicate is determinate.

read_until_between(Min,Max,Value):-
    read_number(Value),
    (
        Min <= Value,
        Max >= Value;
        write('Valor inválido, tenta de novo: '), 
        nl,
        read_until_between(Min,Max,Value)
    ).

/*
6. List Printing
a) Implement print_full_list(+L), which receives a list and prints it to the terminal using spaces in addition to commas to separate elements in the list.
b) Implement print_list(+L), which receives a list and either prints it in full if its size is up to 11 elements, or prints the first, middle and last three elements of the list, plus ellipses in between these three groups for lists with 12 or more elements. Use the predicate from the previous question to print the lists with spaces between the elements. Examples:
| ?- print_list([a,b,c,d,e,f,g,h,i,j,k]).
[a, b, c, d, e, f, g, h, i, j, k]
yes
| ?- print_list([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p]).
[a, b, c, ..., h, i, j, ..., n, o, p]
yes
c) Implement print_matrix(+M), which prints a list of lists, with each list in a line, and formatted as above. Example:
| ?- print_matrix([[a,b,c], [d,e,f], [g,h,i]]).
[a, b, c]
[d, e, f]
[g, h, i]
yes
d) Create a new version of the predicate above, print_numbered_matrix(+L), that prints the
matrix with a line number before each line. Note that the matrix may have more than nine
lines, so the numbers should be padded to ensure a correct number alignment. Example:
| ?- length(_L, 100), maplist(=([a,b,c,d]), _L),
print_numbered_matrix(_L).
1 [a, b, c, d]
 ( ... )
 99 [a, b, c, d]
100 [a, b, c, d]
yes
e) Implement print_list(+L, +S, +Sep, +E), which prints a list using S as a starting symbol,
Sep as the separator between elements, and E as the end symbol. Example:
| ?- print_list([a,b,c,d,e], '[', ', ', ']').
[a, b, c, d, e]
yes
| ?- print_list([a,b,c,d,e], '< ', ' | ', ' >').
< a | b | c | d | e >
yes
*/

% Implement print_full_list(+L), which receives a list and prints it to the terminal using spaces in addition to commas to separate elements in the list.

print_full_list([]):-
    !.

print_full_list([X]):-
    write(X), 
    !.

print_full_list([H|T]):-
    write(H),
    write(', '),
    print_full_list(T).

/*
Implement print_list(+L), which receives a list and either prints it in full if its size is up to 11 elements, 
or prints the first, middle and last three elements of the list,
plus ellipses in between these three groups for lists with 12 or more elements. 
Use the predicate from the previous question to print the lists with spaces between the elements.
Examples:
| ?- print_list([a,b,c,d,e,f,g,h,i,j,k]).
[a, b, c, d, e, f, g, h, i, j, k]
yes
| ?- print_list([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p]).
[a, b, c, ..., h, i, j, ..., n, o, p]
yes
*/

print_list(L):-
    length(L,Size),
    (
        Size <= 11,
        write('['),
        print_full_list(L),
        write(']')
    ;
        % Primeiros 3
        write('['),
        append([X,Y,Z],_,L),
        print_full_list([X,Y,Z]),
        write(', ..., '),

        % Meio
        MiddleStart is Size // 2 - 1,
        append(Prefix,Rest,L),
        length(Prefix,MiddleStart), % Isto serve para assegurar que o tamanho a ser cortado da primeira parte corresponde com metade
        append([M,I,D],_,Rest),
        print_full_list([M,I,D]),
        write(', ..., '),

        % Ultimos 3
        append(_,[A,B,C],L),
        print_full_list([A,B,C]),
        write(']')
    ).