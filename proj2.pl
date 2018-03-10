%  File     : proj2.pl
%  Author   : Bowen Huang
%  Origin   : Fri Oct 13 13:09 2017
%  Purpose  : Provide puzzle solution program to solve 2*2, 3*3 and 4*4
%             math puzzles.
%  Reference: proj2_test.pl by Peter Schachte 2014 for test case used
%             in this project.
%             clpfd by Markus Triska for constraint programming in Prolog
%
%  Provide puzzle_solution function to solve math puzzles. Given puzzle
%  is a matrix with headings rows and columns contains constraints for
%  our filling range. In our program, provide methods to satisfy following
%  constraints:
%  * diagonal/3:      ensure given matrix has same value on diagonal;
%  * sum_product/1:   ensure first element of given list is the sum or
%                     product of remaining elements;
%  * all_distinct/1:  ensure elements in given list are all distinct.
%  The approach in this project is remove constraint rows and columns to
%  set domain for our variables. Then apply the diagonal constraint on
%  this area, and apply sum or product constraint on each rows. Finally
%  transpose the matrix and apply sum or product constraint on each column.

:- ensure_loaded(library(clpfd)).

puzzle_solution(Rows) :-
    Rows = [_|T_Rows], 
    %  get filling range
    fill_range(T_Rows, Fill_Range),
    append(Fill_Range, Vs),
    Vs = [A|_],
    %  apply diagonal constraint on filling range.
    diagonal(Fill_Range, 0, A),
    Vs ins 1..9,
    %  apply sum product constraint on each rows.
    maplist(sum_product, T_Rows),

    transpose(Rows,Columns),
    Columns = [_|T_Columns],
    maplist(sum_product, T_Columns),

    %  if the puzzle is solved, then print result. else filling the
    %  variables with smallest domains to find final result.
    (ground(Vs)
    -> write(Rows)
    ; label(Vs), write(Rows)
    ).


%  diagonal(+Mat, +Index, +Desired): constraint on diagonal values in Mat is
%                                    equal to Desired.
diagonal([],_,_).
diagonal([Row|Tail], Index, Desired) :-
    nth0(Index, Row, D),
    D #= Desired,
    Index1 is Index+1,
    diagonal(Tail, Index1, Desired).

%  fill_range(+Orig, -New): remove first column in Orig matrix.
fill_range([],[]).
fill_range([[_|T]|Tail],[T|TailNew]) :-
    fill_range(Tail,TailNew).

%  sum_product(+Lst): constraint on Lst, ensure first element of Lst is sum
%                     or product of remaining elements. 
sum_product([Result|Lst]) :-
    all_distinct(Lst),
    lst_product(Lst, 1, Result);
    sum(Lst, #=, Result).

lst_product([], Res0, Res) :-
    Res0 #= Res.
lst_product([H|T], Res0, Res) :-
    Res1 = Res0*H,
    lst_product(T, Res1, Res).
