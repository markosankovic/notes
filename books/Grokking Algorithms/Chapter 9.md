# Chapter 9 Dynamic Programming

Dynamic programming is a technique to solve hard problems by breaking it up into subproblems and solving those subproblems first.

## The knapsack problem

The approximate solution will be close to the optimal solution, but it may not be the optimal solution. How do you calculate the optimal solution?

## Dynamic programming

Dynamic programming starts by solving subproblems and builds up to solving the big problem.

For the knapsack problem, you'll start by solving the problem for smaller knapsacks (or "sub-knapsacks") and then work up to solving the original problem.

Every dynamic programming algorithm starts with a grid. Here's a grid for the knapsack problem:

|        | 1 | 2 | 3 | 4 |
|--------|---|---|---|---|
| GUITAR |   |   |   |   |
| STEREO |   |   |   |   |
| LAPTOP |   |   |   |   |

The rows of the grid are the items, and the columns are kanpsack weights from 1 lb to 4 lb.

### The guitar row


