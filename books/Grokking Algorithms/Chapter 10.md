# Chapter 9 k-nearest neighbors

## Classifying oranges vs. grapefruit

More neighbors are oranges than grapefruit. So this fruit is probably an orange. Congratulations: You just used the k-nearest neighbors (KNN) algorithm for classification! The whole algorithm is pretty simple.

1. You get a new fruit to classify.
2. You look at its three nearest neighbors.
3. More neighbors are oranges, so this is probably an orange.

If you’re trying to classify something, you might want to try KNN first.

## Building a recommendations system

You want to build a movie recommendations system for your users. On a high level, this is similar to the grapefruit problem!

You can plot every user on a graph.

These users are plotted by similarity, so users with similar taste are plotted closer together. Suppose you want to recommend movies to a user, find the five users closest to him.

How do you figure out how similar two users are?

### Feature extraction

In the grapefruit example, you compared fruit based on how big they are and how red they are. Size and color are the *features* you're comparing. Now suppose you have three fruit. You can extract features.

|         | A | B | C |
|---------|---|---|---|
| SIZE    | 2 | 2 | 4 |
| REDNESS | 2 | 1 | 5 |

Then you can graph the three fruit.

From the graph you can tell visually that fruits A and B are similar. Let's measure how close they are. To find the distance between the two points, you use the Pythagorean formula.

    sqrt((x1-x2)^2 + (y1-y2)^2)

The distance between A and B is 1. You can find the rest of distances:

    A-B 1
    A-C sqrt(13)
    B-C 2*sqrt(5)

The distance formula confirms what you saw visually: fruits A and B are similar.

You need to convert each user to a set of coordinates, just as you did for fruit.

Once you can graph users, you can measure the distance between them.

Have users rate some categories of moviews based on how much they like those categories.

If there are five categories, instead of calculating the distance in two dimensions, you're now calculating the distance in *five* dimensions, but the distance formula stays the same.

    sqrt((a1-a2)^2 + (b1-b2)^2 + (c1-c2)^2 + (d1-d2)^2 + (e1-e2)^2)

It just involves a set of five numbers instead of a set of two numbers.

The distance formula is flexible: you could have a set of a *million* numbers and still use the same old distance formula to find the distance. The distance tells you how similar those sets of numbers are.

The more movies you rate, the more accurately a recommendation system can see what other users you're similar to.

### Regression

Suppose you want to do more than just recommend a movie: you want to guess how a user will rate this movie. Take five people closest to him.

Let's say the five closest users rated a movie: 5, 4, 4, 5, 3. You could take the average of their ratings and get 4.2 stars. That's called *regression*.

The two basic things to do with KNN is:

* Classification = categorization into a group
* Regression = predicting a response (like a number)

#### Cosine similarity

Suppose two users are similar, but one of them is more conservative in their ratings. One user rated the same movie 5, while the other user rated it 4 stars. If you keep using the distance formula, these two users might not be each other's neighbors, even though they have similar taste.

Cosine similarity doesn't measure the distance between two vectors. Instead, it compares the angles of the two vectors. It's better at dealing with cases like this.

### Picking good features

When you're working with KNN, it's really important to pick the right features to compare against. Picking the right features means:

* Features that directly correlate to the movies you're trying to recommend.
* Features that don't have a bias (for example, if you ask the users to only rate comedy movies, that doesn't tell you whether they like action movies).

## Introduction to machine learning

KNN is a really useful algorithm, and it’s your introduction to the magical world of machine learning! Machine learning is all about making your computer more intelligent.

### OCR

OCR Stands for *optical character recognition*. Use can use KNN to figure out what number is on an image:

1. Go through a lot of numbers, and extract features of those numbers.
2. When you get a new image, extract the features of that image, and see what its nearest neighbors are.

It's the same problem as oranges versus grapefruit. Generally speaking, OCR algorithms measure lines, points and curves.

Feature extraction is a lot more complicated in OCR than the fruit example. But it’s important to understand that even complex technologies build on simple ideas, like KNN. You could use the same ideas for speech recognition or face recognition.

The first step of OCR, where you go through images of numbers and extract features, is called *training*. Most machine-learning algorithms have a training step: before your computer can do the task, it must be trained.

### Building a spam filter

Spam filters use another simple algorithm called the *Naive Bayes classifier*. First, you train your Naive Bayes classifier on some data.

### Predicting the stock market

This is hard to do with machine learning: predicting whether the stock market will go up or down. How do you pick good features in a stock market?

## Recap

* KNN is used for classification and regression and involves looking at the k-nearest neighbors.
* Classification = categorization into a group.
* Regression = predicting a response (like a number).
* Feature extraction means converting an item (like a fruit or a user) into a list of numbers that can be compared.
* Picking good features is an important part of a successful KNN algorithm.
