package Intern::Diary::Engine::Login;

use strict;
use warnings;

use Intern::Diary::Engine -Base;

use Intern::Diary::MoCo;

use constant {
    USER_ID => 'user_id',
};

# ログイン
sub default : Public {
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _get {
}

sub _post {
    my ($self, $r) = @_;

    my $name = $r->req->param('name');
    my $user = moco('User')->find_by_name($name);

    $r->session->set(USER_ID, $user->id);

    $r->res->redirect('/');
}

# ユーザ登録
sub register : Public {
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _register_get {
}

sub _register_post {
    my ($self, $r) = @_;

    my $name = $r->req->param('name');
    my $user = moco('User')->register($name);

    $r->session->set(USER_ID, $user->id);

    $r->res->redirect('/');
}

1;
