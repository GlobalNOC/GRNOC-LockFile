#--------------------------------------------------------------------
#----- GRNOC Lock File Library
#-----
#----- Copyright(C) 2015 The Trustees of Indiana University
#--------------------------------------------------------------------
#----- This module is used to provide lock file support.  One of the
#----- most common reasons is to avoid tools that execute from cron
#----- from stacking on top of another if the process does not finish
#----- in time before the next run.  This is a wrapper on top of
#----- LockFile::Simple to provide more sane defaults for it, and to
#----- make it more intuitive and even easier to use.
#---------------------------------------------------------------------

package GRNOC::LockFile;

use Moo;
use Types::Standard qw( Str InstanceOf );

use LockFile::Simple;
use Data::Dumper;

has file => ( is => 'ro',
	      isa => Str,
	      required => 1 );

has _locker => ( is => 'rwp',
		 isa => InstanceOf['LockFile::Simple'],
		 required => 0 );

our $VERSION = '1.0.0';

### constructor builder ###

sub BUILD {

    my ( $self ) = @_;

    # dont ignore any "stale" locks, automatically remove lock on process exit in case we forget to
    my $locker = LockFile::Simple->make( -format => '%f',
					 -hold => 0,
					 -max => 1,
					 -stale => 0,
					 -autoclean => 1 );

    $self->_set__locker( $locker );
}

### public methods ###

sub lock {

    my ( $self ) = @_;

    # see if we were able to get ahold of the lock
    my $lock = $self->_locker->trylock( $self->file );

    die( "Unable to lock " . $self->file ) if !$lock;

    return $self;
}

sub unlock {

    my ( $self ) = @_;

    my $ret = $self->_locker->unlock( $self->file );

    die( "Unable to unlock " . $self->file ) if !$ret;

    return $self;
}

1;
