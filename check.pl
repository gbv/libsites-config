use v5.14;
use lib 'libsites/lib';
use lib 'libsites/local/lib/perl5';

use Libsites::Update::ISIL;
use Libsites::Update::Sites;

my %config = (configdir => '.', updatelog => '');
Libsites::Update::ISIL->new(%config)->update;

Libsites::Update::Sites->new(%config)->update;

