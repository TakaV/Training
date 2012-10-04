package Intern::Diary::MoCo::Entry;

use strict;
use warnings;

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('entry');

__PACKAGE__->utf8_columns(qw(title body));

sub edit {
    my ($self, $title, $body) = @_;

    $self->title($title);
    $self->body($body);
}

sub soft_delete {
    my $self = shift;
    $self->is_deleted(1);
}

1;
