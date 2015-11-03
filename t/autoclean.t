use strict;
use warnings;

use Test::More tests => 1;

use GRNOC::LockFile;
use Try::Tiny;

# make sure no stale locks exist
unlink( '/tmp/GRNOC-LockFile.lock' );

my $locker = GRNOC::LockFile->new( file => '/tmp/GRNOC-LockFile.lock' );
my $lock = $locker->lock();

# make sure the file exists on disk
ok( -e '/tmp/GRNOC-LockFile.lock', "/tmp/GRNOC-LockFile.lock exists" );

# dont explicitly unlock it, autoclean2.t will verify we're able to re-lock it..
