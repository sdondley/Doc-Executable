use v6.d;
unit module Doc::Executable::Resources;
use Doc::Executable::Parser;
use Distribution::Resources::Menu;

my $rsm = ResourceMenu.new(
        distribution => $?DISTRIBUTION,
        resources    => %?RESOURCES);

sub menu-execute is export {
    my @parsed = parse-file $rsm.execute.file-path;
    eval-file(@parsed);
}
