package Intern::Diary::MoCo::User;

use strict;
use warnings;

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('user');

__PACKAGE__->utf8_columns(qw(name));

sub entries {
    my ($self, $opts) = @_;

    my $attrs = {
        order => 'id DESC',
    };

    if ($opts) {
        my $page  = $opts->{page} || 1;
        my $limit = $opts->{limit} || 3;

        $attrs->{limit}  = $limit;
        $attrs->{offset} = ($page - 1) * $limit;
    }

    moco('Entry')->search(
        where => {
            user_id    => $self->id,
            is_deleted => 0,
        },
        %$attrs
    );
}

sub add_entry {
    my ($self, $args) = @_;

    my $title = $args->{title};
    my $body  = $args->{body};

    moco('Entry')->create(
        user_id    => $self->id,
        title      => $title,
        body       => $body,
        is_deleted => 0,
    );
}

sub edit_entry {
    my ($self, $args) = @_;

    my $entry_id = $args->{entry_id};
    my $title    = $args->{title};
    my $body     = $args->{body};

    my $entry = moco('Entry')->find(
        id         => $entry_id,
        user_id    => $self->id,
        is_deleted => 0
    );

    return if !$entry;

    $entry->edit({
        title => $title,
        body  => $body,
    });

    $entry;
}

sub remove_entry {
    my ($self, $entry_id) = @_;

    my $entry = moco('Entry')->find(
        id         => $entry_id,
        user_id    => $self->id,
        is_deleted => 0
    );

    return if !$entry;

    $entry->soft_delete;
}

1;
