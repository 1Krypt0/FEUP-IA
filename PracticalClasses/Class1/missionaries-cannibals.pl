/*
 * My Solution to the Cannibals and Missionaries Problem.
 *
 * It is written in prolog because it is really good to perform searches on trees.
 */

% To reverse a list, just because I was too lazy to do it the right way
:- use_module(library(lists)).

initial([3, 3, 0, 0, left]).
final([0, 0, 3, 3, right]).

start :-
    initial(Start),
    final(Final),
    dfs(Start, Final, [Start], [Start], [], Solution, Ops),
    write('Solution: '), write(Solution), nl,
    write('Operations: '), write(Ops).

dfs(Start, Start, _, Solution, Ops, FinalSolution, FinalOps) :-
    reverse(Solution, FinalSolution),
    reverse(Ops, FinalOps).
dfs(Start, Final, Visited, Solution, Ops, SolutionFinal, OpsFinal) :-
    transform(Start, NewState, Op),
    \+ member(NewState, Visited),
    dfs(NewState, Final, [NewState | Visited], [NewState | Solution], [Op | Ops], SolutionFinal, OpsFinal).

% Checks if the state is valid after each transformation
legal(CL, ML, CR, MR) :-
    ML>=0, CL>=0, MR>=0, CR>=0,
    (ML>=CL ; ML=0),
    (MR>=CR ; MR=0).

transform([CL, ML, CR, MR, left], [CL, ML2, CR, MR2, right], 'Move2MLR'):-
    MR2 is MR + 2,
    ML2 is ML - 2,
    legal(CL, ML2, CR, MR2).

transform([CL, ML, CR, MR, left], [CL2, ML, CR2, MR, right], 'Move2CLR'):-
    CR2 is CR + 2,
    CL2 is CL - 2,
    legal(CL2, ML, CR2, MR).

transform([CL, ML, CR, MR, left], [CL2, ML2, CR2, MR2, right], 'Move1C1MLR'):-
    CR2 is CR + 1,
    CL2 is CL - 1,
    MR2 is MR + 1,
    ML2 is ML - 1,
    legal(CL2, ML2, CR2, MR2).

transform([CL, ML, CR, MR, left], [CL, ML2, CR, MR2, right], 'Move1MLR'):-
    MR2 is MR + 1,
    ML2 is ML - 1,
    legal(CL, ML2, CR, MR2).

transform([CL, ML, CR, MR, left], [CL2, ML, CR2, MR, right], 'Move1CLR'):-
    CR2 is CR + 1,
    CL2 is CL - 1,
    legal(CL2, ML, CR2, MR).

transform([CL, ML, CR, MR, right], [CL, ML2, CR, MR2, left], 'Move2MRL'):-
    MR2 is MR - 2,
    ML2 is ML + 2,
    legal(CL, ML2, CR, MR2).

transform([CL, ML, CR, MR, right], [CL2, ML, CR2, MR, left], 'Move2CRL'):-
    CR2 is CR - 2,
    CL2 is CL + 2,
    legal(CL2, ML, CR2, MR).

transform([CL, ML, CR, MR, right], [CL2, ML2, CR2, MR2, left], 'Move1M1CRL'):-
    CR2 is CR - 1,
    CL2 is CL + 1,
    MR2 is MR - 1,
    ML2 is ML + 1,
    legal(CL2, ML2, CR2, MR2).

transform([CL, ML, CR, MR, right], [CL, ML2, CR, MR2, left], 'Move1MRL'):-
    MR2 is MR - 1,
    ML2 is ML + 1,
    legal(CL, ML2, CR, MR2).

transform([CL, ML, CR, MR, right], [CL2, ML, CR2, MR, left], 'Move1CRL'):-
    CR2 is CR - 1,
    CL2 is CL + 1,
    legal(CL2, ML, CR2, MR).
