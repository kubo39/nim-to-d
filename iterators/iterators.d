// https://nim-lang.org/docs/manual.html#iterators-and-the-for-statement
//

struct Range
{
    const(char)[] a;
    int i;

    this(const(char)[] a)
    {
        this.a = a;
        i = 0;
    }

    char front()
    {
        return this.a[i];
    }

    void popFront()
    {
        i++;
    }

    bool empty()
    {
        return i >= this.a.length;
    }
}

Range items(const(char)[] a)
{
    return Range(a);
}

void main()
{
    import std.stdio : writeln;
    foreach (ch; items("Hello, World!"))
    {
        writeln(ch);
    }
}