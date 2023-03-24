// https://nim-lang.github.io/Nim/manual.html#templates
// 


/** 
 * same as:
 template noteq(alias a, alias b)
 {
    enum bool noteq = !(a == b);
 }
 */
enum bool noteq(alias a, alias b) = !(a == b);
static assert(noteq!(5, 6));


mixin template declareInt()
{
    immutable x = 42;
}
mixin declareInt;
static assert(x == 42);


template t(string body)
{
    void p()
    {
        import std.stdio;
        "hey".writeln;
    }
    alias t = mixin(body);
}
// templates are not macro.
// undeclared symbol cannot be used, so use string mixin.
static assert (__traits(compiles, t!"p"));
static assert (!__traits(compiles, t!"q"));
static assert (__traits(compiles, t!(q{{ import std.stdio; "hey".writeln; }})));

// This works too.
/** 
 * same as:
 template t(alias body)
 {
    alias t = body;
 }
 */
alias t(alias body) = body;
static assert (__traits(compiles, t!({ import std.stdio; "hey".writeln; })));


// compiler: symbol lookup --> template instanting
int lastId = 0;
/** 
 * same as:
 template genId()
 {
    int genId()
    {
        lastId++;
        return lastId;
    }
 }
 */
int genId()()
{
    lastId++;
    return lastId;
}
static assert(__traits(compiles, genId()));
