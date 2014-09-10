// libInputVisitorExample.d
// Requires DMD compiler v2.059 or up
// To complile and run:
//    rdmd libInputVisitorExample.d
import std.algorithm;
import std.range;
import std.stdio;
import libInputVisitor;

struct Foo
{
	string[] data = ["hello", "world"];
	
	void visit(InputVisitor!(Foo, string) v)
	{
		v.yield("a");
		v.yield("b");
		foreach(str; data)
			v.yield(str);
	}

	void visit(InputVisitor!(Foo, int) v)
	{
		v.yield(1);
		v.yield(2);
		v.yield(3);
	}
}

void main()
{
	Foo foo;

	// Prints: a, b, hello, world
	foreach(item; foo.inputVisitor!string)
		writeln(item);

	// Prints: 1, 2, 3
	foreach(item; foo.inputVisitor!int)
		writeln(item);

	// It's a range! Prints: 10, 30
	auto myRange = foo.inputVisitor!int;
	foreach(item; myRange.filter!( x => x!=2 )().map!( x => x*10 )())
		writeln(item);
}
