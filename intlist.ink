// arbitrary-length LIFO stack storing integer values between 0 and MAX_INT
CONST L_MAX_INT = 256 // Note: the bigger this is, the slower operations are!
// Error values (error checking on L_push not implemented)
CONST L_OUT_OF_BOUNDS = -1
CONST L_INVALID_VALUE = -2


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
