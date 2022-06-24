use v6.d;
use Doc::Executable::Subroutines;

blank;
blank;
say "LIST BASICS";
blank;
das '1, 2', "This is a simple list with two elements. List are comma-separated values, parentheses are optional.";
das '(1, 2)', "It's good practice, however, to surround lists with parentheses in your code";
das '(1, 2)', "The 'say' function will output lists in parentheses";
das '()', "An empty list";
das '(1, 2, 3)[2]', "Lists are a subclass of Positional so elements can be accessed with an index number in a subscript using square brackets";
das '(1, 2, 3)[7]', "A Nil value is generated if an indexed element does not exist";
das '(1, 2, 3)[0]', "By default, index numbers start with zero";
das '(1, 2; 3)', "Semis delimit lists";
das '(1, 2), (3, 4)',  "A List of lists, multidimensional array syntax";
das '(1; 2)', "Lists with one element are flattened";
das '(7,)', "A list with one element. Commas create lists";
das '(1)', "This is not a list because there is no comma";
das '(1,2).WHAT';
das '(1,2).^name';
das "('home team', 'away team')", "Note also that list elements are separated with white space when output";
das '(,)', "This throws a compile time error:";
das '(1, 2, 3).elems', 'Get the number of elements with elems method';
das ('my $list = (1, 2, 3);',
     '$list.elems;'),
        'Lists can be assigned to a scalar';
das ('my @list = (1, 2, 3);',
     '@list[0]'),
        'Lists can be assigned to an arrays as well';
blank;

