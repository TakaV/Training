use strict;
use warnings;

use Test::More;
use FindBin::libs;

use_ok "Bird";

use Bird;

my $b1 = Bird->new({ name => 'jkondo' });
my $b2 = Bird->new({ name => 'aereal' });
my $b3 = Bird->new({ name => 'takapi' });

is $b1->name, 'jkondo';
is $b2->name, 'aereal';
is $b3->name, 'takapi';

$b2->follow($b1);
$b3->follow($b1);
$b3->follow($b2);

# 正常系
# フォローしている人
is_deeply [ map { $_->name } @{ $b3->follows } ], [ 'jkondo', 'aereal' ];
is_deeply [ map { $_->name } @{ $b2->follows } ], [ 'jkondo' ];
is_deeply [ map { $_->name } @{ $b1->follows } ], [];

# フォロワー
is_deeply [ map { $_->name } @{ $b1->followers } ], [ 'aereal', 'takapi' ];
is_deeply [ map { $_->name } @{ $b2->followers } ], [ 'takapi' ];
is_deeply [ map { $_->name } @{ $b3->followers } ], [];

# tweet
is_deeply [ map { $_->message } @{ $b1->tweets } ], [];

$b1->tweet('きょうはあついですね！');
$b2->tweet('引っ越ししたいな〜');
$b3->tweet('きれいなコードが書きたい');
$b1->tweet('きょうはさむいですね！');

is_deeply [ map { $_->message } @{ $b1->tweets } ], [ 'きょうはあついですね！', 'きょうはさむいですね！' ];
is_deeply [ map { $_->message } @{ $b2->tweets } ], [ '引っ越ししたいな〜' ];
is_deeply [ map { $_->message } @{ $b3->tweets } ], [ 'きれいなコードが書きたい' ];

# フォローしている人のtweet
is_deeply [ map { $_->message } @{ $b2->follows->[0]->tweets } ], [ 'きょうはあついですね！', 'きょうはさむいですね！' ];
is_deeply [ map { $_->message } @{ $b3->follows->[1]->tweets } ], [ '引っ越ししたいな〜' ];

# タイムライン
is_deeply [ map { $_->message } @{ $b3->friend_timelines } ], [ 'きょうはさむいですね！', '引っ越ししたいな〜', 'きょうはあついですね！' ];
is_deeply [ map { $_->message } @{ $b1->friend_timelines } ], [];

# フォロー取消
$b2->unfollow($b1);

is_deeply [ map { $_->name } @{ $b2->follows } ], [];
is_deeply [ map { $_->name } @{ $b1->followers } ], [ 'takapi' ];

# 異常系
# 自分をフォロー
$b3->follow($b3);
is_deeply [ map { $_->name } @{ $b3->follows } ], [ 'jkondo', 'aereal' ];
is_deeply [ map { $_->name } @{ $b3->followers } ], [];

# 既にフォローしている人をフォロー
$b3->follow($b1);
is_deeply [ map { $_->name } @{ $b3->follows } ], [ 'jkondo', 'aereal' ];
is_deeply [ map { $_->name } @{ $b1->followers } ], [ 'takapi' ];

done_testing();
