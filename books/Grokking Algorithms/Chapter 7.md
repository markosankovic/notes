# Chapter 7 Dijkstra's Algorithm

Breadth-first search will find you the path with the fewest segments. Use the Dijkstra's algorithm instead to find the fastest path.

Dijkstra's algorithm runs on the weighted graphs. Weighted graphs are a way to assign more or less weight to some edges.

## Working with Dijkstra's algorithm

There are four steps to Dijkstra's algorithm:

1. Find the "cheapest" node. This is the node you can get to in the least amount of time.
2. Update the costs of the neighbors of this node.
3. Repeat until you've done this for every node in the graph.
4. Calculate the final path.

## Terminology

When you work with Dijkstra's algorithm, each edge in the graph has a number associated with it. These are called *weights*.

A graph with weights is called a *weighted graph*. A graph without weights is called an *unweighted graph*.

To calculate the shortest path in an unweighted graph, use breadth-first search. To calculate the shortest path in a weighted graph, use Dijkstra's algorithm.

Graphs can have *cycles*. It means you can start at a node, travel around, and end up at the same node. Following cycles will never give you the shortest path.

Dijkstra's algorithm only works with *directed acyclic graphs*, called DAGs for short.

## Trading for a piano

The shortest path doesn't have to be about physical distance. It can be about minimizing something.

## Negative-weight edges

You can't use Dijkstra's algorithm if you have negative-weight edges. Negative-weight edges break the algorithm. If you want to find the shortest path in a graph that has negative-weight edges, there's an algorithm for that! It’s called the *Bellman-Ford algorithm*.

## Implementation

## Recap

- Breadth-first search is used to calculate the shortest path for an unweighted graph.
- Dijkstra's algorithm is used to calculate the shortest path for a weighted graph.
- Dijkstra's algorithm works when all the weights are positive.
- If you have negative weights, use Bellman-Ford algorithm.
