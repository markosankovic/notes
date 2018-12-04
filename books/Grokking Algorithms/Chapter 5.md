# Chapter 5 Hash Tables

## Hash functions

A hash function is a function where you put in a string and you get back a number.

    "Holla" => 4
    "Hello" => 2

Requirements for a hash function are:

- It needs to be consistent. For the same input it gives back the same output.
- It should map different words to different numbers.

Hash function maps strings to numbers and it's used for making hash tables.

- The hash function consistently maps a string to the same index.
- The hash function maps different strings to different indexes.
- The hash function knows how big your array is and only returns valid indexes.

Basically, putting a hash function and an array together makes a data structure called a *hash table*. Unlike arrays and lists that map straight to memory, hash tables has some extra logic. Hash tables are the most useful complex data structure. They're also known as hash maps, maps, dictionaries and associative arrays. Hash tables are fast.

### Recap

Hashes are good for:

- Using hash tables for lookups. Modeling relationships from one thing to another thing.
- Preventing duplicate entries. Filtering out duplicates.
- Using hash tables as a cache. Caching/memorizing data instead of making servers do work.

## Collisions

It is almost impossible to write a hash function that always maps different keys to different slots in the array.

Suppose your array contains 26 slots and the hash function is really simple: it assigns a slot in the array alphabetically. If you put a price of apples and then avocados the *collision* will happen: two keys have been assigned the same slot. There are multiple ways to avoid collisions. The simplest one is this: if multiple keys map to the same slot, start a linked list at that slot. The problem with this approach is that if there are only a couple of slots used, the hash tables becomes a linked list.

Hash functions are really important. A good hash function will give you very few collisions.

## Performance

In the average case, hash tables take O(1) for everything. O(1) is called *constant time*. It doesn't mean instant. It means the time taken will stay the same, regardless of how big the hash table is. In the worst case, a hash tables takes O(n) - linear time - for everything, which is really slow.

|        | HASH TABLE (average) | HASH TABLES (worst) | ARRAYS | LINKED LISTS |
|--------|:--------------------:|:-------------------:|--------|--------------|
| SEARCH |         O(1)         |         O(n)        |  O(1)  |     O(n)     |
| INSERT |         O(1)         |         O(n)        |  O(n)  |     O(1)     |
| DELETE |         O(1)         |         O(n)        |  O(n)  |     O(1)     |

Look at the average case for hash tables. Hash tables are as fast as arrays at searching (getting a value at an index). And they're as fast as linked lists at inserts and deletes. It's the best of both worlds! But in the worst case, hash tables are slow at all of those. So it's important that you don't hit worst-case performance with hash tables. And to do that, you need to avoid collisions. To avoid collisions, you need

- A low load factor
- A good hash function

### Load factor

    Load factor = Number of items in hash table / Total number of slots

    Load factor < 0: there are free slots left
    Load factor = 0: all slots are taken
    Load factor > 0: there are more items than slots

Once the load factor starts to grow, you need to add more slots to your hash table. This is called *resizing*. The rule of thumb is to make an array that is twice the size.

### A good hash function

A good hash function distributes values in the array evenly.
A bad hash function groups values together and produces a lot of collisions.

It's important for hash functions to have a good distribution. They should map items as broadly as possible. The worst case is a hash function that maps all items to the same slot in the hash table.

## Recap 2

- You can make a hash table by combining a hash function with an array.
- Collisions are bad. You need a hash function that minimizes collisions.
- Hash tables have really fast search, insert and delete.
- Hash tables are good for modeling relationships from one item to another item.
- Once your load factor is greater than 0.7, it's time to resize your hash table.
- Hash tables are used for caching data (for example, with a web server).
- Hash tables are great for catching duplicates.
