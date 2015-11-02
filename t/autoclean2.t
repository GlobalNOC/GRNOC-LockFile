use strict;
use warnings;

use Test::More tests => 2;

use GRNOC::LockFile;
use Try::Tiny;

# make sure lock file is gone
ok( ! -e '/tmp/GRNOC-LockFile.lock', "prior lock file autoclean'd" );

# make sure we can lock it again ourselves
my $locker = GRNOC::LockFile->new( file => '/tmp/GRNOC-LockFile.lock' );
my $lock = $locker->lock();

ok( $lock, 'able to lock again' );
