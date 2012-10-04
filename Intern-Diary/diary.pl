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

my $user_id = <STDIN>;
chomp($user_id);

my $command = shift @ARGV || 'list';

my $user = moco('User')->find(id => $user_id) || moco('User')->create(id => $user_id, name => $user_id . "san");

my $handler = $HANDLERS{ $command };

$handler->($user, @ARGV);

exit 0;

sub add_entry {
    my ($user, $title, $body) = @_;

    my $entry = $user->add_entry({
        title => $title,
        body  => $body,
    });
    print "entry\ntitle: " . $entry->title . "\n" . 'body:' . $entry->body . "\n";
}

sub show_entries {
    my $user = shift;

    my $entries = $user->entries;

    for my $entry ($user->entries) {
        print 'id:'     . $entry->id . "\n"
            . 'title: ' . $entry->title . "\n"
            . 'body:'   . $entry->body . "\n";
    }
}

sub edit_entry {
    my ($user, $entry_id, $title, $body) = @_;

    my $entry = $user->edit_entry({
        entry_id => $entry_id,
        title    => $title,
        body     => $body
    });
    print "edit:\ntitle: " . $entry->title . "\n" . 'body:' . $entry->body . "\n";
}

sub remove_entry {
    my ($user, $entry_id) = @_;

    $user->remove_entry($entry_id);
    print "delete!\n";
}
