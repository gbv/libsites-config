use v5.14;
use Test::More;
use IO::String;

use_ok('Data::Libsites::Parser');

my $parser = Data::Libsites::Parser->new( file => \*DATA );

is_deeply ($parser->next, { 
    name        => 'Main Library', 
    url         => 'http://example.org/',
    address     => "an\naddress",
    description => "some\ncomment",
}, 'first location');

is_deeply ($parser->next, {
    code         => '0',
    email        => 'contact@example.org',
    openinghours => "Mo-Fr 9:00-21:00, Sa 10:00-16:00\nVorlesungsfreie Zeit: Mo-Fr 9:00-18:00",
    geolocation  => { geo_long => '9.974501', geo_lat => '52.134268' },
    phone        => '+49-5121-883260',
}, 'second location');

is_deeply ($parser->next, {
    code         => 'longname',
    name         => 'Long name',
    short        => 'short name',
}, 'short name');

is_deeply ($parser->next, {
    isil        => 'DE-123',
}, 'ISIL only');

is $parser->next, undef, 'eof';

$parser = Data::Libsites::Parser->new( file => IO::String->new("DE-ABC") );
is_deeply $parser->next, { isil => 'DE-ABC' };

done_testing;

__DATA__
@
Main Library
an
# ignore
address
http://example.org/
some
comment

@0

contact@example.org
52.134268, 9.974501
Mo-Fr 9:00-21:00, Sa 10:00-16:00
Vorlesungsfreie Zeit: Mo-Fr 9:00-18:00
+49-5121-883260

@longname
Long name (= short name)

ISIL DE-123
