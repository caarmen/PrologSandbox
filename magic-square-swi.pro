% Albrecht Durer's Magic Square
% http://en.wikipedia.org/wiki/Magic_square#Albrecht_D.C3.BCrer.27s_magic_square

%  16 |  3 |  2 | 13
% -------------------
%   5 | 10 | 11 |  8
% -------------------
%   9 |  6 |  7 | 12
% -------------------
%   4 | 15 | 14 |  1

% Author: Carmen Alvarez, 2014.
% LICENSE: Free to use as long as you: cite me, and accept that I'm not responsible for anything in your life, related to this program or not.
% This program works with SWI prolog, not with GNU prolog.

:- use_module(library(clpfd)).
% The sum of the numbers in a "row" must be 34.
% This applies to rows, columns, and diagonals.
isValidRow(Row):- sum_list(Row, 34).

% A square is valid if all of the "rows" add up to 34.
isValidSquare([]).
isValidSquare([Row|RestOfRows]):-isValidRow(Row), isValidSquare(RestOfRows).

% Returns true or false if the given list of numbers makes a magic square.
% If the list contains some variables, they will be calculated (if prolog can
% find some values for them so that the whole list makes a magic square).
isMagicSquare(Numbers):-
  Numbers = [C11, C12, C13, C14, C21, C22, C23, C24, C31, C32, C33, C34, C41, C42, C43, C44],

  % constraints:
  all_different(Numbers),
  Numbers ins 1..16,
  labeling([up], Numbers), % this means prolog will try to find all possible solutions, 
                        % if there are variables in the input.
 
  %print(Numbers), nl, % Useful for debugging but slows down execution.

  Rows = [
   % rows:
   [C11, C12, C13, C14],
   [C21, C22, C23, C24],
   [C31, C32, C33, C34],
   [C41, C42, C43, C44],
   % columns:
   [C11, C21, C31, C41],
   [C12, C22, C32, C42],
   [C13, C23, C33, C43],
   [C14, C24, C34, C44],
   % diagonals:
   [C11, C22, C33, C44],
   [C14, C23, C32, C41]
  ],

  isValidSquare(Rows).

% Find all the possible solutions
% Not sure if this function even works, since I didn't
% have the patience to wait for it to complete :)
findMagicSquares(Solution) :-
  findall(X, isMagicSquare(X), Solution), fd_labeling(Solution).

% Usage examples:
% 1) Check if a particular sequence of numbers is a magic square.
% isMagicSquare([16,3,2,13,5,10,11,8,9,6,7,12,4,15,14,1]).
% this will return true/false

% 2) Find the missing pieces, given some of the pieces:
% isMagicSquare([C11,C12,C13,C14,5,10,11,8,9,6,7,12,4,15,14,C44]).
% This will return an output with the missing pieces, like:
%  C11 = 16
%  C12 = 3
%  C13 = 2
%  C14 = 13
%  C44 = 1

% 3) Find all possible solutions (not tested: takes too long):
% findMagicSquares(X).
