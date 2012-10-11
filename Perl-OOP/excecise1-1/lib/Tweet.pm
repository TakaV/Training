package Tweet;

use strict;
use warnings;

sub new {
    my ($class, $args) = @_;

    bless {
        bird    => $args->{bird},
        message => $args->{message},
    }, $class;
};

sub bird {
    my ($self, $bird) = @_;
    $self->{bird} = $bird if $bird;
    $self->{bird};
}
sub message {
    my ($self, $message) = @_;
    $self->{message} = $message if defined $message;
    $self->{message};
}

1;
