use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Apache::DirXML',
    'VERSION_FROM'	=> 'DirXML.pm', # finds $VERSION
    'PREREQ_PM'		=> {XML::Directory => 0.41},
);
