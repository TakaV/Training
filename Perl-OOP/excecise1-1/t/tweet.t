use strict;
use warnings;

use Test::More;
use FindBin::libs;

use Bird;

my $b1 = Bird->new({ name => 'takapi' });

use_ok "Tweet";

use Tweet;

$b1->tweet('テストは大事');
my $tweet = $b1->tweets->[0];

is $tweet->message, 'テストは大事';
is $tweet->bird->name, 'takapi';

done_testing();
