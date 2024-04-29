INCLUDE intlist.ink

~temp x = "" // empty string = empty list
Pushing 2, 44, 6 (note: DO NOT push invalid values)
~L_push(x,2)
~L_push(x,44)
~L_push(x,6)

Peek: {L_peek(x)}
Length: {L_length(x)}
Accessing index 0 (bottom of stack): {L_get(x,0)}
Popping all 3 values:
{L_pop(x)}
{L_pop(x)}
{L_pop(x)}
Out-of-bounds error code when popping from empty stack:
{L_pop(x)}
