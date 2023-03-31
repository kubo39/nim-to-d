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


// =======================================================-

struct Matrix(int M, int N, T)
{
private:
    T[M*N] data;

public:
    T opIndex(int m, int n)
    {
        return data[m * N + n];
    }

    void opIndexAssign(T v, int m, int n)
    {
        data[m * N + n] = v;
    }

    int rows()
    {
        return M;
    }

    int cols()
    {
        return N;
    }
}

unittest
{
    Matrix!(3, 3, int) m;
    assert(m[0, 1] == 0);
    m[0, 1] = 42;
    assert(m[0, 1] == 42);
}

enum isAnyMatrix(M) =
    is(M == S!(R, C, T), alias S, alias R, alias C, alias T)
    && !is(R)
    && is(typeof(R) == int)
    && !is(C)
    && is(typeof(C) == int)
    && is(typeof(M.rows()) == int)
    && is(typeof(M.cols()) == int)
    && is(typeof(M[0, 0]) == T)
    && is(typeof(M[0, 0] = T.init));

enum isAnySquareMatrix(M) =
    is(M == S!(R, C, T), alias S, alias R, alias C, alias T)
    && !is(R)
    && !is(C)
    && (R == C)
    && is(typeof(R) == int)
    && is(typeof(M.rows()) == int)
    && is(typeof(M.cols()) == int)
    && is(typeof(M[0, 0]) == T)
    && is(typeof(M[0, 0] = T.init));

T transposed(T)(T m) if (isAnySquareMatrix!T)
{
    foreach (r; 0 .. m.rows())
        foreach (c; 0 .. m.cols())
            m[r, c] = m[c, r];
    return m;
}

unittest
{
    Matrix!(3, 3, int) m;
    auto n = transposed(m);
    assert(m == n);
}
