/*
Objectives:
− Lists in Prolog
[Note: except when stated otherwise, do not use the built-in lists predicates or the lists library when solving the exercises below]

Lists
Without using the interpreter, state the result of each of the following equalities in Prolog:

a) | ?- [a | [b, c, d] ] = [a, b, c, d].
    True, separa a cabeça e depois indica o resto da lista dentro de lista
b) | ?- [a | b, c, d ] = [a, b, c, d].
    Erro de sintaxe
c) | ?- [a | [b | [c, d] ] ] = [a, b, c, d].
    True, separa a cabeça usando o | e depois indica o lista, apesar de dentro da mesma repetir o processo isolando a cabeça diversas vezes
d) | ?- [H|T] = [pfl, lbaw, fsi, ipc].
    H = pfl T = [lbaw,fsi,ipc]
e) | ?- [H|T] = [lbaw, ltw].
    H = lbaw T = [ltw]
f) | ?- [H|T] = [leic].
    H = leic T = []
g) | ?- [H|T] = [].
    false o  [H|T] é sempre uma lista não vazia
h) | ?- [H|T] = [leic, [pfl, ipc, lbaw, fsi] ].
    H = leic T = [[pfl,ipc,lbaw,fsi]]
i) | ?- [H|T] = [leic, Two].
    H = leic T = [Two]
j) | ?- [Inst, feup] = [gram, LEIC].
    true porque Inst = gram e LEIC = feup
k) | ?- [One, Two | Tail] = [1, 2, 3, 4].
    One = 1 Two = 2 Tail = [3,4]
l) | ?- [One, Two | Tail] = [leic | Rest].
    One = leic  Rest = [Two | Tail]
*/

/*
Recursion over Lists
a) Implement list_size(+List, ?Size), which determines the size of List.
b) Implement list_sum(+List, ?Sum), which sums the values contained in List (assumed to be a proper list of numbers).
c) Implement list_prod(+List, ?Prod), which multiplies the values in List (assumed to be a proper list of numbers).
d) Implement inner_product (+List1, +List2, ?Result), which determines the inner product of two vectors (represented as lists of integers, of the same size).
e) Implement count(+Elem, +List, ?N), which counts the number of occurrences (N) of Elem within List.
*/

% Implement list_size(+List, ?Size), which determines the size of List.

list_size(List,Size):-
    list_size_stack(List,Size,0).

list_size_stack([],Stack,Stack).
list_size_stack([_|T],Size,Stack):-
    Stack1 is Stack + 1,
    list_size_stack(T,Size,Stack1).

% Implement list_sum(+List, ?Sum), which sums the values contained in List (assumed to be a proper list of numbers).

list_sum(List,Sum):-
    list_sum_stack(List,Sum,0).

list_sum_stack([],Stack,Stack).
list_sum_stack([H|T],Sum,Stack):-
    Stack1 is Stack + H,
    list_sum_stack(T,Sum,Stack1).

% Implement list_prod(+List, ?Prod), which multiplies the values in List (assumed to be a proper list of numbers).

list_prod(List,Prod):-
    list_prod_stack(List,Prod,1).

list_prod_stack([],Stack,Stack).
list_prod_stack([H|T],Prod,Stack):-
    Stack1 is Stack * H,
    list_prod_stack(T,Prod,Stack1).

% Implement inner_product (+List1, +List2, ?Result), which determines the inner product of two vectors (represented as lists of integers, of the same size).

inner_product(List1,List2,Result):-
    inner_product_stack(List1,List2,Result,0).

inner_product_stack([],[],Stack,Stack).
inner_product_stack([H1|T1],[H2|T2],Result,Stack):-
    H3 is H1 * H2,
    Stack1 is Stack + H3,
    inner_product_stack(T1,T2,Result,Stack1).

% Implement count(+Elem, +List, ?N), which counts the number of occurrences (N) of Elem within List.

count(Elem,List,N):-
    count_stack(Elem,List,N,0).

count_stack(_,[],Stack,Stack).
count_stack(Elem,[Elem|T],N,Stack):-
    Stack1 is Stack + 1,
    count_stack(Elem,T,N,Stack1).

count_stack(Elem,[_|T],N,Stack):-
    count_stack(Elem,T,N,Stack).

/*
List Manipulation
a) Implement invert(+List1, ?List2), which inverts list List1.
b) Implement del_one(+Elem, +List1, ?List2), which deletes the first occurrence of Elem from List1, resulting in List2.
c) Implement del_all(+Elem, +List1, ?List2), which deletes all occurrences of Elem from List1, resulting in List2.
d) Implement del_all_list(+ListElems, +List1, ?List2), which deletes from List1 all occurrences of all elements of ListElems, resulting in List2.
e) Implement del_dups(+List1, ?List2), which eliminates repeated values from List1.
f) Implement list_perm (+L1, +L2) which succeeds if L2 is a permutation of L1.
g) Implement replicate(+Amount, +Elem, ?List) which generates a list with Amount repetitions of Elem.
h) Implement intersperse(+Elem, +List1, ?List2), which intersperses Elem between the elements of List1, resulting in List2.
i) Implement insert_elem(+Index, +List1, +Elem, ?List2), which inserts Elem into List1 at position Index, resulting in List2.
j) Implement delete_elem(+Index, +List1, ?Elem, ?List2), which removes the element at position Index from List1 (which is unified with Elem), resulting in List2.
How do you compare the implementation of this predicate with the previous one?
Would it be possible to use a single predicate to perform both operations? How?
k) Implement replace(+List1, +Index, ?Old, +New, ?List2), which replaces the Old element, located at position Index in List1, by New, resulting in List2.
*/

% Implement invert(+List1, ?List2), which inverts list List1.

invert(List1,List2):-
    invert_stack(List1,List2,[]).

invert_stack([],Stack,Stack).
invert_stack([H|T],List2,Stack):-
    invert_stack(T,List2,[H|Stack]).

% Implement del_one(+Elem, +List1, ?List2), which deletes the first occurrence of Elem from List1, resulting in List2.

del_one(_,[],[]).
del_one(Elem,[Elem|T],T).
del_one(Elem,[H|T],[H|R]):-
    del_one(Elem,T,R).

% Implement del_all(+Elem, +List1, ?List2), which deletes all occurrences of Elem from List1, resulting in List2.

del_all(_,[],[]).
del_all(Elem,[Elem|T],R):-
    del_all(Elem,T,R).

del_all(Elem,[H|T],[H|R]):-
    del_all(Elem,T,R).

% Implement del_all_list(+ListElems, +List1, ?List2), which deletes from List1 all occurrences of all elements of ListElems, resulting in List2.

del_all_list([],R,R).
del_all_list([H|T],List1,List2):-
    del_all(H,List1,R),
    del_all_list(T,R,List2).

% Implement del_dups(+List1, ?List2), which eliminates repeated values from List1.

del_dups([],[]).
del_dups([H|T],[H|R]):-
    del_all(H,T,T1),
    del_dups(T1,R).

% Implement list_perm (+L1, +L2) which succeeds if L2 is a permutation of L1.

list_perm([],[]).
list_perm([H|T1],[H|T2]):-
    list_perm(T1,T2).

list_perm([H|T],L2):-
    del_one(H,L2,L2R),
    dif(L2,L2R),
    list_perm(T,L2R).

/*
Append, The Powerful
a) Implement list_append(?L1, ?L2, ?L3), where L3 is the concatenation of lists L1 and L2.
b) Implement list_member(?Elem, ?List), which verifies if Elem is a member of List, using solely the append predicate exactly once.
c) Implement list_last(+List, ?Last), which unifies Last with the last element of List, using solely the append predicate exactly once.
d) Implement list_nth(?N, ?List, ?Elem), which unifies Elem with the Nth element of List, using only the append and length predicates.
e) Implement list_append(+ListOfLists, ?List), which appends a list of lists.
f) Implement list_del(+List, +Elem, ?Res), which eliminates an occurrence of Elem from List, unifying the result with Res, using only the append predicate twice.
g) Implement list_before(?First, ?Second, ?List), which succeeds if the first two arguments are members of List, and First occurs before Second, using only the append predicate twice.
h) Implement list_replace_one(+X, +Y, +List1, ?List2), which replaces one occurrence of X in List1 by Y, resulting in List2, using only the append predicate twice.
i) Implement list_repeated(+X, +List), which succeeds if X occurs repeatedly (at least twice) in List, using only the append predicate twice.
j) Implement list_slice(+List1, +Index, +Size, ?List2), which extracts a slide of size Size from List1 starting at index Index, resulting in List2, using only the append and length predicates.
k) Implement list_shift_rotate(+List1, +N, ?List2), which rotates List1 by N elements to the left, resulting in List2, using only the append and length predicates.
E.g.: | ?- list_shift_rotate([a, b, c, d, e, f], 2, L).
L = [c, d, e, f, a, b]
*/

% Implement list_append(?L1, ?L2, ?L3), where L3 is the concatenation of lists L1 and L2.

list_append([],L,L).
list_append([H|T],L2,[H|R]):-
    list_append(T,L2,R).

% Implement list_member(?Elem, ?List), which verifies if Elem is a member of List, using solely the append predicate exactly once.

list_member(Elem,List):-
    append(_,[Elem|_],List).

% Implement list_last(+List, ?Last), which unifies Last with the last element of List, using solely the append predicate exactly once.

list_last(List,Last):-
    append(_,[Last],List).

/*
Lists of Numbers
a) Implement list_to(+N, ?List), which unifies List with a list containing all the integer numbers from 1 to N.
b) Implement list_from_to(+Inf, +Sup, ?List), which unifies List with a list containing all the integer numbers between Inf and Sup (both included).
c) Implement list_from_to_step(+Inf, +Sup, +Step, ?List), which unifies List with a list containing integer numbers between Inf and Sup, in increments of Step.
d) Change the solutions to the two previous questions to detect cases when Inf is larger than Sup, returning in those cases a list with the elements in decreasing order.
e) Implement primes(+N, ?List), which unifies List with a list containing all prime numbers until N. Note: in this question, you can use the lists library 
(suggestion: use the isPrime predicate, from exercise 4 in exercise sheet 2, and the include/3 predicate from the library).
f) Implement fibs(+N, ?List), which unifies List with a list containing all the Fibonacci numbers of order 0 to N. 
Note: in this question, you can use the lists library (suggestion: use the predicate from exercise 4 in exercise sheet 2, and the maplist/3 predicate).
*/

% Implement list_to(+N, ?List), which unifies List with a list containing all the integer numbers from 1 to N.

list_to(N,List):-
    N1 is N + 1,
    list_to_stack(N1,List,1,[]).

list_to_stack(N,LStack,N,LStack).

list_to_stack(N,List,Stack,LStack):-
    append(LStack,[Stack],LStack1),
    Stack1 is Stack + 1,
    list_to_stack(N,List,Stack1,LStack1).

% Implement list_from_to(+Inf, +Sup, ?List), which unifies List with a list containing all the integer numbers between Inf and Sup (both included).

list_from_to(Inf,Sup,List):-
    Inf < Sup,
    Sup1 is Sup + 1,
    list_from_to_stack(Sup1,List,Inf,[]).

list_from_to_stack(Sup,LStack,Sup,LStack).

list_from_to_stack(Sup,List,Count,LStack):-
    append(LStack,[Count],LStack1),
    Count1 is Count + 1,
    list_from_to_stack(Sup,List,Count1,LStack1).