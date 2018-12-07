# Chapter 9 Dynamic Programming

Dynamic programming is a technique to solve hard problems by breaking it up into subproblems and solving those subproblems first.

## The knapsack problem

The approximate solution will be close to the optimal solution, but it may not be the optimal solution. How do you calculate the optimal solution?

- STEREO: $3000 4lbs
- LAPTOP: $2000 3lbs
- GUITAR: $1500 1lbs

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

|        | 1       | 2 | 3 | 4 |
|--------|---------|---|---|---|
| GUITAR | $1500 G |   |   |   |
| STEREO |         |   |   |   |
| LAPTOP |         |   |   |   |

|        | 1       | 2       | 3 | 4 |
|--------|---------|---------|---|---|
| GUITAR | $1500 G | $1500 G |   |   |
| STEREO |         |         |   |   |
| LAPTOP |         |         |   |   |

|        | 1       | 2       | 3       | 4       |
|--------|---------|---------|---------|---------|
| GUITAR | $1500 G | $1500 G | $1500 G | $1500 G |
| STEREO |         |         |         |         |
| LAPTOP |         |         |         |         |

This is the first row so there is *only* the guitar to choose from.

*This row represents the current best guess for this max.*

### The stereo row

|        | 1       | 2 | 3 | 4 |
|--------|---------|---|---|---|
| GUITAR | $1500 G |   |   |   |
| STEREO | $1500 G |   |   |   |
| LAPTOP |         |   |   |   |

|        | 1       | 2       | 3       | 4       |
|--------|---------|---------|---------|---------|
| GUITAR | $1500 G | $1500 G | $1500 G | $1500 G |
| STEREO | $1500 G | $1500 G | $1500 G | $3000 S |
| LAPTOP |         |         |         |         |

### The laptop row

|        | 1       | 2       | 3       | 4       |
|--------|---------|---------|---------|---------|
| GUITAR | $1500 G | $1500 G | $1500 G | $1500 G |
| STEREO | $1500 G | $1500 G | $1500 G | $3000 S |
| LAPTOP | $1500 G | $1500 G | $2000 L |         |

The laptop weighs only 3 lb, so you have 1 lb free! You could put something in this 1 lb.

    $3000 vs ($2000 + ??? 1 lb of free space)
    $3000 vs ($2000 + $1500)

|        | 1       | 2       | 3       | 4         |
|--------|---------|---------|---------|-----------|
| GUITAR | $1500 G | $1500 G | $1500 G | $1500 G   |
| STEREO | $1500 G | $1500 G | $1500 G | $3000 S   |
| LAPTOP | $1500 G | $1500 G | $2000 L | $3500 L G |

There's the answer: the maximum value that will fit in the knapsack is $3,500, made up of a guitar and a laptop!

Each cell's value gets calculated with the same formula:

    cell[i][j] = maxof {
      1. the previous max (value at cell [i-1][j])
      VS
      2. value of current item + value of the remaining space cell[i-1][j-item's weight]
    }

## Knapsack problem FAQ

### What happens if add an item?

You don't have to recalculate everything to account for the new item. Dynamic programming keeps progressively building on the estimate.

The value of a column can never go down. At every iteration, you're storing the current max estimate. The estimate can never get worse than it was before.

### What happens if you chnage the order of the rows?

The answer doesn't change. The order of the rows doesn't matter.

### Can you fill in the grid column-wise instead of row-wise?

For this problem, it doesn't make a difference. It could make a difference for other problems.

### What happens if you add a smaller item?

Suppose you can steal a necklace. It weighs 0.5 lb, and it's worth $1,000. Because of the necklace, you have to account for finer granularity, so the grid has to change.

### Can you steal fractions of an item?

With the dynamic-programming solution, you either take the item or not. There's no way for it to figure out that you should take half an item.

But this case is also easily solved using a greedy algorithm! First, take as much as you can of the most valuable item. When that runs out, take as much as you can of the next most valuable item, and so on.

### Optimizing your travel itinerary

### Handling items that depend on each other

Dynamic programming is powerful because it can solve subproblems and use those answers to solve the big problem. Dynamic programming only works when each subproblem is discrete—when it doesn't depend on other subproblems.

### Is it possible that the solution will require more than two sub-knapsacks?

It's possible that the best solution involves stealing more than two items. The way the algorithm is set up, you're combining two knapsacks at most—you’ll never have more than two sub-knapsacks. But it's possible for those sub-knapsacks to have their own sub-knapsacks

### Is it possible that the best solution doesn't fill the knapsack completely?

Yes.

## Longest common substring

Dynamic programming takeaways:

- Dynamic programming is useful *when you're trying to optimize something given a contraint*.
- You can use dynamic programming when the problem can be broken into discrete subproblems, and they don't depend on each other.

It can be hard to come up with a dynamic-programming solution. Some general tips follow:

- Every dynamic programming solution involves a grid.
- The values in the cells are usually what you're trying to optimize. For the knapsack problem, the values were the values of the goods.
- Each cell is a subproblem, so think about how you can divide your problem into subproblems. That will help you figure out what the axis are.

Suppose you run dictionary.com. Someone types in a word, and you give them the definition. But if someone misspells a word, you want to be able to guess what word they meant. Alex is searching for fish, but he accidentally put in hish. That's not a word in your dictionary, but you have a list of words that are similar.

Alex typed hish. Which word did Alex mean to type: fish or vista?

### Making the grid

What does the grid for this problem look like? You need to answer these questions:

- What are values of the cells?
- How do you divide this problem into subproblems?
- What are the axes of the grid?

In dynamic programming, you're trying to *maximize* something. In this case, you're trying to find the longest substring that two words have in common. What substring do *hish* and *fish* have in common? How about *hish* and *vista*?

The values for the cells are usually what you're trying to optimize. In this case, the values will probably be a number: the length of the longest substring that the two strings have in common.

|   | H | I | S | H |
|---|---|---|---|---|
| F |   |   |   |   |
| I |   |   |   |   |
| S |   |   |   |   |
| H |   |   |   |   |

### Filling in the grid

The *Feynman algorithm*:

1. Write down the problem.
2. Think really hard.
3. Write down the solution.

The truth is, there's no easy way to calculate the formula here. You have to experiment and try to find something that works. Sometimes algorithms aren't an exact recipe. They're a framework that you build your idea on top of.

### The solution

|   | H | I | S | H |
|---|---|---|---|---|
| F | 0 | 0 | 0 | 0 |
| I | 0 | 1 | 0 | 0 |
| S | 0 | 0 | 2 | 0 |
| H | 0 | 0 | 0 | 3 |

    if word_a[i] === word_b[j]: # the latters match
        cell[i][j] = cell[i-1][j-1] + 1
    else: # the letters don't match
        cell[i][j] = 0

One thing to note: for this problem, the final solution may not be in the last cell!

### Longest common subsequence - solution

    if word_a[i] === word_b[j]: # the latters match
        cell[i][j] = cell[i-1][j-1] + 1
    else: # the letters don't match
        cell[i][j] = max(cell[i-1][j], cell[i][j-1]])

When is dynamic programming used:

- Biologists use the longest common subsequence to find similarities in DNA strands. They can use this to tell how similar two animals or two diseases are. The longest common subsequence is being used to find a cure for multiple sclerosis.
- Have you ever used diff (like `git diff`)? Diff tells you the differences between two files, and it uses dynamic programming to do so.
- We talked about string similarity. *Levenshtein distance* measures how similar two strings are, and it uses dynamic programming. Levenshtein distance is used for everything from spell-check to figuring out whether a user is uploading copyrighted data.
- Have you ever used an app that does word wrap, like Microsoft Word? How does it figure out where to wrap so that the line length stays consistent? Dynamic programming!

## Recap

- Dynamic programming is useful when you're trying to optimize something given a constraint.
- You can use dynamic programming when the problem can be broken into discrete subproblems.
- Every dynamic-programming solution involves a grid.
- The values in the cells are usually what you're trying to optimize.
- Each cell is a subproblem, so think about how you can divide your problem into subproblems.
- There's no single formula for calculating a dynamic-programming solution.
