# Chapter 11 Where to Go Next

Brief overview of 10 algorithms that weren't convered in this book.

## Trees

The idea behind the *binary search tree* data structure is to insert an element into the right slot in the array right away, so that array doesn't have to be sorted afterwards for doing the binary search.

Fo every node, the nodes to its left are *smaller* in value, and the nodes to the right are *larger* in value.

Searching for an element in a binary search tree takes O(log n) time *on average* and O(n) time in the *worst case*. Searching a sorted array takes O(log n) time in the *worst case*, so you might think a sorted array is better. But a binary search tree is a lot faster for insertions and deletions on average.

|        | ARRAY    | BINARY SEARCH TREE |
|--------|----------|--------------------|
| SEARCH | O(log n) | O(log n)           |
| INSERT | O(n)     | O(log n)           |
| DELETE | O(n)     | O(log n)           |

Binary search trees have some downsides to: for one thing, you don't get random access. You can't say, "Give me the fifth element of this tree." Those performance times are also on *average* and rely on the tree being balanced. There are special binary search trees that balance themselves. One example is the red-black tree.

*B-trees*, a special type of binary tree, are commonly used to store data in databases.

If you are interested in databases or more-advanced data structures, check these out:

- B-trees
- Red-black trees
- Heaps
- Splay trees

## Inverted indexes

## The Fourier transform

The Fourier transform is one of those rare algorithms: brilliant, elegant, and with a million use cases. The best analogy for the Fourier transform comes from Better Explained: given a smoothie, the Fourier transform will tell you the ingredients in the smoothie. Or, to put it another way, given a song, the transform can separate it into individual frequencies.

Fourier transform is great for processing signals. You can use it to separate a song into frequencies, you can boost the ones you care about, you can use it to compress music. People use the Fourier transform to try to predict upcoming earthquakes and analyze DNA.

## Parallel algorithms

Laptops and computers ship with multiple cores. To make your algorithm faster, you need to change them to run in parallel across all the cores at once!

The best you can do with a sorting algorightm is roughly O(n log n). It's well known that you can't sort an array in O(n) time - *unless you use a parallel algorithm*! There's a parallel version of quicksort that will sort an array in O(n) time.

Parallel algorithms are hard to design. One thing is for sure - the time gains aren't linear. So, if you have two cores in your laptop instead of one, that almost never means your algorithm will magically run twice as fast. There are a couple of reasons for this:

- *Overhead of managing the parallelism* - Suppose you have to sort an array of 1,000 items. How do you divide this task among the two cores? Merging the two arrays takes time.
- *Load balancing* - Suppose you have 10 tasks to do, so you give each core 5 tasks. But core A gets all easy tasks, so it's done in 10 seconds, whereas core B gets all the hard tasks, to it takes a minute. How do you distribute the work evenly so both cores are working equally hard?

## MapReduce

There's a special type of parallel algorithm that is becoming increasingly popular: the *distributed algorithm*. It's fine to run a parallel algorithm on your laptop if you need two to four cores, but what if you need hundreds of cores? Then you can write your algorithm to run across multiple machines. The MapReduce algorithm is a popular distributed algorithm. You can use it through the popular open source tool Apache Hadoop.

### Why are distributed algorithms useful?

Suppose you have a table with billions or trillions of rows, and you want to run a complicated SQL query on it. You can't run it on MySQL, because it struggles after a few billion rows. Use MapReduce through Hadoop!

Suppose you have to process a long list of jobs. Each job takes 10 seconds to process, and you need to process 1 million jobs like this. If you do this on one machine, it will take you months! If you could run it across 100 machines, you might be done in a few days.

### The map function

The `map` function takes an array and applies the same function to each item in the array. For example:

    arr1 = [1, 2, 3, 4, 5]
    arr2 = map(lambda x: 2 * x, arr1)
    [2, 4, 6, 8, 10]

Suppose you apply a function that takes more time to process. The pseudocode:

    arr1 = # a list of URLs
    arr2 = map(download_page, arr1)

This could take a couple of seconds for each URL. If you had 1,000 URLs, this might take a couple of hours!

You could spread out the work across 100 machines. Then you would be downloading 100 pages at a time, and the work would go a lot faster! This is the idea behind "map" in MapReduce.

### The reduce function

The idea is that you "reduce" a whole list of items down to one item. The example:

    arr1 = [1, 2, 3, 4, 5]
    reduce(lambda x,y: x+y, arr1)
    15

MapReduce uses these two simple concepts to run queries about dat across multiple machines. When you have a large dataset (billions of rows), MapReduce can give you an answer in minutes where a traditional database might take hours.

## Bloom filters and HyperLogLog

These are probabilistic algorithms!

- You need to figure out whether a link has been posted before (Reddit).
- You want to crawl a web page if you haven't crawled it already (Google).
- You need to figure out whether you're redirecting user to a URL of malicous website (bit.ly).

All of these problems have the same problem: very large set.

You could use hash for search where the average lookup time is constant O(1). The problem is that hash has to be *huge*. Google indexes trillions of web pages. Storing all thoses hashes would take up a lot of space.

### Bloom filters

Bloom filters offer a solution. Bloom filters are *probabilistic data structures*. They give you an answer that could be wrong but is probably correct. A hash table would give you an accurate answer.

- False positives are possible. Google might say, "You've already crawled this site", even though you haven't.
- False negatives aren't possible. If the bloom filter says, "You haven't crawled this site", then you *definitely* haven't crawled this site.

Bloom filters are great because they take up very little space. They are greate when you don't need an exact answer.

### HyperLogLog

Suppose Google wants to count the number of *unique* searches performed by its users. Or suppose Amazon wants to count the number of unique items that users looked at today. Answering these questions takes a lot of space!

HyperLogLog approximates the number of unique elements in a set. Just like bloom filters, it won't give you an exact answer, but it comes very close and uses only a fraction of the memory a task like this would otherwise take.

## The SHA algorithms

The hash function takes a string and gives you back the slot number for that string. You want hash function to give you a good distribution.

### Comparing files

Another hash function is a secure hash algorithm (SHA) function. Give a string, SHA gives you a hash for that string. SHA is a *hash function*. It generates a *hash*, which is just a short string. The hash function for hash tables went from string to array index, whereas SHA goes from string to string. SHA generates a different hash for every string.

You can use SHA to tell whether two files are the same.

### Checking passwords

SHA is also useful when you want to compare strings without revealing what the original string was.

SHA is actually a family of algorithms: SHA-0, SHA-1, SHA-2 and SHA-3.

## Locality-sensitive hashing

SHA has another important feature: it's locality insensitive. Suppose you have a string, and you generate a hash for it:

    dog -> cd6357

If you change just one character of the string and regenerate the hash, it's totally different!

    dot -> e392da

This is good because an attacker can't compare hashes to see whether they're close to cracking a password.

Sometimes, you want the opposite: you want a locality-sensitive hash function. That's where *Simhash* comes in. If you make a small change to a string, Simhash generates a hash that's only a little different. This allows you to compare hashes and see how similar two strings are, which is pretty useful.

- Google uses Simhash to detect duplicates while crawling the web.
- A teacher could use Simhash to see whether a stundent was copying an essay from the web.

Simhash is useful when you want to check for similar items.

## Diffie-Hellman key exchange

The *Diffie-Hellman algorithm* deserves a mention here, because it solves an age-old problem in an elegant way. How do you encrypt a message so it can only be read by the person you sent the message to?

Diffie-Hellman solves two problems:

- Both parties don't need to know the cipher. So we don't have to meet and agree to what the cipher should be.
- The encrypted messages are *extremely* hard to decode.

Diffie-Hellman has two keys: a public key and a private key. The public key is exactly that: public. You can post it on your website, email it to friends, or do anything you want with it. You don't have to hide it. When someone wants to send you a message, they encrypt it using the public key. An encrypted message can only be decrypted using the private key. As long as you're the only person with the private key, only you will be able to decrypt this message!

The Diffie-Hellman algorithm is still used in practice, along with its successor, RSA.

## Linear programming

Linear programming is used to maximize something given some constraints. For example, suppose your company makes two products, shirts and totes. Shirts need 1 meter of fabric and 5 buttons. Totes need 2 meters of fabric and two buttons. You have 11 meters of fabric and 20 buttons. You make $2 per shirt and $3 per tote. How many shirts and totes should you make to maximize your profit?

Here you're trying to maximize profit, and you're constrained by the amount of materials you have.

All the graph algorithms can be done through linear programming instead. Linear programming is a much more general framework, and graph problems are a subset of that.

Linear programming uses the Simplex algorithm. It's a complex algorithm, which is why I didn't include it in this book. If you're interested in optimization, look up linear programming!

## Epilogue
