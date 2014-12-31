% Magic Hexagon: http://en.wikipedia.org/wiki/Magic_hexagon

%          3  |  17 | 18 
% -------------------------------
%       19 |  7  |  1  |  11
% -------------------------------
%   16  |  2  |  5  |  6  |  9 
% -------------------------------
%      12  |  4  |  8  |  14
% -------------------------------
%         10  |  13 |  15

% Author: Carmen Alvarez, 2014.
% LICENSE: Free to use as long as you: cite me, and accept that I'm not responsible for anything in your life, related to this program or not.
% This program works with GNU prolog, not with SWI-prolog.

% The sum of the numbers in a "row" must be 38.
% This applies to rows and diagonals.
isValidRow(Row):- sum_list(Row, 38).

% A hexagon is valid if all of the "rows" add up to 38.
isValidHexagon([]).
isValidHexagon([Row|RestOfRows]):-isValidRow(Row), isValidHexagon(RestOfRows).

% Returns true or false if the given list of numbers makes a magic hexagon.
% If the list contains some variables, they will be calculated (if prolog can
% find some values for them so that the whole list makes a magic hexagon).
isMagicHexagon(Numbers):-
  Numbers = [C11, C12, C13, C21, C22, C23, C24, C31, C32, C33, C34, C35, C41, C42, C43, C44, C51, C52, C53],

  % constraints:
  fd_all_different(Numbers),
  fd_domain(Numbers, 1, 19),
  fd_labeling(Numbers), % this means prolog will try to find all possible solutions, 
                        % if there are variables in the input.
 
  %print(Numbers), nl, % Useful for debugging but slows down execution.

  Rows = [
   % rows:
   [C11, C12, C13],
   [C21, C22, C23, C24],
   [C31, C32, C33, C34, C35],
   [C41, C42, C43, C44],
   [C51, C52, C53],
   % NW/SE diagonals:
   [C11, C21, C31],
   [C12, C22, C32, C41],
   [C13, C23, C33, C42, C51],
   [C24, C34, C43, C52],
   [C35, C44, C53],
   % NE/SW diagonals:
   [C13, C24, C35],
   [C12, C23, C34, C44],
   [C11, C22, C33, C43, C53],
   [C21, C32, C42, C52],
   [C31, C41, C51]
  ],

  isValidHexagon(Rows).

% Find all the possible solutions
% Not sure if this function even works, since I didn't
% have the patience to wait for it to complete :)
findMagicHexagons(Solution) :-
  findall(X, isMagicHexagon(X), Solution), fd_labeling(Solution).

% Usage examples:
% 1) Check if a particular sequence of numbers is a magic hexagon.
% isMagicHexagon([3,17,18,19,7,1,11,16,2,5,6,9,12,4,8,14,10,13,15]).
% this will return true/false

% 2) Find the missing pieces, given some of the pieces:
% isMagicHexagon([C11,C12,C13,C21,7,1,11,16,2,5,6,9,12,4,8,14,10,13,C53]).
% This will return an output with the missing pieces, like:
% C11 = 3
% C12 = 17
% C13 = 18
% C21 = 19
% C53 = 15

% 3) Find all possible solutions (not tested: takes too long):
% findMagicHexagons(X).
