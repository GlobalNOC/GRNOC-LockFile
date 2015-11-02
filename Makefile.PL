use strict;
use warnings;

use ExtUtils::MakeMaker;

sub MY::postamble { <<'END'; }

rpm:	dist
	rpmbuild -ta perl-GRNOC-LockFile-$(VERSION).tar.gz
END

sub MY::test
	{
    q(
TEST_VERBOSE=1

test :	pure_all
	$(FULLPERL) t/TEST $(TEST_VERBOSE)

test_jenkins : pure_all
	$(FULLPERL) t/TEST $(TEST_VERBOSE) --formatter=TAP::Formatter::Console

    );
}

WriteMakefile(
              NAME                => 'perl-GRNOC-LockFile',
              AUTHOR              => 'GRNOC Software Engineering <globalnoc@iu.edu>',
              VERSION_FROM        => 'lib/GRNOC/LockFile.pm',
              PL_FILES            => {},
              PREREQ_PM           => {'Moo' => 0,
				      'Types::Standard' => 0,
				      'Data::Dumper' => 0,
				      'LockFile::Simple' => 0},				      
              BUILD_REQUIRES      => {'Test::More' => 0,
				      'Test::Pod' => 0,
				      'Test::Pod::Coverage' => 0,
				      'Try::Tiny' => 0},
              dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
              clean               => { FILES => 'perl-GRNOC-LockFile-*' },
             );
