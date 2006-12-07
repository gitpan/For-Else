use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'For::Else',
    AUTHOR              => 'Alfie John <alfie@hackfu.org>',
    VERSION_FROM        => 'lib/For/Else.pm',
    ABSTRACT_FROM       => 'lib/For/Else.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'For-Else-*' },
);
