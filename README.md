# True Int Lists in Ink

A small pure-[Ink](https://www.inklestudios.com/ink/) implementation of lists of integers in the *normal* sense, rather than Ink's native "lists."

The lis is stored as a string, using Ink's extremely limited string functionality, so the runtimes are insane and depend on the size of the largest integer currently stored in the list.  There are plenty of situations where this should be fine for prototyping or as an external function fallback, but in production code, please just use external functions.

I have not yet implemented *setting/removing* at arbitrary indices, so it's currently just a **stack** rather than a list.  But full list-ness is coming eventually.  Maybe.

# Usage
See `test_example.ink`
```
INCLUDE intlist.ink

~temp x = "" // empty string = empty list
~L_push(x,2)
~L_push(x,44)
~L_push(x,6)

Peek: {L_peek(x)}
Length: {L_length(x)}
Accessing index 0 (bottom of stack): {L_get(x,0)}
Pop:
{L_pop(x)}
{L_pop(x)}
{L_pop(x)}
Out-of-bounds error code when popping from empty stack:
{L_pop(x)}

```

# Other Notes
ALL inserted values must be integers between 0 and `L_MAX_INT (256 by default)`.
Peek/get is `O(MAX*n)`
Push is `O(n)`
Pop is `O(MAX*n^2)`
Note that for all of these, `MAX` refers to the largest int *actually present in the list currently*, not the defined `L_MAX_INT` constant.  So it'll run faster when all the values stored in the list are small.

# Features still to implement:
 - set at arbitrary index
 - remove from arbitrary index
 - check for validity of values (i.e. only integers) when inserting
 - support Ink list items as arguments instead of integers
