use strict;
use warnings;

use Test::Pod::Coverage tests => 1;
use Data::Dumper;

pod_coverage_ok( "GRNOC::LockFile", {'trustme' => [qr/^(BUILD)$/]} );
