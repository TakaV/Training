package Intern::Diary::Engine::Tutorial;

use strict;
use warnings;

use Intern::Diary::Engine -Base;
use Intern::Diary::MoCo;

sub default : Public {
    my ($self, $r) = @_;
    my $user = $r->user || return;

    $r->follow_method;
}

sub _get {
    my ($self, $r) = @_;

    my $questions = moco('TutorialQuestion')->get_random;

    $r->stash->param(
        questions => $questions,
    );
}

sub _post {
    my ($self, $r) = @_;

    my $user = $r->user || return;

    my $answered_data = $r->req->param('answered_data');

    # TODO JSから送る
    $answered_data = {
        1 => {
            question_id => 1,
            answer_id   => 2,
            answer_text => '',
        },
        2 => {
            question_id => 4,
            answer_id   => 1,
            answer_text => '',
        },
        3 => {
            question_id => 7,
            answer_id   => 0,
            answer_text => '音楽に興味があります！みんなコメントして欲しいです！',
        },
    };

    # TODO 詳細決まるまで仮のものを使う
    my $param = {
        title => '初めての日記',
        body  => '音楽に興味があります！みんなコメントして欲しいです！'
    };

    for my $category_id (sort { $a <=> $b } keys %$answered_data) {
        moco('UserTutorialQuestionLog')->register($user->id, $answered_data->{$category_id});
    }

    $user->add_entry($param);
    $user->update_tutorial_step(99);

    $r->res->redirect('/');
}

1;
