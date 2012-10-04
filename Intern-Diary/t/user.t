use strict;
use warnings;

use Test::More;

use Intern::Diary::Test;

use Intern::Diary::MoCo;

my $user = moco('User')->create(name => "takapiero");

my $entry = $user->add_entry({
    title => 'aaa',
    body  => 'bbb',
});

is $entry->title, 'aaa';
is $entry->body, 'bbb';

Intern::Diary::Test::truncate_db;

done_testing();
