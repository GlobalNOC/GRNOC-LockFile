use strict;
use warnings;

use Test::More tests => 2;

use GRNOC::LockFile;
use Try::Tiny;

# make sure lock file still exists
ok( -e '/tmp/GRNOC-LockFile.lock', "prior lock file still exists" );

# make sure we can lock it again since our PID changed from the lock file
my $locker = GRNOC::LockFile->new( file => '/tmp/GRNOC-LockFile.lock' );
my $lock = $locker->lock();

ok( $lock, 'removed stale lock' );
