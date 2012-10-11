#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use FindBin;
use lib "$FindBin::Bin/lib", glob "$FindBin::Bin/modules/*/lib";

use Intern::Diary::MoCo;

my %HANDLERS = (
    add    => \&add,
    list   => \&list,
    edit   => \&edit,
    delete => \&delete,
);

print "user_idを入力してください\n";
my $user_id = <STDIN>;
chomp($user_id);

print "名前を入力してください\n";
my $name = <STDIN>;
chomp($name);

my $user    = get_user($user_id, $name);
my $command = shift @ARGV || 'list';
my $handler = $HANDLERS{ $command };

$handler->($user, @ARGV);

exit 0;

sub add {
    my $user = shift;

    my ($title, $body) = input_diary();

    my $entry = $user->add_entry({
        title => $title,
        body  => $body,
    });

    input_result($entry);
}

sub list {
    my $user = shift;
    get_list($user);
}

sub edit {
    my $user = shift;

    get_list($user);

    print "\n編集したい記事のidを入力してください\n";
    my $entry_id       = input_entry_id();
    my ($title, $body) = input_diary();

    my $entry = $user->edit_entry({
        entry_id => $entry_id,
        title    => $title,
        body     => $body
    });

    input_result($entry);
}

sub delete {
    my $user = shift;

    get_list($user);

    print "\n削除したい記事のidを入力してください\n";
    my $entry_id = input_entry_id();

    $user->remove_entry($entry_id);
    print "削除しました\n";
}

sub get_user {
    my ($user_id, $name) = @_;
    moco('User')->find(id => $user_id) || moco('User')->create(id => $user_id, name => $name);
}

sub get_list {
    my $user = shift;

    print "\n今までに書いた記事\n";

    for my $entry ($user->entries) {
        print 'id:'     . $entry->id . "\n"
            . 'タイトル: ' . $entry->title . "\n"
            . '内容:'   . $entry->body . "\n";
    }
}

sub input_entry_id {
    my $entry_id = <STDIN>;
    chomp($entry_id);

    $entry_id;
}

sub input_diary {
    print "タイトルを入力してください\n";
    my $title = <STDIN>;
    chomp($title);

    print "記事を入力してください\n";
    my $body = <STDIN>;
    chomp($body);

    ($title, $body);
}

sub input_result {
    my $entry = shift;

    print "\n書いた記事\n";
    print "タイトル: " . $entry->title . "\n" . '内容:' . $entry->body . "\n";
}
