package Intern::Diary::Engine::Api;

use strict;
use warnings;

use JSON::XS;

use Intern::Diary::Engine -Base;
use Intern::Diary::MoCo;

sub page : Public {
    my ($self, $r) = @_;

    my $user = $r->user;

    my $page     = $r->req->uri->param('page_id');
    my $per_page = 3;

    my $total_entries = $user->entries;

    my $pager = $r->get_pager({
        total    => scalar(@$total_entries),
        per_page => $per_page,
        page     => $page,
    });

    my $entries = [ $pager->splice($total_entries) ];

    my $jsons = [];
    if (scalar(@$entries)) {
        for my $entry (@$entries) {
            my $json = {
                id    => $entry->id,
                title => $entry->title,
                body  => $entry->body,
            };
            push @$jsons, $json;
        }
    }

    $r->res->content_type('application/json');
    $r->res->content(JSON::XS->new->utf8->space_after->encode({
        pager => {
            current => $pager->current_page,
            next    => $pager->next_page,
            prev    => $pager->previous_page,
            first   => $pager->first_page,
            last    => $pager->last_page,
        },
        data => $jsons,
    }));
}

1;
