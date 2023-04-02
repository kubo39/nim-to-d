// https://nim-lang.org/docs/manual.html#procedures-nrvo
//

alias BigT = int[16];

BigT p(int raiseAt)
{
    BigT result;
    foreach (int i; 0 .. BigT.length)
    {
        if (i == raiseAt)
            throw new Exception("interception");
        result[i] = i;
    }
    return result;
}

void main()
{
    BigT x;
    try x = p(8);
    catch (Exception e)
    {
        assert(x == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    }
}