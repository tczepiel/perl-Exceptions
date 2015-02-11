use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Exceptions',
    VERSION_FROM      => 'lib/Exceptions.pm',
    PREREQ_PM         => {},
    ABSTRACT_FROM     => 'lib/Exceptions.pm',
    AUTHOR            => 'Tomasz Czepiel <tjmc@localdomain>',
    LICENSE           => 'perl',
);
