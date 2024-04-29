// arbitrary-length LIFO stack storing integer values between 0 and MAX_INT
CONST L_MAX_INT = 256 // Note: the bigger this is, the slower operations are!
// Error values (error checking on L_push not implemented)
CONST L_OUT_OF_BOUNDS = -1
CONST L_INVALID_VALUE = -2

//-> test_example
=== test_example ===

~temp x = "" // empty string = empty list
Pushing 2, 44, 6 (note: DO NOT push invalid values)
~L_push(x,2)
~L_push(x,44)
~L_push(x,6)

Peek: {L_peek(x)}
Accessing index 0 (bottom of stack): {L_get(x,0)}
Popping all 3 values:
{L_pop(x)}
{L_pop(x)}
{L_pop(x)}
Out-of-bounds error code when popping from empty stack:
{L_pop(x)}

General notes:
Stacks are stored as strings. Empty string = empty stack.
ALL inserted values must be integers between 0 and L_MAX_INT (= {L_MAX_INT}). (I have not implemented validity checks in Push)
Peek/get is O(MAX_INT*n)
Push is O(MAX_INT*n)
Pop is O(MAX_INT*n^2), I think?
Note that for all of these, MAX_INT refers to the largest int actually present in the list currently.  So it'll be faster if you only store small values.
-> DONE

// get integer at index i
=== function L_get(ls,i) ===
{not (ls has ";{i},"):
    ~return L_OUT_OF_BOUNDS
}
~return _L_get_helper(ls,i,0)
=== function _L_get_helper(ls,i,curr) ===
{curr > L_MAX_INT:
    ~return L_INVALID_VALUE
    // i.e. someone inserted a float or something
    // ideally should never happen if insert function has good error checking.
}
{ls has ";{i},{curr};":
    ~return curr
- else:
    ~return _L_get_helper(ls,i,curr+1)
}

// get length of list
=== function L_length(ls) ===
~return _L_length_helper(ls,0)
=== function _L_length_helper(ls,count) ===
{ls has ";{count},":
    ~return _L_length_helper(ls,count+1)
-else:
    ~return count
}


// append to end of list.
// returns true if list was successfully modified, false otherwise
=== function L_push(ref ls,val) ===
{val > L_MAX_INT or val < 0:
    ~return false
}
~temp new_index = L_length(ls)
~ls += ";{new_index},{val};"
~return true

// Peek at end of list
=== function L_peek(ref ls) ===
{ls == "":
    ~return L_OUT_OF_BOUNDS
}
~return L_get(ls, L_length(ls) - 1)

// Pop from end of list
=== function L_pop(ref ls) ===
{ls == "":
    ~return L_OUT_OF_BOUNDS
}
~temp len = L_length(ls)
~temp result = L_get(ls,len-1)
~temp new_ls = ""
~_L_pop_helper(ls,new_ls,0,len-1)
~ls = new_ls
~return result
=== function _L_pop_helper(original,ref new,i,max) ===
{i == max:
    ~return
}
~L_push(new,L_get(original,i))
~return _L_pop_helper(original,new,i+1,max)

// TODO write eventually maybe
// Insert at arbitrary position i
// Runtime would be painful
=== function L_insert(ref ls, i, val) ===
~return
