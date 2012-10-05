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
    my ($self, $name) = @_;
    $self->{name} = $name if defined $name;
    return $self->{name};
}
sub follows {
    my ($self, $follows) = @_;
    $self->{follows} = $follows if $follows;
    $self->{follows};
}
sub followers {
    my ($self, $followers) = @_;
    $self->{followers} = $followers if $followers;
    $self->{followers};
}
sub tweets {
    my ($self, $tweets) = @_;
    $self->{tweets} = $tweets if $tweets;
    $self->{tweets};
}
sub friend_timelines {
    my ($self, $friend_timelines) = @_;
    $self->{friend_timelines} = $friend_timelines if $friend_timelines;;
    $self->{friend_timelines};
}

sub follow {
    my ($self, $bird) = @_;

    return if $self->name eq $bird->name;
    return if $bird->_has_bird($self, 'followers');

    $self->_add_follow($bird);
    $bird->_add_follower($self);
}

sub unfollow {
    my ($self, $bird) = @_;

    return if $self->name eq $bird->name;

    $self->_remove_follow($bird);
    $bird->_remove_follower($self);
}

sub tweet {
    my ($self, $message) = @_;

    my $tweet = Tweet->new({ bird => $self, message => $message });

    $self->_add_tweet($tweet);

    for my $follower (@{ $self->followers }) {
        $follower->_receive_tweet($tweet);
    }
}

sub _add_tweet {
    my ($self, $tweet) = @_;

    my $tweets = $self->tweets;
    push @{ $tweets }, $tweet;

    $self->tweets($tweets);
}

sub _add_follow {
    my ($self, $bird) = @_;

    my $follows = $self->follows;
    push @{ $follows }, $bird;

    $self->follows($follows);
}

sub _add_follower {
    my ($self, $bird) = @_;

    my $followers = $self->followers;
    push @{ $followers }, $bird;

    $self->followers($followers);
}

sub _remove_follow {
    my ($self, $removed_bird) = @_;

    return if !$self->_has_bird($removed_bird, 'follows');

    my $follows = [];
    for my $bird (@{ $self->follows }) {
        next if $removed_bird->name eq $bird->name;
        push @$follows, $bird;
    }

    $self->follows($follows);
}

sub _remove_follower {
    my ($self, $removed_bird) = @_;

    return if !$self->_has_bird($removed_bird, 'followers');

    my $followers = [];
    for my $bird (@{ $self->followers }) {
        next if $removed_bird->name eq $bird->name;
        push @$followers, $bird;
    }

    $self->followers($followers);
}

sub _receive_tweet {
    my ($self, $tweet) = @_;

    my $friend_timelines = $self->friend_timelines;;
    unshift @{ $friend_timelines }, $tweet;

    $self->friend_timelines($friend_timelines);
}

sub _has_bird {
    my ($self, $bird, $method_name) = @_;
    return scalar(grep { $bird->name eq $_->name } @{ $self->$method_name }) > 0;
}

1;
