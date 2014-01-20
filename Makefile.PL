use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {
      'Mojolicious' => '4.65',
      'DBIx::Class' => 0,
      'File::ShareDir' => 0,
      'Mojolicious::Plugin::Bcrypt' => 0,
      'Mojolicious::Plugin::Authentication' => 0,
      'DBD::Pg' => 0,

  },
  test      => {TESTS => 't/*.t'}
);
