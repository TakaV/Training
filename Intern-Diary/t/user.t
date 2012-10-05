use strict;
use warnings;
use utf8;

use Test::More;

use Intern::Diary::Test;

use Intern::Diary::MoCo;

# user
my $user = moco('User')->create(name => "takapiero");

my $title_1 = 'Perl';
my $body_1  = 'ORMを学ぶ';

my $title_2 = 'JS';
my $body_2  = 'テンプレートエンジンを作る';

my $entry_1 = $user->add_entry({
    title => $title_1,
    body  => $body_1,
});
my $entry_2 = $user->add_entry({
    title => $title_2,
    body  => $body_2,
});

my $entries = $user->entries;

# other user
my $other_user = moco('User')->create(name => "aereal");

my $other_entry_1 = $other_user->add_entry({
    title => 'レビュー',
    body  => '完了しました',
});


subtest 'add' => sub {
    is $entry_1->title, $title_1;
    is $entry_1->body, $body_1;
    is $entry_2->title, $title_2;
    is $entry_2->body, $body_2;
};

subtest 'list' => sub {
    is scalar(@$entries), 2;
    is $entries->[1]->title, $title_2;
    is $entries->[1]->body, $body_2;
};

subtest 'edit only title' => sub {
    my $edited_entry = $user->edit_entry({
        entry_id => $entries->[1]->id,
        title    => 'Python',
    });

    is $edited_entry->title, 'Python';
    is $edited_entry->body, $entry_2->body;
};

subtest 'edit only body' => sub {
    my $edited_entry = $user->edit_entry({
        entry_id => $entries->[0]->id,
        body     => '日記のシステムを設計'
    });

    is $edited_entry->title, $entry_1->title;
    is $edited_entry->body, '日記のシステムを設計';
};

subtest 'edit' => sub {
    my $edited_entry = $user->edit_entry({
        entry_id => $entries->[0]->id,
        title    => '晩ご飯',
        body     => 'ラーメンを食べた'
    });

    is $edited_entry->title, '晩ご飯';
    is $edited_entry->body, 'ラーメンを食べた';
};

subtest 'delete' => sub {
    my $removed_entry_id = $entries->[0]->id;
    $user->remove_entry($removed_entry_id);

    my $entries = $user->entries;

    is scalar(@$entries), 1;

    my $entry = moco('Entry')->find(
        id         => $removed_entry_id,
        is_deleted => 0,
    );

    is $entry, undef;
};

subtest 'edit other user entry' => sub {
    my $edited_entry = $user->edit_entry({
        entry_id => $other_entry_1->id,
        body     => 'まだ完了してません'
    });

    is $edited_entry, undef;
};

subtest 'remove other user entry' => sub {
    my $edited_entry = $user->remove_entry($other_entry_1->id);

    is $edited_entry, undef;
};

Intern::Diary::Test::truncate_db;

done_testing();
