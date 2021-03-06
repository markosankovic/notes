# Chapter 3 Recursion

Every recursive function has two parts: the base case and the recursive case. The recursive case is when the function calls itself. The base case is when the function doesn't call itself again... so it doesn't go into an infinite loop.

https://stackoverflow.com/questions/33923/what-is-tail-recursion
https://stackoverflow.com/questions/310974/what-is-tail-call-optimization

## The stack

Using recursion can take a lot of memory for stack. Each of function calls takes up some memory. The way to improve is to:

- Rewrite code to use a loop instead.
- Use *tail recursion*.

Consider a simple function that adds the first N integers. (e.g. sum(5) = 1 + 2 + 3 + 4 + 5 = 15).

Here is a simple JavaScript implementation that uses recursion:

    function recsum(x) {
        if (x===1) {
            return x;
        } else {
            return x + recsum(x-1);
        }
    }

If you called recsum(5), this is what the JavaScript interpreter would evaluate:

    recsum(5)
    5 + recsum(4)
    5 + (4 + recsum(3))
    5 + (4 + (3 + recsum(2)))
    5 + (4 + (3 + (2 + recsum(1))))
    5 + (4 + (3 + (2 + 1)))
    15

Note how every recursive call has to complete before the JavaScript interpreter begins to actually do the work of calculating the sum.

Here's a tail-recursive version of the same function:

    function tailrecsum(x, running_total=0) {
        if (x===0) {
            return running_total;
        } else {
            return tailrecsum(x-1, running_total+x);
        }
    }

Here's the sequence of events that would occur if you called tailrecsum(5), (which would effectively be tailrecsum(5, 0), because of the default second argument).

    tailrecsum(5, 0)
    tailrecsum(4, 5)
    tailrecsum(3, 9)
    tailrecsum(2, 12)
    tailrecsum(1, 14)
    tailrecsum(0, 15)
    15

In the tail-recursive case, with each evaluation of the recursive call, the running_total is updated.

In traditional recursion, the typical model is that you perform your recursive calls first, and then you take the return value of the recursive call and calculate the result. In this manner, you don't get the result of your calculation until you have returned from every recursive call.

In tail recursion, you perform your calculations first, and then you execute the recursive call, passing the results of your current step to the next recursive step. This results in the last statement being in the form of (return (recursive-function params)). Basically, the return value of any given recursive step is the same as the return value of the next recursive call.

The consequence of this is that once you are ready to perform your next recursive step, you don't need the current stack frame any more. This allows for some optimization. In fact, with an appropriately written compiler, you should never have a stack overflow snicker with a tail recursive call. Simply reuse the current stack frame for the next recursive step. I'm pretty sure Lisp does this.

## Recap

- Recursion is when function calls itself.
- Every recursive function has two cases: the base case and the recursive case.
- A stack has two operations: push and pop.
- All function calls go onto the call stack.
- The call stack can get very large, which takes up a lot of memory.
