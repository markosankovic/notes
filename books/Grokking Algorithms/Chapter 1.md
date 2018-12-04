# Chapter 1 Introduction to Algorithms

## Binary search

Binary search is a search algorithm that finds the position of a target value within a sorted array. Binary search compares the target value to the middle element of the array. If they are not equal, the half in which the target cannot lie is eliminated and the search continues on the remaining half, again taking the middle element to compare to the target value, and repeating this until the target value is found. If the search ends with the remaining half being empty, the target is not in the array.

Binary search runs in logarithmic time in the worst case, making *O*(log *n*) comparisons, where *n* is the number of elements in the array, the *O* is Big O notation and log is the logarithm. Binary search takes constant (*O*(1)) space, meaning that the space taken by the algorithm is the same for any number of elements in the array.

### Big O notation

#### Big O establishes a worst-case run time

The worst-case run time for binary search is O(log n).

The best-case run time for binary search could be O(1) if the target value is in the middle.

Along with the worst-case run time, it's important to look at the average-case run time.

#### Common Big O run times

Sorted from fastest to slowest:

- O(log n), also known as *log time*. Example: Binary search.
- O(n), also known as *linear time*. Example: Simple search.
- O(n * log n). Example: A fast sorting algorithm, like quicksort.
- O(n²). Example: A slow sorting algorithm, like selection sort.
- O(n!). Example: A really slow algorithm, like the traveling salesperson.

### The traveling salesperson

TSP (travelling salesman problem) asks the following question: "Given a list of cities and distances between each pair of cities, what is the shortest possible route that visits each city and returns to the origin city?". It is an NP-hard problem in combinatorial optimization, important in operations research and theoretical computer science.

### Recap

- Binary search is a lot faster than simple search.
- O(log n) is faster than O(n), but it gets a lot faster once the list of items grows.
- Algorithm speed isn't measure in seconds.
- Algorithm times are measured in terms of *growth* of an algorithm.
- Algorithm times are written in Big O notation.
