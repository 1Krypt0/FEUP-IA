/*
* My Solution to the Bucket-Filling Problem, made famous by the original Die Hard
* movie
*
* It is written in prolog because it is really good to perform searches on trees.
*/

% Initial and Final States
initial([0, 0]).
final([2, _]).

% Init function to kick-off exploration. In the current state, it only finds the
% first solution it deems appropriate. To find all solutions, we can simply tell
% the machine to fail, and it will try a different set of operations.
%
% To see it in action, remove the . from the final line and uncomment the rest.
start :-
    initial(E),
    dfs(E, [E], Solution, Ops),
    write('Solution: '), write(Solution), nl,
    write('Operations: '), write(Ops). %, nl, fail.

dfs(E, _, [E], []) :-
    final(E).

dfs(E, Visited, [E | Rest], [Op | RestOps]) :-
    transform(E, NewE, Op),
    \+ member(NewE, Visited),
    dfs(NewE, [NewE | Visited], Rest, RestOps).

transform([B1, B2], [NewB1, NewB2], 'FillB1') :-
    B1 < 4,
    NewB1 is 4,
    NewB2 is B2.

transform([B1, B2], [NewB1, NewB2], 'FillB2') :-
    B2 < 3,
    NewB2 is 3,
    NewB1 is B1.

transform([B1, B2], [NewB1, NewB2], 'EmptyB1') :-
    B1 > 0,
    NewB1 is 0,
    NewB2 is B2.

transform([B1, B2], [NewB1, NewB2], 'EmptyB2') :-
    B2 > 0,
    NewB2 is 0,
    NewB1 is B1.

transform([B1, B2], [NewB1, NewB2], 'PourB1B2FillB2') :-
    B1 + B2 >= 3, B2 < 3,
    NewB1 is B1 - (3 - B2),
    NewB2 is 3.

transform([B1, B2], [NewB1, NewB2], 'PourB1B2EmptyB1') :-
    B1 + B2 < 3, B1 > 0,
    NewB2 is B2 + B1,
    NewB1 is 0.

transform([B1, B2], [NewB1, NewB2], 'PourB2B1FillB1') :-
    B1 + B2 >= 4, B2 < 4,
    NewB2 is B2 - (4 - B1),
    NewB1 is 4.

transform([B1, B2], [NewB1, NewB2], 'PourB2B1EmptyB2') :-
    B1 + B2 < 4, B2 > 0,
    NewB1 is B1 + B2,
    NewB2 is 0.
