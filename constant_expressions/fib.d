// https://nim-lang.github.io/Nim/manual.html#constants-and-constant-expressions
//

template fibonacci(int N) if (N > 0)
{
    static if (N <= 2) enum fibonacci = 1;
    else enum fibonacci = fibonacci!(N - 1) + fibonacci!(N - 2);
    pragma(msg, fibonacci);
}
enum _ = fibonacci!(20);
