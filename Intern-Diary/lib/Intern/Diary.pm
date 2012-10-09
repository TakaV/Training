package Intern::Diary;

use strict;
use warnings;

use base qw/Ridge/;

use Intern::Diary::MoCo;

__PACKAGE__->configure;

sub user {
    my ($self) = @_;

    if (my $name = 'takapiero') {
        my $user = moco('User')->find( name => $name ) || moco('User')->create( name => $name );
    }
    else {
        '';
    }
}

1;
