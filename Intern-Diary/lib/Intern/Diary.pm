package Intern::Diary;

use strict;
use warnings;

use Data::Page;

use base qw/Ridge/;

use Intern::Diary::MoCo;

__PACKAGE__->configure;

sub user {
    my $self = shift;

    my $name = 'takapiero';
    moco('User')->find( name => $name ) || moco('User')->create( name => $name );
}

sub get_pager {
    my ($self, $args) = @_;

    my $pager = Data::Page->new;

    $pager->total_entries($args->{total});
    $pager->entries_per_page($args->{per_page});
    $pager->current_page($args->{page});

    $pager;
}

1;
