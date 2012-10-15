package Intern::Diary::MoCo::User;

use strict;
use warnings;

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('user');

__PACKAGE__->utf8_columns(qw(name));

sub find_by_id {
    my ($class, $id) = @_;
    $class->find( id => $id );
}

sub find_by_name {
    my ($class, $name) = @_;
    $class->find( name => $name );
}

sub register {
    my ($class, $name) = @_;

    $class->create(
        name          => $name,
        tutorial_step => 0,
    );
}

sub entries {
    my ($self, $opts) = @_;
    moco('Entry')->search_by_user_id($self->id, $opts);
}

sub add_entry {
    my ($self, $args) = @_;
    moco('Entry')->register($self->id, $args);
}

sub edit_entry {
    my ($self, $entry_id, $args) = @_;

    my $title    = $args->{title};
    my $body     = $args->{body};

    my $entry = moco('Entry')->find_by_id($entry_id);
    return if !$entry || $self->id != $entry->user_id;

    $entry->edit($args);

    $entry;
}

sub remove_entry {
    my ($self, $entry_id) = @_;

    my $entry = moco('Entry')->find_by_id($entry_id);
    return if !$entry || $self->id != $entry->user_id;

    $entry->soft_delete;
}

sub update_tutorial_step {
    my ($self, $next_step) = @_;
    $self->tutorial_step($next_step);
}

sub is_finished_tutorial {
    my $self = shift;
    $self->tutorial_step == 99;
}

1;
