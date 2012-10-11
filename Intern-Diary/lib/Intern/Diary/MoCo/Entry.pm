package Intern::Diary::MoCo::Entry;

use strict;
use warnings;

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('entry');

__PACKAGE__->utf8_columns(qw(title body));

sub user {
    my $self = shift;
    moco('User')->find( id => $self->user_id );
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
