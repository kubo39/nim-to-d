// https://nim-lang.github.io/Nim/manual.html#statements-and-expressions-when-nimvm-statement
//

bool someProcThatMayRunInCompileTime()
{
    if (__ctfe)
        return true;
    else
        return false;
}

void main()
{
    static ctValue = someProcThatMayRunInCompileTime();
    bool rtValue = someProcThatMayRunInCompileTime();

    assert(ctValue);
    assert(!rtValue);
}
