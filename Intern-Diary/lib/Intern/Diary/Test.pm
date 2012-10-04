package Intern::Diary::Test;

use strict;
use warnings;

use Intern::Diary::DataBase;

use Intern::Diary::MoCo;

Intern::Diary::DataBase->dsn('dbi:mysql:dbname=intern_diary_test');

$Intern::Diary::MoCo::Entry::NO_HTTP = 1;

sub truncate_db {
    Intern::Diary::DataBase->execute("TRUNCATE TABLE $_") for qw(user entry);
}

1;
