% Simple family facts
parent(alice,bob).
parent(alice,carol).
parent(bob,david).
parent(carol,emma).

female(alice).
female(carol).
female(emma).

male(bob).
male(david).

/*
female(alice).
Resposta: Yes

female(bob).
Resposta: No

parent(alice,bob).
Resposta: Yes

parent(alice,david).
Resposta: No

Resumo: 
Quando se faz uma query no sictus ele verifica todos os factos escritos no programa e caso exista um facto que cumpra com os requesitos responde com yes.
Caso não encontre a respota é no.
*/

lives_in(lion, savannah).
lives_in(penguin, antarctica).
lives_in(elephant, savannah).
lives_in(panda, forest).
lives_in(snake, forest).

/*
lives_in(X, savannah).
X = lion ? ;
X = elephant ? ;
no

Resumo: 
É possível colocar um dos argumentos com maiuscula de forma que o prolog pesquise sobre um argumento que cumpra com o requisito dito.
*/