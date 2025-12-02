/*
A ficha requer que represente uma arvore genelógica incialmente usando apenas
male/1, female/1, parent/2.
function/x significa que a functions tem x argumentos
Exemplo no caso de parent ele tem dois onde se pode ler como x é parente de y caso seja parent(x,y)
*/

% Male
male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(cameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

% Female
female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(pameron).
female(haley).
female(alex).
female(lily).
female(poppy).

% Parent
parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(dede,mitchell).
parent(jay,claire).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(barb,pameron).
parent(merle,cameron).
parent(merle,pameron).
parent(phil,haley).
parent(phil,alex).
parent(phil,luke).
parent(claire,haley).
parent(claire,alex).
parent(claire,luke).
parent(mitchell,lily).
parent(mitchell,rexford).
parent(cameron,lily).
parent(cameron,rexford).
parent(pameron,calhoun).
parent(bo,calhoun).
parent(dylan,george).
parent(dylan,poppy).
parent(haley,george).
parent(haley,poppy).

/*
i. Is Haley a female? Yes
ii. Is Gil a male? No
iii. Is Frank a parent of Phil? Yes
iv. Who are Claire’s parents? Dede e Jay
v. Who are Gloria’s children? Joe e Manny
vi. Who are Jay’s grandchildren? Claire (Haley, Alex, Luke), Mitchell (Lily, Rexford), Joe ()
vii. Who are Lily’s grandparents? Dede e Jay, Barb e Merle
viii. Does Alex have children? No
ix. Who are Luke’s siblings (child of both Luke’s parents)? Haley e Alex
*/

% Fazer novas funções que permitam ser mais complexas

% Verifica se X é o pai de Y, verificando primeiro se é homem e depois verifica se é o parente de Y
father(X,Y):-
    X \= Y,
    male(X),
    parent(X,Y).

mother(X,Y):-
    X \= Y,
    female(X),
    parent(X,Y).

% Verifica se X é o avô/avó de Y, verificando se X é parente de um dos pais de Z e depois procura em Z se existe o filho Y
grandparent(X,Y):-
    X \= Y,
    parent(X,Z),
    parent(Z,Y).

% Verifica se X é o avô de Y, verificando ser homem primeiro e depois verifica se é o avô de Y
grandfather(X,Y):-
    X \= Y,
    male(X),
    grandparent(X,Y).

grandmother(X,Y):-
    X \= Y,
    female(X),
    grandparent(X,Y).

% Verifica se X e Y são irmãos, onde verifica se tem os parentes em comum
siblings(X,Y):-
    X \= Y,
    Z \= W,
    parent(Z,X),
    parent(Z,Y),
    parent(W,X),
    parent(W,Y).

% Verifica se X e Y são meios-irmãos onde tem pelo menos um parente em comum
halfSiblings(X,Y):-
    X \= Y,
    parent(Z,X),
    parent(Z,Y).

% Verifica se são X e Y são primos, obtendo primeiro um dos parentes de X e Y e verifica que não são parente de ambos e depois verifica se esses parentes são irmãos
cousins(X,Y):-
    X \= Y,
    parent(XP,X),
    parent(YP,Y),
    /+parent(XP,Y),
    /+parent(YP,X),
    siblings(YP,XP).

% Verifica se X é tio de Y
uncle(X,Y):-
    X \= Y,
    male(X),
    parent(Z,Y),
    Z \= X,
    siblings(Z,X).

aunt(X,Y):-
    X \= Y,
    female(X),
    parent(Z,Y),
    Z \= X,
    siblings(Z,X).