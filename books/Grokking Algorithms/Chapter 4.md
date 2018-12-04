# Chapter 4 Quicksort

## Divide & conquer

D&C is a well-known recursive technique for solving problems.

To solve a problem using D&C, there are two steps:

1. Figure out the base case. This should be the simplest possible case. Figure out a simple case as the base case.
2. Divide or decrease your problem until it becomes the base case. Figure out how to reduce your problem and get to the base case.

## Quicksort

Quicksort is a sorting algorithm that is much faster than selection sort and is frequently used. For example, the C standard library has a function called `qsort`, which is its implementation of quicksort. Quicksort also uses D&C.

## Big O notation revisited

Quicksort is unique because its speed depends on the pivot you choose.

Example algorithm:

| ALOGIRTHM  | BINARY SEARCH | SIMPLE SEARCH | QUICK SORT | SELECTION SORT | THE TRAVELING SALESMANE |
|------------|---------------|---------------|------------|----------------|-------------------------|
| ARRAY SIZE | O(log n)      | O(n)          | O(n log n) | O(n^2)         | O(n!)                   |
| 10         | 0.3sec        | 1sec          | 3.3sec     | 10sec          | 4.2days                 |
| 100        | 0.6sec        | 10sec         | 66.4sec    | 1.6min         | 2.9*10^149years         |
| 1000       | 1sec          | 100sec        | 996sec     | 27.7hours      | 1.27x10^2559years       |

Estimates based on a slow computer that performs 10 operations per second.

There's another sorting algorithm called merge sort, which is O(n log n). Much faster! Quicksort is a tricky case. In the worst case, quicksort takes O(n^2) time. It's as slow as selection sort! But that's the worst case. In the average case, quicksort takes O(n log n) time.

### Merge sort vs. quicksort

When you write Big O notation like O(n), it really means `c * n` where `c` is some fixed amount of time that your algorithm takes. It's called the *constant*. For example, it might be `10 milliseconds * n` for a function versus `1 second * n`. The *constant* is usually ignored when two algorithms have different Big O times, the constant doesn't matter.

Example:

    10ms * n for simple search O(n) is 10ms * 4 billiion = 436 days
    1sec * log n for binary search O(log n) is 1sec * 32 = 32 seconds

Sometimes the constant can make a difference. Quicksort versus merge sort is one example. Quicksort has a smaller constant than merge sort. So if they're both O(n log n) time, quicksort is faster. And quicksort is faster in practice because it hits the average case way more often than the worst case.

### Average case vs. worst case

The performace of quicksort heavily depends on the pivot you choose. If you choose the first element as the pivot for an array that is already sorted, then the call stack will get really long. For 8 elements the total height of the call stack is going to be 8. This is the worst case of O(n).

If the middle element is selected as the pivot, then the size of call stack is 4. Because you divide the array in half every time, you don't need to make as many recursive calls. You hit the base case sooner, and the call stack is much shorter. This is the best case O(log n).

If you *always choose a random element in the array as the pivot*, quicksort will complete in O(n log n) time on average. Quicksort is one of the fastest sorting algorithms.

## Recap

- D&C works by breaking a problem down into smaller and smaller pieces. If you're using D&C on a list, the base case is probably an empty array or an array with one element.
- If you're implementing quicksort, choose a random element as the pivot. The average runtime of quicksort is O(n log n)!
- The constant in Big O notation can matter sometimes. That's why quicksort is faster than merge sort.
- The constant almost never matters for simple search versus binary search, because O(log n) is so much faster than O(n) when your list gets big.
