// https://nim-lang.org/docs/manual_experimental.html#concepts
//

import std.traits : ReturnType;

enum isCompareble(T) = is(ReturnType!(() => T.init < T.init) == bool);

static assert(isCompareble!int);
static assert(!isCompareble!void);


enum isStackLike(S) = 
    is(typeof(S.pop) == return)
    && is(typeof(S.push(ReturnType!(S.pop).init)) == void)
    && is(typeof(S.length) == size_t);

struct Stack(T)
if (__traits(compiles, T.init))
{
    T pop() { return T.init; }
    void push(T value) {}
    size_t length() @property { return T.init; }
}

static assert(isStackLike!(Stack!int));
static assert(!__traits(compiles, Stack!void));
