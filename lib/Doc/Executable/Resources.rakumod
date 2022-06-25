use v6.d;
use Injector;
unit module Doc::Executable::Resources;
use Doc::Executable::Parser;
use Distribution::Resources::Menu;

BEGIN {
    bind $?DISTRIBUTION, :name<dist>;
    bind %?RESOURCES, :name<rsrc>;
}

my ResourceMenu $c is injected;

sub menu-execute is export {
    my @parsed = parse-file $c.execute.file-path;
    eval-file(@parsed);

}