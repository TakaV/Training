package Intern::Diary::MoCo::Entry;

use strict;
use warnings;

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('entry');

__PACKAGE__->utf8_columns(qw(title body));

sub find_by_id {
    my ($class, $id) = @_;

    $class->find(
        id         => $id,
        is_deleted => 0
    );
}

sub search_by_user_id {
    my ($class, $user_id, $opts) = @_;

    my $attrs = {
        order => 'id DESC',
    };

    if ($opts) {
        my $page  = $opts->{page} || 1;
        my $limit = $opts->{limit} || 3;

        $attrs->{order}  = $opts->{order};
        $attrs->{limit}  = $limit;
        $attrs->{offset} = ($page - 1) * $limit;
    }

    $class->search(
        where => {
            user_id    => $user_id,
            is_deleted => 0,
        },
        %$attrs
    );
}

sub register {
    my ($class, $user_id, $args) = @_;

    my $title = $args->{title};
    my $body  = $args->{body};

    $class->create(
        user_id    => $user_id,
        title      => $title,
        body       => $body,
        is_deleted => 0,
    );
}

sub user {
    my $self = shift;
    moco('User')->find_by_id($self->user_id);
}

sub edit {
    my ($self, $args) = @_;

    $self->title($args->{title}) if defined $args->{title} && $args->{title} ne '';
    $self->body($args->{body}) if defined $args->{body} && $args->{body} ne "";
}

sub soft_delete {
    my $self = shift;
    $self->is_deleted(1);
}

1;
