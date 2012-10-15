package Intern::Diary::Engine::Index;

use strict;
use warnings;

use Intern::Diary::Engine -Base;

sub default : Public {
    my ($self, $r) = @_;

    my $user = $r->user || return;

    my $page     = $r->req->param('page') || 1;
    my $per_page = 3;

    my $total_entries = $user->entries;

    my $pager = $r->get_pager({
        total    => scalar(@$total_entries),
        per_page => $per_page,
        page     => $page,
    });

    my $entries = [ $pager->splice($total_entries) ];

    $r->stash->param(
        entries       => $entries,
        page          => $page,
        next_page     => $pager->next_page,
        previous_page => $pager->previous_page,
    );
}

1;
