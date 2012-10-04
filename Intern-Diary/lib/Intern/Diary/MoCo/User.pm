package Intern::Diary::MoCo::User;

use strict;
use warnings;

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('user');

__PACKAGE__->utf8_columns(qw(name));

# __PACKAGE__->has_many(
#     entries => 'Intern::Diary::MoCo::Entry', {
#         key => { id => 'user_id' }
#     }
# );

sub entries {
    my $self = shift;

    moco('Entry')->search(
        where => {
            user_id    => $self->id,
            is_deleted => 0,
        },
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
        is_deleted => 0
    );

    $entry->edit($title, $body);

    return $entry;
}

sub remove_entry {
    my ($self, $entry_id) = @_;

    my $entry = moco('Entry')->find(id => $entry_id);
    $entry->soft_delete;
}

1;
