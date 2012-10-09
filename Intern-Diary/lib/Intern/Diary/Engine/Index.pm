package Intern::Diary::Engine::Index;

use strict;
use warnings;

use Intern::Diary::Engine -Base;

sub default : Public {
    my ($self, $r) = @_;

    if (my $user = $r->user) {

        my $page = $r->req->param('page') || 1;
        my $entries = $user->entries({
            page => $page
        });

        $r->stash->param(
            entries => $entries,
            page    => $page,
        );
    }
}

1;
