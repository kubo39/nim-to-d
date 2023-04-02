// https://nim-lang.org/docs/manual.html#special-types-static-t
//

import std.traits : isNumeric;

template Matrix(int M, int N, T) if (isNumeric!T)
{
    alias Matrix = T[M*N - 1];
}

alias AffineTransform2D(T) = Matrix!(3, 3, T);
alias AffineTransform3D(T) = Matrix!(4, 4, T);

AffineTransform3D!float m1;
static assert(!__traits(compiles, { AffineTransform2D!string m2; }));
