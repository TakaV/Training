package Intern::Diary::DataBase;

use strict;
use warnings;

use base 'DBIx::MoCo::DataBase';

__PACKAGE__->dsn('dbi:mysql:dbname=intern_diary_takapiero');
__PACKAGE__->username('root');
__PACKAGE__->password('');

1;
