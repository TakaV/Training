package Bird;

use strict;
use warnings;

use Tweet;

sub new {
    my ($class, $args) = @_;

    bless {
        name             => $args->{name},
        follows          => [],
        followers        => [],
        tweets           => [],
        friend_timelines => [],
    }, $class;
};

sub name {
    shift->{name};
}
sub follows {
    shift->{follows};
}
sub followers {
    shift->{followers};
}
sub tweets {
    shift->{tweets};
}
sub friend_timelines {
    shift->{friend_timelines};
}

sub follow {
    my ($self, $bird) = @_;

    return undef if $self->_is_same_name($bird->name);
    return undef if scalar(grep { $self->_is_same_name($_->name) } @{ $bird->followers });

    $self->_add_follow($bird);
    $bird->_add_follower($self);
}

sub unfollow {
    my ($self, $bird) = @_;

    return undef if $self->_is_same_name($bird->name);

    $self->_remove_follow($bird);
    $bird->_remove_follower($self);
}

sub tweet {
    my ($self, $message) = @_;

    my $tweet = Tweet->new({ bird => $self, message => $message });
    push @{ $self->{tweets} }, $tweet;

    for my $follower (@{ $self->followers }) {
        $follower->_receive_tweet($tweet);
    }
}

sub _add_follow {
    my ($self, $bird) = @_;
    push @{ $self->{follows} }, $bird;
}

sub _add_follower {
    my ($self, $bird) = @_;
    push @{ $self->{followers} }, $bird;
}

sub _remove_follow {
    my ($self, $bird) = @_;

    my ($removed_bird) = grep { $bird->_is_same_name($_->name) } @{ $self->follows };
    return undef if !$removed_bird;

    my $follows = [];
    for my $bird (@{ $self->follows }) {
        next if $removed_bird->_is_same_name($bird->name);
        push @$follows, $bird;
    }

    $self->{follows} = $follows;
}

sub _remove_follower {
    my ($self, $bird) = @_;

    my ($removed_bird) = grep { $bird->_is_same_name($_->name) } @{ $self->followers };
    return undef if !$removed_bird;

    my $followers = [];
    for my $bird (@{ $self->followers }) {
        next if $removed_bird->_is_same_name($bird->name);
        push @$followers, $bird;
    }

    $self->{followers} = $followers;
}

sub _receive_tweet {
    my ($self, $tweet) = @_;
    unshift @{ $self->{friend_timelines} }, $tweet;
}

sub _is_same_name {
    my ($self, $bird_name) = @_;
    $self->name eq $bird_name;
}

1;
