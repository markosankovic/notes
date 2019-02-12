# GraphQL

## Learn

### Introduction to GraphQL

GraphQL is a query language for your API, and a server-side runtime for executing queries by using a type system you define for your data. GraphQL isn't tied to any specific database or storage engine and is instead backed by your existing code and data.

A GraphQL service is created by defining types and fields on those types, then providing functions for each field on each type. For example, a GraphQL service that tells us who the logged in user is (me) as well as that user's name migh look something like this:

    type Query {
      me: User
    }

    type User {
      id: ID
      name: String
    }

Along with functions for each field on each type:

    function Query_me(request) {
      return request.auth.user;
    }

    function User_name(user) {
      return user.getName();
    }

Once a GraphQL service is running (typically at a URL on a web service), it can be sent GraphQL queries to validate and execute. A received query is first checked to ensure it only refers to the types and fields defined, then runs the provided functions to produce a result.

For example the query:

    {
      me {
        name
      }
    }

Could produce the JSON result:

    {
      "me": {
        "name": "Luke Skywalker"
      }
    }

### Queries and Mutations

#### Fields

At its simplest, GraphQL is about asking for specific fields on objects. Let's start by looking at a very simple query and the result we get when we run it:

    {
      hero {
        name
      }
    }

    {
      "data": {
        "hero": {
          "name": "R2-D2"
        }
      }
    }

You can see immediatelly that the query has exactly the same shape as the result. This is essential to GraphQL, because you always get back what you expect, and the server knows exactly what fields the client is asking for.

The field `name` returns a `String` type, in this case the name of the main hero of Star Wars, "R2-D2".

In the previous example, we just asked for the name of our hero which returned a String, but fields can also refer to Objects. In that case, you can make _sub-selection_ of fields for that object. GraphQL queries can traverse related objects and their fields, letting clients fetch lots of related data in one request, instead of making several roundtrips as one would need in a classic REST architecture.

    {
      hero {
        # Queries can have comments!
        friends {
          name
        }
      }
    }

    {
      "data": {
        "hero": {
          "name": "R2-D2",
          "friends": [
            {
              "name": "Luke Skywalker"
            },
            {
              "name": "Han Solo"
            },
            {
              "name": "Leia Organa"
            }
          ]
        }
      }
    }

Note that in this example, the `friends` field returns an array of items. GraphQL queries look the same for both single items or lists of items, however we know which one to expect based on what is indicated in the schema.

#### Arguments

#### Fragments

#### Operation name

#### Variable

#### Directives

#### Mutations

#### Inline Fragments
