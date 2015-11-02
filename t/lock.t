use strict;
use warnings;

use Test::More tests => 6;

use GRNOC::LockFile;
use Try::Tiny;

# make sure no stale locks exist
unlink( '/tmp/GRNOC-LockFile.lock' );

my $locker = GRNOC::LockFile->new( file => '/tmp/GRNOC-LockFile.lock' );

# make sure we were able to lock the file and it returned itself
my $lock = $locker->lock();
isa_ok( $lock, 'GRNOC::LockFile' );

# make sure the file exists on disk
ok( -e '/tmp/GRNOC-LockFile.lock', "/tmp/GRNOC-LockFile.lock exists" );

# trying to lock again while already locked fails
my $failed;

try {

    $locker->lock();
}

catch {

    $failed = 1;
};

ok( $failed, 'caught error trying to lock()' );

# unlock the lock
$lock = $lock->unlock();
isa_ok( $lock, 'GRNOC::LockFile' );

# make sure file no longer exists
ok( ! -e '/tmp/GRNOC-LockFile.lock', "/tmp/GRNOC-LockFile.lock no longer exists" );

# make sure unlock dies if its not currently locked
$failed = 0;

try {

    $locker->unlock();
}

catch {

    $failed = 1;
};

ok( $failed, 'caught error trying to unlock()' );
