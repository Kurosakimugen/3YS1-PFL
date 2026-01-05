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
    dif(X,Y),
    male(X),
    parent(X,Y).

mother(X,Y):-
    dif(X,Y),
    female(X),
    parent(X,Y).

% Verifica se X é o avô/avó de Y, verificando se X é parente de um dos pais de Z e depois procura em Z se existe o filho Y
grandparent(X,Y):-
    dif(X,Y),
    parent(X,Z),
    parent(Z,Y).

% Verifica se X é o avô de Y, verificando ser homem primeiro e depois verifica se é o avô de Y
grandfather(X,Y):-
    dif(X,Y),
    male(X),
    grandparent(X,Y).

grandmother(X,Y):-
    dif(X,Y),
    female(X),
    grandparent(X,Y).

% Verifica se X e Y são irmãos, onde verifica se tem os parentes em comum
siblings(X,Y):-
    dif(X,Y),
    dif(Z,W),
    parent(Z,X),
    parent(Z,Y),
    parent(W,X),
    parent(W,Y).

% Verifica se X e Y são meios-irmãos onde tem pelo menos um parente em comum
halfSiblings(X,Y):-
    dif(X,Y),
    parent(Z,X),
    parent(Z,Y).

% Verifica se são X e Y são primos, obtendo primeiro um dos parentes de X e Y e verifica que não são parente de ambos e depois verifica se esses parentes são irmãos
cousins(X,Y):-
    dif(X,Y),
    parent(XP,X),
    parent(YP,Y),
    \+parent(XP,Y),
    \+parent(YP,X),
    siblings(YP,XP).

% Verifica se X é tio de Y
uncle(X,Y):-
    dif(X,Y),
    male(X),
    parent(Z,Y),
    dif(Z,X),
    siblings(Z,X).

aunt(X,Y):-
    dif(X,Y),
    female(X),
    parent(Z,Y),
    dif(Z,X),
    siblings(Z,X).

/*
‘are Haley and Lily cousins?’
?- cousins(haley, lily).
true =? y
yes
‘who is Luke’s father?’
?- father(X, luke).
X = phil ? y
no
‘who is Lily’s uncle?’
?- uncle(X, lily).
no
‘who is a grandmother?’
?- grandmother(X, _).
X = grace ? n
X = grace ? n
X = grace ? n
X = dede ? n
X = dede ? n
X = dede ? n
X = dede ? n
X = dede ? n
X = barb ? n
X = barb ? n
X = barb ? n
X = claire ? n
X = claire ? n
no
or list all pairs of siblings
?- siblings(X, Y).
X = claire,
Y = mitchell ? n
X = mitchell,
Y = claire ? n
X = claire,
Y = mitchell ? n
X = mitchell,
Y = claire ? n
X = cameron,
Y = pameron ? n
X = pameron,
Y = cameron ? n
X = cameron,
Y = pameron ? n
X = pameron,
Y = cameron ? n
X = haley,
Y = alex ? n
X = haley,
Y = luke ? n
X = alex,
Y = haley ? n
X = alex,
Y = luke ? n
X = luke,
Y = haley ? n
X = luke,
Y = alex ? n
X = haley,
Y = alex ? n
X = haley,
Y = luke ? n
X = alex,
Y = haley ? n
X = alex,
Y = luke ? n
X = luke,
Y = haley ? n
X = luke,
Y = alex ? n
X = lily,
Y = rexford ? n
X = rexford,
Y = lily ? n
X = lily,
Y = rexford ? n
X = rexford,
Y = lily ? n
X = george,
Y = poppy ? n
X = poppy,
Y = george ? n
X = george,
Y = poppy ? n
X = poppy,
Y = george ? n
no
or half-siblings.
?- halfSiblings(X, Y).
*/

/*
Usaria dois novos predicados marriage/3 e divorce/3 para representar o casamento e divoricio das pessoas com o respetivo ano em que aconteceu
marriage(X,Y,YEAR).
divorce(X,Y,YEAR).
*/

marriage(jay,gloria,2008).
marriage(jay,dede,1968).
divorce(jay,dede,2003).

/*
Represent information related to courses, teachers and students, according to the table
below, using predicates teaches/2 and attends/2, where the first argument of each
represents the taught or attended course.

Algorithms      |Databases        |Compilers       |Statistics      |Networks
Prof: Adalberto |Prof: Bernardete |Prof: Capitolino|Prof: Diógenes  |Prof: Ermelinda
Stud.: Alberto, |Stud.: António,  |Stud.: Alberto, |Stud.: António, |Stud.: Álvaro,
Bruna, Cristina,|Bruno, Cristina, |Bernardo, Clara,|Bruna, Cláudio, |Beatriz, Cláudio,
Diogo, Eduarda  |Duarte, Eduardo  |Diana, Eurico   |Duarte, Eva     |Diana, Eduardo

teaches(Course,Prof).
attends(Course,Student).
*/
teaches(algorithms,adalberto).
teaches(databases,bernardete).
teaches(compilers,capitolino).
teaches(statistic,diogenes).
teaches(networks,ermelinda).

% Algortimos
attends(algorithms,alberto).
attends(algorithms,bruna).
attends(algorithms,cristina).
attends(algorithms,diogo).
attends(algorithms,eduarda).

% Base de dados
attends(databases,antonio).
attends(databases,bruno).
attends(databases,cristina).
attends(databases,duarte).
attends(databases,eduardo).

% Compiladores
attends(compilers,alberto).
attends(compilers,bernardo).
attends(compilers,clara).
attends(compilers,diana).
attends(compilers,eurico).

% Estatistica
attends(statistic,antonio).
attends(statistic,bruna).
attends(statistic,claudio).
attends(statistic,duarte).
attends(statistic,eva).

% Redes
attends(networks,alvaro).
attends(networks,beatriz).
attends(networks,claudio).
attends(networks,diana).
attends(networks,eduardo).

/*
Use the interpreter to answer the following questions:
i. What courses does Diógenes teach?
teaches(X,diogenes).
statistic

ii. Does Felismina teach any course?
teaches(_,felismina).
no

iii. What courses does Cláudio attend?
attends(X,claudio).
X = statistic ? n
X = networks ? n
no

iv. Does Dalmindo attend any course?
attends(_,dalmindo). 
no

v. Is Eduarda a student of Bernardete?
teaches(X,bernardete),attends(X,eduarda).
no

vi. Do Alberto and Álvaro attend any course in common?
attends(X,alberto),attends(X,alvaro).
no
*/

/*
Write rules in Prolog that allow answering the following questions:
i. Is X a student of professor Y? usando o studentof
ii. Who are the students of professor X? usando o studentof
iii. Who are the teachers of student X? usando o studentof
iv. Who is a student of both professor X and professor Y? usando o commonstudent
v. Who is colleagues with whom? usando o colleagues
(two students are colleagues if they attend at least one course in common; two teachers are colleagues)
vi. Who are the students that attend more than one course? usando o multicourse
*/

% i
studentof(Aluno,Prof):-
    teaches(X,Prof),
    attends(X,Aluno).

% iv
commonstudent(Aluno,ProfX,ProfY):-
    dif(ProfX,ProfY),
    studentof(Aluno,ProfX),
    studentof(Aluno,ProfY).

% v
colleagues(SujeitoX,SujeitoY):-
    dif(SujeitoX,SujeitoY),
    teaches(_,SujeitoX),
    teaches(_,SujeitoY);
    dif(SujeitoX,SujeitoY),
    attends(X,SujeitoX),
    attends(X,SujeitoY).

% vi
multicourse(Aluno):-
    attends(Course1,Aluno),
    attends(Course2,Aluno),
    dif(Course1,Course2).
