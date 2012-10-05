package Intern::Diary::Engine::Index;
use strict;
use warnings;
use Intern::Diary::Engine -Base;

sub default : Public {
    my ($self, $r) = @_;
    $r->res->content_type('text/plain');
    $r->res->content('Welcome to the Ridge world!');
}

1;
