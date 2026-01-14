% Funções auxiliares que vêm de import

permutation([], []).
permutation(L, [H|T]) :-
    select(H, L, R),
    permutation(R, T).

select(X, [X|T], T).
select(X, [H|T], [H|R]) :-
    select(X, T, R).

nth1(1, [H|_], H).
nth1(N, [_|T], X) :-
    nth1(N1, T, X),
    N is N1 + 1.

/*
Versão tail recursion
nth1(1, [H|_], H).
nth1(N, [_|T], X) :-
    integer(N),
    N > 1,
    N1 is N - 1,
    nth1(N1, T, X).
*/

max_list([X], X).
max_list([H|T], Max):-
    max_list(T, MaxT),
    (
        H > MaxT
    ->
        Max = H
    ;
        Max = MaxT
    ).

% Cor dos tokens
colors([green,yellow,blue,orange,white,black]).

% Tabuleiro default
% Ordem das letras do tabuleiro [A,B,C,D,E,F]

board(Board) :-
    colors(Colors),
    permutation(Colors, Board).

% Constraints

/*
Funções úteis
nth1(Pos, List, Elem)       Serve para determinar a posição de um elemento ou saber que elemento está na posição
member(Elem, List)          Serve para verificar se um certo elemento existe na lista desconsiderando a posição
append(L1,L2,L3)            Serve para unir duas listas ou para verificar se é possível criar uma separação de listas tal que L1+L2 dê sempre o L3
findall(Template,Goal,List) Serve para processar o resultado de uma função e guardar cada resultado numa lista (Template define o que guardar do goal para ficar preservado,Goal é o metodo a ser utilizado para avaliar, List é onde fica guardado o resultado)
max_list(List,Max)          Serve para obter o maior valor de uma lista
*/

% X pode estar em qualquer posição.
anywhere(X, Board):-
    member(X, Board).    % Para garantir que de facto ele gerou um board e a peça foi colocada

% X tem de ser adjacente a Y onde segue esta ordem para adjacentes A->B->C->D->E->F (A e F não são adjacentes)
next_to(X,X,_).                         % Ignora o caso onde dão duas vezes a mesma cor
next_to(X,Y,Board):-                    % Avalia ambos os casos de posições para saber se é válido
    (
        append(Prefix,[X,Y|Suffix], Board)
    ;
        append(Prefix,[Y,X|Suffix], Board)
    ).

% X tem de ter um de intervalo em comparação com Y, Ex.: A,C | B,D | C,E | D,F (F,D, etc tambem são válidos)
one_space(X, X, _).                     % Ignora o caso onde dão duas vezes a mesma cor
one_space(X, Y, Board):-                % Avalia ambos os casos de posições para saber se é válido
    (   
        append(Prefix,[X,_,Y|Suffix],Board)
    ;
        append(Prefix,[Y,_,X|Suffix],Board)
    ).

% X tem de estar na edge oposto a Y, Posições validas Ex.: X = A e B, Y = D,E,F (C sempre vai ser fail para este caso)
across(X, X, _).                        % Ignora o caso onde dão duas vezes a mesma cor
across(X, Y, Board):-
    nth1(PX,Board,X),                   % Obtêm a posição de X
    nth1(PY,Board,Y),                   % Obtêm a posição de Y
    (
        PX =< 2,                        % Verifica se X está na aresta A,B
        PY >= 4                         % Verifica se Y está na aresta D,E,F
        ;
        PX >= 4,                        % Verifica se X está na aresta D,E,F
        PY =< 2                         % Verifica se Y está na aresta A,B
    ). 

% X tem de estar na mesma edge que Y, Edges possíveis (A,B),(D,E,F).
same_edge(X, X, _).                     % Ignora o caso onde dão duas vezes a mesma cor
same_edge(X, Y, Board):-
    nth1(PX,Board,X),                   % Obtêm a posição de X
    nth1(PY,Board,Y),                   % Obtêm a posição de Y
    (
        PX =< 2,                        % Verifica se X está na aresta A,B
        PY =< 2                         % Verifica se Y está na aresta A,B
        ;
        PX >= 4,                        % Verifica se X está na aresta D,E,F
        PY >= 4                         % Verifica se Y está na aresta D,E,F
    ). 

% X tem de estar na posição especificada por L
position(X, L, Board):-
    nth1(P,Board,X),                    % Obtêm a posição de X
    member(P,L).                        % Verifica se a posição de X pertence à lista fornecida de posições válidas

% Função do solve

solve(Constraints,Board):-
    board(Board),                       % Gera um board para testar
    satisfies_all(Constraints, Board).  % Chama a função auxiliar que avalia a lista de constraint no board

satisfies_all([], _).                   % Caso Base da recursão
satisfies_all([C|Cs], Board):-
    call(C, Board),                     % Chama a constraint e responde com true ou false dependendo se a lista respeita a constraitn
    satisfies_all(Cs, Board).           % Chama a função novamente para verificar a seguinte constraint é válida

%  12 solutions
example(1, [ next_to(white,orange),
    next_to(black,black),
    across(yellow,orange),
    next_to(green,yellow),
    position(blue,[1,2,6]),
    across(yellow,blue) ]).
% 1 solution
example(2, [ across(white,yellow),
    position(black,[1,4]),
    position(yellow,[1,5]),
    next_to(green, blue),
    same_edge(blue,yellow),
    one_space(orange,black) ]).
%  no solutions (5 constraints are satisfiable)
example(3, [ across(white,yellow),
    position(black,[1,4]),
    position(yellow,[1,5]),
    same_edge(green, black),
    same_edge(blue,yellow),
    one_space(orange,black) ]).
%  same as above, different order of constraints
example(4, [ position(yellow,[1,5]),
    one_space(orange,black),
    same_edge(green, black),
    same_edge(blue,yellow),
    position(black,[1,4]),
    across(white,yellow) ]).

% Função para calcular a quantidade de constraints respeitadas (Falta alguns toques finais ainda não consigo obter o melhor caso)

best_score(Constraints, 0):-                        % Caso onde dão um board possível
    solve(Constraints,Board),                       % Deu uma solução aqui logo é um caso onde existe board que satifasça as constraint todas
    !.                                              % Manda parar para não gerar todas as respostas

best_score(Constraints, BestScore):-
    findall(                                        % Chama o findall para obter todos os resultados possiveis sobre as constraints
        Score,
        (
            board(Board),
            best_score_stack(Constraints, Score, 0, Board)
        ),
        Scores
    ),
    max_list(Scores, BestScore).                    % Escolhe o melhor resultado da lista de resultados (No caso o valor mais próximo de 0)

best_score_stack([],Stack,Stack,_).                 % Caso base da função auxiliar
best_score_stack([CH|CT],Score,Stack,Board):-       % Caso geral da função auxiliar
    (
        call(CH,Board),                             % Chama a função e verifica que se a constraint é valida neste board
        best_score_stack(CT,Score,Stack,Board)      % Caso seja avança para a constraint seguinte
    ;
        Stack1 is Stack - 1,                        % Caso falhe o call entra neste ramo e atualiza a stack para considerar a constraint falha
        best_score_stack(CT,Score,Stack1,Board)     % Avança para a constraint seguinte utilizando a stack atualizada
    ).