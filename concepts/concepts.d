// https://nim-lang.org/docs/manual_experimental.html#concepts
//

import std.traits : ReturnType;

enum isComparable(T) = is(ReturnType!(() => T.init < T.init) == bool);

static assert(isComparable!int);
static assert(!isComparable!void);


enum isStackLike(T) =
    is(T == S!Elem, alias Elem, alias S)
    && is(typeof(T.pop()) == Elem)
    && is(typeof(T.push(Elem.init)) == void)
    && is(typeof(T.length) == size_t);

struct Stack(T)
if (__traits(compiles, T.init))
{
    T pop() { return T.init; }
    void push(T value) {}
    size_t length() @property { return T.init; }
}

static assert(isStackLike!(Stack!int));
static assert(!__traits(compiles, Stack!void));
