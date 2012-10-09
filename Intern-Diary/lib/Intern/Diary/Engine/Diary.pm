package Intern::Diary::Engine::Diary;

use strict;
use warnings;

use Intern::Diary::Engine -Base;
use Intern::Diary::MoCo;

sub default : Public {
    my ($self, $r) = @_;

    my $id    = $r->req->uri->param('id');
    my $entry = moco("Entry")->find( id => $id );

    $r->stash->param(
        entry => $entry,
    );
}

sub add : Public {
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _add_get {
}

sub _add_post {
    my ($self, $r) = @_;

    my $title = $r->req->param('title');
    my $body  = $r->req->param('body');

    $r->user->add_entry({
        title => $title,
        body  => $body,
    });

    $r->res->redirect('/');
}

sub edit : Public {
    my ($self, $r) = @_;

    my $id    = $r->req->param('id');
    my $entry = $id ? moco("Entry")->find( id => $id ) : undef;

    $r->stash->param(
        entry => $entry,
    );

    $r->follow_method;
}

sub _edit_get {
}

sub _edit_post {
    my ($self, $r) = @_;

    my $entry_id = $r->req->param('entry_id');
    my $title    = $r->req->param('title');
    my $body     = $r->req->param('body');

    $r->user->edit_entry({
        entry_id => $entry_id,
        title    => $title,
        body     => $body,
    });

    $r->res->redirect('/');
}

sub remove : Public {
    my ($self, $r) = @_;

    my $id    = $r->req->param('id');
    my $entry = $id ? moco("Entry")->find( id => $id ) : undef;

    $r->stash->param(
        entry => $entry,
    );

    $r->follow_method;
}

sub _remove_get {
}

sub _remove_post {
    my ($self, $r) = @_;

    my $entry_id = $r->req->param('entry_id');
    $r->user->remove_entry($entry_id);

    $r->res->redirect('/');
}

1;