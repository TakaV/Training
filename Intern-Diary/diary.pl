#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use FindBin;
use lib "$FindBin::Bin/lib", glob "$FindBin::Bin/modules/*/lib";

use Intern::Diary::MoCo;

my %HANDLERS = (
    add    => \&add_entry,
    list   => \&show_entries,
    edit   => \&edit_entry,
    delete => \&remove_entry,
);

print "user_idを入力してください\n";
my $user_id = <STDIN>;
chomp($user_id);

print "名前を入力してください\n";
my $name = <STDIN>;
chomp($name);

my $user = moco('User')->find(id => $user_id) || moco('User')->create(id => $user_id, name => $name);

my $command = shift @ARGV || 'list';

my $handler = $HANDLERS{ $command };

$handler->($user, @ARGV);

exit 0;

sub add_entry {
    my $user = shift;

    print "\nタイトルを入力してください\n";
    my $title = <STDIN>;
    chomp($title);

    print "記事を入力してください\n";
    my $body = <STDIN>;
    chomp($body);

    my $entry = $user->add_entry({
        title => $title,
        body  => $body,
    });

    print "\n書いた記事\n";
    print "タイトル: " . $entry->title . "\n" . '内容:' . $entry->body . "\n";
}

sub show_entries {
    my $user = shift;

    print "\n今までに書いた記事\n";

    for my $entry ($user->entries) {
        print 'id:'     . $entry->id . "\n"
            . 'タイトル: ' . $entry->title . "\n"
            . '内容:'   . $entry->body . "\n";
    }
}

sub edit_entry {
    my $user = shift;

    print "\n今までに書いた記事\n";

    for my $entry ($user->entries) {
        print 'id:'     . $entry->id . "\n"
            . 'タイトル: ' . $entry->title . "\n"
            . '内容:'   . $entry->body . "\n";
    }

    print "編集したい記事のidを入力してください\n";
    my $entry_id = <STDIN>;
    chomp($entry_id);

    print "タイトルを入力してください\n";
    my $title = <STDIN>;
    chomp($title);

    print "記事を入力してください\n";
    my $body = <STDIN>;
    chomp($body);

    my $entry = $user->edit_entry({
        entry_id => $entry_id,
        title    => $title,
        body     => $body
    });

    print "\n書いた記事\n";
    print "タイトル: " . $entry->title . "\n" . '内容:' . $entry->body . "\n";
}

sub remove_entry {
    my $user = shift;

    print "\n今までに書いた記事\n";

    for my $entry ($user->entries) {
        print 'id:'     . $entry->id . "\n"
            . 'タイトル: ' . $entry->title . "\n"
            . '内容:'   . $entry->body . "\n";
    }

    print "削除したい記事のidを入力してください\n";
    my $entry_id = <STDIN>;
    chomp($entry_id);

    $user->remove_entry($entry_id);
    print "削除しました\n";
}
