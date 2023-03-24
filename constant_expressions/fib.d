// https://nim-lang.github.io/Nim/manual.html#constants-and-constant-expressions
//

template ctFibonacci(int N) if (N > 0)
{
    static if (N <= 2) enum ctFibonacci = 1;
    else enum ctFibonacci = ctFibonacci!(N - 1) + ctFibonacci!(N - 2);
    pragma(msg, ctFibonacci);
}
enum _ = ctFibonacci!(30);


// runtime version.
int rtFibonacci(int n)
{
    import std.stdio;
    int ret = n <= 2 ? 1 : rtFibonacci(n - 1) + rtFibonacci(n - 2);
    writeln(ret);  // called everytime!
    return ret;
}

void main()
{
    rtFibonacci(30);
}
