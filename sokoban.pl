% :- dynamic top/2.
% :- dynamic right/2.
% :- dynamic solution/1.


solve(Problem, Solution):-
/***************************************************************************/
/* Your code goes here                                                     */
/* You can use the code below as a hint.                                   */
/***************************************************************************/
    
Problem = [Tops, Rights, Boxes, Solutions, sokoban(Sokoban)],
abolish_all_tables,
retractall(top(_,_)),
findall(_, ( member(P, Tops), assert(P) ), _),
retractall(right(_,_)),
findall(_, ( member(P, Rights), assert(P) ), _),
retractall(solution(_)),
findall(_, ( member(P, Solutions), assert(P) ), _),
retractall(box(_)),
findall(_, ( member(P, Boxes), assert(P) ), _),
retractall(initial_state(_,_)),
findall(Box, member(box(Box), Boxes), BoxLocs),
assert(initial_state(sokoban, state(Sokoban, BoxLocs))),
retractall(sokoban(_)),
assert(sokoban(Sokoban)),

solve_problem(sokoban, Solution).


% pushBoxToDestinationAlongThePathWithExluded(PozycjaBox1, PozycjaDocelowa, StartLudzika, SciezkaPudelka, WykluczonePola, NowaPozycjaLudzika, RuchyLudzika).
% top(x1y1,x1y2).
% top(x1y2,x1y3).
% top(x1y3,x1y4).
% top(x1y4,x1y5).
% top(x2y1,x2y2).
% top(x2y2,x2y3).
% top(x2y3,x2y4).
% top(x2y4,x2y5).
% top(x3y2,x3y3).
% top(x4y3,x4y4).
% right(x1y1,x2y1).
% right(x1y2,x2y2).
% right(x1y3,x2y3).
% right(x1y4,x2y4).
% right(x1y5,x2y5).
% right(x2y2,x3y2).
% right(x2y3,x3y3).
% right(x3y3,x4y3).
% right(x4y3,x5y3).
% box(x2y2).
% box(x4y3).
% solution(x1y1).
% solution(x2y4).
% sokoban(x5y3).


solve_problem(_, Solution) :- 
    sokoban(S), solution(Sol1), solution(Sol2), Sol1 \= Sol2, box(B1), box(B2), B1 \= B2, 
    pathWithExluded(B1, Sol1, [B2], Path1),
    pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S, Path1, [B2], S2, Moves1),
    pathWithExluded(B2, Sol2, [Sol1], Path2),
    pushBoxToDestinationAlongThePathWithExluded(B2, Sol2, S2, Path2, [Sol1], _, Moves2),
    append(Moves1, Moves2, Solution),
    !.


solve_problem(_, Solution) :- 
    sokoban(S), solution(Sol1), solution(Sol2), Sol1 \= Sol2, box(B1), box(B2), B1 \= B2,
    pushBoxOnce(B2, S, B1, TempB2, S2, MovesInitial),
    pathWithExluded(B1, Sol1, [TempB2], Path1),
    pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S2, Path1, [TempB2], S3, Moves1),
    pathWithExluded(TempB2, Sol2, [Sol1], Path2),
    pushBoxToDestinationAlongThePathWithExluded(TempB2, Sol2, S3, Path2, [Sol1], _, Moves2),
    append(MovesInitial, Moves1, MovesWithInitial1),
    append(MovesWithInitial1, Moves2, Solution),
    !.

solve_problem(_, Solution) :- 
    sokoban(S), solution(Sol1), solution(Sol2), Sol1 \= Sol2, box(B1), box(B2), B1 \= B2,
    pushBoxOnce(B2, S, B1, TempB21, S12, MovesInitial1),
    pushBoxOnce(TempB21, S12, B1, TempB2, S2, MovesInitial2),
    pathWithExluded(B1, Sol1, [TempB2], Path1),
    pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S2, Path1, [TempB2], S3, Moves1),
    pathWithExluded(TempB2, Sol2, [Sol1], Path2),
    pushBoxToDestinationAlongThePathWithExluded(TempB2, Sol2, S3, Path2, [Sol1], _, Moves2),
    append(MovesInitial1, MovesInitial2, MovesWithInitial),
    append(MovesWithInitial, Moves1, MovesWithInitial1),
    append(MovesWithInitial1, Moves2, Solution),
    !.

solve_problem(_, Solution) :- 
    sokoban(S), solution(Sol1), solution(Sol2), Sol1 \= Sol2, box(B1), box(B2), B1 \= B2,
    pushBoxOnce(B2, S, B1, TempB2, S12, MovesInitial1),
    pushBoxOnce(B1, S12, TempB2, TempB1, S2, MovesInitial2),
    pathWithExluded(TempB1, Sol1, [TempB2], Path1),
    pushBoxToDestinationAlongThePathWithExluded(TempB1, Sol1, S2, Path1, [TempB2], S3, Moves1),
    pathWithExluded(TempB2, Sol2, [Sol1], Path2),
    pushBoxToDestinationAlongThePathWithExluded(TempB2, Sol2, S3, Path2, [Sol1], _, Moves2),
    append(MovesInitial1, MovesInitial2, MovesWithInitial),
    append(MovesWithInitial, Moves1, MovesWithInitial1),
    append(MovesWithInitial1, Moves2, Solution),
    !.

solve_problem(_, Solution) :- 
    sokoban(S), solution(Sol1), solution(Sol2), Sol1 \= Sol2, box(B1), box(B2), B1 \= B2,
    pushBoxOnce(B1, S, B2, TempB1, S12, MovesInitial1),
    pushBoxOnce(B2, S12, TempB1, TempB2, S2, MovesInitial2),
    pathWithExluded(TempB1, Sol1, [TempB2], Path1),
    pushBoxToDestinationAlongThePathWithExluded(TempB1, Sol1, S2, Path1, [TempB2], S3, Moves1),
    pathWithExluded(TempB2, Sol2, [Sol1], Path2),
    pushBoxToDestinationAlongThePathWithExluded(TempB2, Sol2, S3, Path2, [Sol1], _, Moves2),
    append(MovesInitial1, MovesInitial2, MovesWithInitial),
    append(MovesWithInitial, Moves1, MovesWithInitial1),
    append(MovesWithInitial1, Moves2, Solution),
    !.


solve_problem(_, []).

% pushBoxOnce(InitialBoxPos, Sokoban, SecondBox, NewBoxPos, NewSokoban, Moves)


pushBoxOnce(BoxPos, S, SecondBox, NewPos, BoxPos, AllMoves) :- 
    top(BoxPos, NewPos), top(BefPush, BoxPos), 
    howToGetAlongPathWithExluded(S, BefPush, [BoxPos, SecondBox], MovesToBox),
    append(MovesToBox, [3], AllMoves).

pushBoxOnce(BoxPos, S, SecondBox, NewPos, BoxPos, AllMoves) :- 
    top(NewPos, BoxPos), top(BoxPos, BefPush), 
    howToGetAlongPathWithExluded(S, BefPush, [BoxPos, SecondBox], MovesToBox),
    append(MovesToBox, [2], AllMoves).

pushBoxOnce(BoxPos, S, SecondBox, NewPos, BoxPos, AllMoves) :- 
    right(BoxPos, NewPos), right(BefPush, BoxPos), 
    howToGetAlongPathWithExluded(S, BefPush, [BoxPos, SecondBox], MovesToBox),
    append(MovesToBox, [1], AllMoves).

pushBoxOnce(BoxPos, S, SecondBox, NewPos, BoxPos, AllMoves) :- 
    right(NewPos, BoxPos), right(BoxPos, BefPush), 
    howToGetAlongPathWithExluded(S, BefPush, [BoxPos, SecondBox], MovesToBox),
    append(MovesToBox, [0], AllMoves).
    






pathWithExluded(X, Y, Vis, Path) :- pathWithExluded_aux(X, Y, [X|Vis], Path).
pathWithExluded_aux(X, X, _, [X]).
pathWithExluded_aux(X, Y, Vis, [X|Path]) :- top(X, Z),   top(_, X),    \+ member(Z, Vis), pathWithExluded(Z, Y, [Z|Vis], Path).
pathWithExluded_aux(X, Y, Vis, [X|Path]) :- top(Z, X),   top(X, _),    \+ member(Z, Vis), pathWithExluded(Z, Y, [Z|Vis], Path).
pathWithExluded_aux(X, Y, Vis, [X|Path]) :- right(X, Z), right(_, X),  \+ member(Z, Vis), pathWithExluded(Z, Y, [Z|Vis], Path).
pathWithExluded_aux(X, Y, Vis, [X|Path]) :- right(Z, X), right(X, _),  \+ member(Z, Vis), pathWithExluded(Z, Y, [Z|Vis], Path).

howToGetAlongPathWithExluded(X, Y, Vis, Path) :- howToGetAlongPathWithExluded_aux(X, Y, [X|Vis], Path).
howToGetAlongPathWithExluded_aux(X, X, _, []).
howToGetAlongPathWithExluded_aux(X, Y, Vis, [3|Path]) :- top(X, Z),   \+ member(Z, Vis), howToGetAlongPathWithExluded(Z, Y, [Z|Vis], Path).
howToGetAlongPathWithExluded_aux(X, Y, Vis, [2|Path]) :- top(Z, X),   \+ member(Z, Vis), howToGetAlongPathWithExluded(Z, Y, [Z|Vis], Path).
howToGetAlongPathWithExluded_aux(X, Y, Vis, [1|Path]) :- right(X, Z), \+ member(Z, Vis), howToGetAlongPathWithExluded(Z, Y, [Z|Vis], Path).
howToGetAlongPathWithExluded_aux(X, Y, Vis, [0|Path]) :- right(Z, X), \+ member(Z, Vis), howToGetAlongPathWithExluded(Z, Y, [Z|Vis], Path).




pushBoxToDestinationAlongThePathWithExluded(Start, Start, S, [], _, S, []).
pushBoxToDestinationAlongThePathWithExluded(Start, Start, S, [Start], _, S, []).
pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S, [B1|Path], [B2], S2, Moves1) :- 
    pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S, Path, [B2], S2, Moves1).

pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S, [NextB1|Path], Exluded, S2, AllMoves) :- 
    right(B1, NextB1), right(BefPushPos, B1),
    howToGetAlongPathWithExluded(S, BefPushPos, [B1|Exluded], MovesToBox),
    pushBoxToDestinationAlongThePathWithExluded(NextB1, Sol1, B1, [NextB1|Path], Exluded, S2, Moves),
    append(MovesToBox, [1], MovesToPush),
    append(MovesToPush, Moves, AllMoves).

pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S, [NextB1|Path], Exluded, S2, AllMoves) :- 
    right(NextB1, B1), right(B1, BefPushPos),
    howToGetAlongPathWithExluded(S, BefPushPos, [B1|Exluded], MovesToBox),
    pushBoxToDestinationAlongThePathWithExluded(NextB1, Sol1, B1, [NextB1|Path], Exluded, S2, Moves),
    append(MovesToBox, [0], MovesToPush),
    append(MovesToPush, Moves, AllMoves).

pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S, [NextB1|Path], Exluded, S2, AllMoves) :- 
    top(B1, NextB1), top(BefPushPos, B1),
    howToGetAlongPathWithExluded(S, BefPushPos, [B1|Exluded], MovesToBox),
    pushBoxToDestinationAlongThePathWithExluded(NextB1, Sol1, B1, [NextB1|Path], Exluded, S2, Moves),
    append(MovesToBox, [3], MovesToPush),
    append(MovesToPush, Moves, AllMoves).

pushBoxToDestinationAlongThePathWithExluded(B1, Sol1, S, [NextB1|Path], Exluded, S2, AllMoves) :- 
    top(NextB1, B1), top(B1, BefPushPos),
    howToGetAlongPathWithExluded(S, BefPushPos, [B1|Exluded], MovesToBox),
    pushBoxToDestinationAlongThePathWithExluded(NextB1, Sol1, B1, [NextB1|Path], Exluded, S2, Moves),
    append(MovesToBox, [2], MovesToPush),
    append(MovesToPush, Moves, AllMoves).


% if move == "up":
% return 3
% elif move == "down":
% return 2
% elif move == "left":
% return 0
% elif move == "right":
% return 1