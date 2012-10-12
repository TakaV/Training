#!perl

use strict;
use warnings;

use FindBin;
use lib glob "$FindBin::Bin/../../modules/*/lib";

use Test::More qw/no_plan/;
use HTTP::Status;
use Ridge::Test 'Intern::Diary';

# TODO テスト
is 1, 1;
#is get('/index')->code, RC_OK;

1;
