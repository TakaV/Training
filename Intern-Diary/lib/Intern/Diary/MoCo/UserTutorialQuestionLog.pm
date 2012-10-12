package Intern::Diary::MoCo::UserTutorialQuestionLog;

use strict;
use warnings;

use base 'Intern::Diary::MoCo';

use Intern::Diary::MoCo;

__PACKAGE__->table('user_tutorial_question_log');

__PACKAGE__->utf8_columns(qw(answer_text));

# class
sub register {
    my ($self, $user_id, $args) = @_;

    my $question_id = $args->{question_id};
    my $answer_id   = $args->{answer_id};
    my $answer_text = $args->{answer_text};

    $self->create(
        user_id     => $user_id,
        question_id => $question_id,
        answer_id   => $answer_id,
        answer_text => $answer_text,
    );
}

1;
