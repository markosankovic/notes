# Chapter 6 Breadth-First Search

Breadth is the distance or measurement from side to side of something; width.

Breadth-first search allows you to find the shortest distance between two things. You can use breadth-first search to:

- Write a checkers AI that calculates the fewest moves to victory.
- Write a spell checker (fewest edits from your misspelling to a real workd - for example, READED -> READER is one edit).
- Find the doctor closes to you in your network.

## Introduction to graphs

The *shortest-path problem* is a type of problem for finding the shortest something e.g. shortest route to a friend's house, the smallest number of moves to checkmate in a game of chess. The algorithm to solve a shortest-path problem is called *breadth-first search*.

To figure out how to get from Twin Peaks to the Golden Gate Bridge, there are two steps:

1. Model the problem as a graph.
2. Solve the problem using breadth-first search.

## What is a graph?

A graph models a set of connections.

    (Ivana)-[:OWNS]->(Marko)

Graphs are made up of nodes and edges. A node can be directly connected to many other nodes. Those nodes are called its *neighbors*.

## Breadth-first search

Breadth-first search is an alogorithm that runs on graphs. It helps to answer two types of questions:

- Question type 1: Is there a path from node A to node B?
- Question type 2: What is the shortest path from node A to node B?

### Is there a path

Does a friend or a friend of friends are mango sellers. Is there a mango seller in my network? Each time your search for someone from the list of immediate friends, add all of their friends to the list. With this algorithm, you'll search your entire network until you come across a mango seller. This algorithm is breadth-first search.

### Finding the shortest path

Your friends are first-degree connections, and their friends are second-degree connections.You'd prefer a first-degree connection to a second-degree connection, and a second-degree connection to a third-degree connection, and so on. So you shouldn't search any second-degree connections before you make sure you don't have a first-degree connection who is a mango seller. Breadth-first search already does this! The way breadth-first search works, the search radiates out from the starting point. So you'll check first-degree connections before second-degree connections.

First-degree connections are added to the search list before second-degree connections. A data structure is used for this: it's called *a queue*.

### Queues

A queue works exactly like it does in real life. Queues are similar to stacks. You can't access random elements in the queue. Instead, there are two only opeartions, *enqueue* and *dequeue*. If you enqueue two items to the list, the first item you added will be dequeued before the second item. The queue is called a FIFO data structure: First In, First Out. In contrast, a stack is a LIFO data structure: Last In, First Out.

## Implementing the graph

A graph consists of several nodes and nodes are connected to neighboring nodes. Use a hash table to express a relationship like "Ivana -> Marko". Hash table allows you to map a key to a value. In Python:

    graph = {}
    graph['marko'] = ['peđa', 'ivan', 'milan']

There are two types of graphs:

- Directed graph: (node1)-[]->(node2)
- Undirected graph: (node1)-[]-(node2)

## Implementing the algorithm

### Running time

The running time is at least O(number of edges). Also, adding one person to the searched queue takes constant time: O(1). Doing this for every person will take O(number of people) total. Breadth-first search takes O(number of
people + number of edges), and it's more commonly written as O(V + E) (V for number of vertices, E for number of edges.

## Exercise

If task A depends on task B, task A shows up later in the list. This is called a *topological sort*, and it’s a way to make an ordered list out of a graph.

A *tree* is a special type of graph, where no edges ever point back. Family tree is a type of tree graph.

## Recap

- Breadh-first search tells you if there's path from A to B.
- It there's a paht, breadth-first search will find the shortest path.
- If you have a problem like "find the shortest X", try modeling your problem as a graph and use breadth-first search to solve.
- A directed graph has arrows, and the relationship follows the direction of the arrow (rama -> adit means "rama owes adit money").
- Unidirected graphs don't have arrows, and the relationship goes both ways (ross - rachel means "ross dated rachel and rachel dated ross").
- Queues are FIFO (First In, First Out).
- Stacks are LIFO (Last In, First Out).
- You need to check people in the order they were added to the search list, so the search list needs to be a queue. Otherwise, you won't get the shortest path.
- Once you check someone, make sure you don't check them again. Otherwise, you might end up in an infinite loop.
