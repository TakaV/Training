#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;

use Bird;

my $b1 = Bird->new({ name => 'jkondo' });
my $b2 = Bird->new({ name => 'aereal' });
my $b3 = Bird->new({ name => 'takapi' });

$b2->follow($b1);
$b3->follow($b1);

$b1->follow($b2);
$b3->follow($b2);

$b1->tweet('きょうはあついですね！');
$b1->tweet('きょうはさむいですね！');
$b2->tweet('引っ越ししたいな〜');
$b3->tweet('きれいなコードが書きたい');

my $b2_timelines = $b2->friend_timelines;
print $b2_timelines->[0]->message . "\n";
print $b2_timelines->[1]->message . "\n";

my $b1_timelines = $b1->friend_timelines;
print $b1_timelines->[0]->message . "\n";
