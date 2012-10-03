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
    shift->{bird};
}
sub message {
    shift->{message};
}

1;
