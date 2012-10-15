package Intern::Diary;

use strict;
use warnings;

use Data::Page;
use HTTP::Status;
use Plack::Session;

use base qw/Ridge/;

use Intern::Diary::MoCo;

__PACKAGE__->configure;

use constant {
    USER_ID => 'user_id',
};

sub user {
    my $self = shift;

    my $user_id = $self->session->get(USER_ID);
    my $user    = moco('User')->find_by_id($user_id);

    if ($user) {
        if ($user->is_finished_tutorial || $self->req->request_uri eq '/tutorial') {
            return $user;
        }
    }
    else {

    };

    if ($user && $user->is_finished_tutorial) {
        return $user;
    }
    else {
        my $redirect_url = '/tutorial';

        if (!$user) {
            $redirect_url = '/login';
        }
        elsif ($self->req->request_uri eq '/tutorial') {
            return $user;
        }

        $self->res->redirect($redirect_url);
        return;
    }
}

sub get_pager {
    my ($self, $args) = @_;

    my $pager = Data::Page->new;

    $pager->total_entries($args->{total});
    $pager->entries_per_page($args->{per_page});
    $pager->current_page($args->{page});

    $pager;
}

sub session {
    my $self = shift;
    Plack::Session->new($self->req->env);
}

sub detach_400 {
    Ridge::Exception::RequestError->throw( code => RC_BAD_REQUEST );
}

sub detach_404 {
    Ridge::Exception::RequestError->throw( code => RC_NOT_FOUND );
}

sub detach_405 {
    Ridge::Exception::RequestError->throw( code => RC_METHOD_NOT_ALLOWED );
}

1;
