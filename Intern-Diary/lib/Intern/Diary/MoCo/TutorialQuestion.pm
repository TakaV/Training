package Intern::Diary::MoCo::TutorialQuestion;

use strict;
use warnings;

use List::Util qw(shuffle);

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('tutorial_question');

__PACKAGE__->utf8_columns(qw(title description));

sub get_random {
    my ($class, $opts) = @_;

    my $attrs = {
        order => 'id',
    };

    if ($opts->{order}) {
        $attrs->{order} = $opts->{order}
    }

    my $questions = $class->search(
        where => {},
        %$attrs
    );

    my $data = {};
    for my $question (@$questions) {
        push @{ $data->{$question->category} }, $question;
    }

    # category_idにつき1つずつ質問を取得
    my $random_questions = [ map { [ shuffle @{ $data->{$_} } ]->[0] } keys %$data ];

    $random_questions;
}

1;
