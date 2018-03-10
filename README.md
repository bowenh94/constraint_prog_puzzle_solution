# constraint_prog_puzzle_solution
  Provide puzzle_solution function to solve math puzzles. Given puzzle
  is a matrix with headings rows and columns contains constraints for
  our filling range. In our program, provide methods to satisfy following
  constraints:
  * diagonal/3:      ensure given matrix has same value on diagonal;
  * sum_product/1:   ensure first element of given list is the sum or
                     product of remaining elements;
  * all_distinct/1:  ensure elements in given list are all distinct.
  The approach in this project is remove constraint rows and columns to
  set domain for our variables. Then apply the diagonal constraint on
  this area, and apply sum or product constraint on each rows. Finally
  transpose the matrix and apply sum or product constraint on each column.
