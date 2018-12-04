# Chapter 8 Greedy Algorithm

## The classroom scheduling problem

You want to hold as many classes as possible in the classroom. How do you pick what set of classes to hold, so that you get the biggest set of classes possible?

Here's how the algorithm works:

1. Pick the class that ends the soonest.
2. Now, you have to pick a class that starts after the previous class.

A greedy algorithm is easy: at each step, pick the optimal move. In techical terms: *at each step you pick the locally optimal solution*, and in the end you're left with the globally optimal solution. Obviously, greedy algorithms doesn't always work.

## The knapsack problem

The knapsack can hold 35 pounds. You're trying to maximize the value of the items you put in your knapsack. What algorithm do you use?

The greedy strategy is pretty simple:

1. Pick the most expensive thing that will fit in your knapsack.
2. Pick the next most expensive thing that will fit in your knapsack. And so on.

Except this time, it doesn't work! However, sometimes, perfect is the enemy of good. Sometimes all you need is an algorithm that solves the problem pretty well. And that's where greedy algorithms shine, because they're simple to write and usually get pretty close.

## The set-covering problem

How do you figure out the smallest set of stations you can play on to cover all 50 states? Turns out this is extremly hard. Here's how to do it:

1. List every possible subset of stations. This is called *power set*. There are 2^n possible subsets.
2. From these, pick the set with the smallest number of stations that covers all 50 states.

The problem is, that it takes a long time to calculate every possible subset of stations. It takes O(2^n) time, because there are 2^n stations. It's possible to do if you have small set of 5 - 10 stations. But with all the examples here, think about what will happen if you have a lot of items. It takes much longer if you have more stations. Suppose you can calculate 10 subsets per second.

*There's no algorithm that solves it fast enough!* What can you do?

| NUMBER OF STATIONS | TIME TAKEN   |
|--------------------|--------------|
| 5                  | 3.2sec       |
| 10                 | 102.4sec     |
| 32                 | 13.6years    |
| 100                | 4x10^21years |

### Approximation algorithms

Greedy algorithms to the rescue! Here's greedy algorithm that comes pretty close:

1. Pick the station that covers the most states that haven't been covered yet. It's OK if the station covers some states that have been covered already.
2. Repeat until all the states are covered.

This is called an *approximation algorithm*. When calculating the exact solution will take too much time, an approximation algorithm will work. Approximation algorithms are judged by:

- How fast they are.
- How close they are to the optimal solution.

Greedy algorithms are a good choice because not only are they simple to come up with, but that simplicity means they usually run fast, too. In this case, the greedy algorithm runs in O(n^2) time, where *n* is the number of radio stations.

#### Code for setup

#### Calculating the answer

To recap:

- Sets are like lists, except sets can't have duplicates.
- You can do some interesting operations on sets, like union, intersection, and difference.

#### Back to code

|                    | O(n!)           | O(n^2)           |
|--------------------|-----------------|------------------|
| NUMBER OF STATIONS | EXACT ALGORITHM | GREEDY ALGORITHM |
| 5                  | 3.2sec          | 2.5sec           |
| 10                 | 102.4sec        | 10sec            |
| 32                 | 13.6yrs         | 102.4sec         |
| 100                | 4x10^21yrs      | 16.67min         |

## NP-complete problems

To solve the set-covering problem, you had to calculate every possible set.

With the traveling salesperson problem a salesperson has to visit five different cities. And he's trying to figure out the shortest route that will take him to all five cities. To find the shortest route, you first have to calculate every possible route. How many routes do you have to calculate for five cities?

### Traveling salesperson, step by step

#### 2 cities

Suppose you only have two cities. There are two routes to choose from:

    1. starting at marin ()--->() marin to san francisco
    2. starting at san francisco ()--->() san francisco to marin

These two routes are not necessarily the same.

#### 3 cities

There are six total routes, two for each city you can start at.

#### 4 cities

Every time you add a new city, you're increasing the number of routes you have to calculate.

| NUMBER OF CITIES |                                                          |
|------------------|----------------------------------------------------------|
| 1                | 1 route                                                  |
| 2                | 2 start cities * 1 route for each start = 2 total routes |
| 3                | 3 start cities * 2 routes = 6 total routes               |
| 4                | 4 start cities * 6 routes = 24 total routes              |
| 5                | 5 start cities * 24 routes = 120 total routes            |

There are 720 possible routes for 6 cities, 5,040 for 7 cities, 40,320 for 8 cities. This is called *factorial function*. So 5! = 120. 10! = 3,628,800. Number of possible routes becomes big very fast! This is why it's impossible to compute the "correct" solution for the traveling-salesperson problem if you have a large number of cities.

The traveling-salesperson problem and the set-covering problem both have something in common: you calculate every possible solution and pick the smallest/shortest one. Both of these problems are *NP-complete*.

Approximating the traveling salesperson: arbitrarly pick a start city. Then, each time he salesperson has to pick the next city to visit, they pick the closest unvisited city.

The short explanation of NP-completeness: some problems are famously hard to solve. The traveling salesperson and the set-covering problem are two examples. It is not possible to write an algorithm that will solve these problems quickly.

### How do you tell if a problem is NP-complete?

NP-complete problems show up everywhere! It's nice to know if the problem you're trying to solve is NP-complete. At that point, you can stop trying to solve it perfectly, and solve it using an approximation algorithm instead. But it's hard to tell if a problem you're working on is NP-complete. Usually there's a very small difference between a problem that's easy to solve and an NP-complete problem.

Here are some giveaways:

- Your algorithm runs quickly with a handful of items, but really slows down with more items.
- "All combinations of X" usually point to an NP-complete problem.
- Do you have to calculate "every possible version" of X because you can't break it down into smaller sub-problems? Might be NP-complete.
- If your problem involves a sequence (such a sequence of cities, like traveling salesperson), and it's hard to solve, it might be NP-complete.
- If your problem involves a set (like a set of radio stations) and it's hard to solve, it might be NP-complete.
- Can you restate your problem as the set-covering problem or the traveling-salesperson problem? Then your problem is definitely NP-complete.

## Recap

- Greedy algorithms optimize locally, hoping to end up with a global optimum.
- NP-complete problems have no known fast solutions.
- If you have an NP-complete problem, your best bet is to use an approximation algorithm.
- Greedy algorithms are easy to write and fast to run, so they make good approximation algorithms.
