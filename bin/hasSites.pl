#!/usr/bin/env perl
use v5.14;
use lib './lib';

my $verbose;
use RDF::Trine::Parser;
use RDF::aREF;

sub is_isil { $_[0] =~ /^[A-Z]{1,3}-[A-Za-z0-9\/:-]{1,10}$/ } 

my $parser = RDF::Trine::Parser->new('Turtle');

foreach my $isil (<isil/*>) {
    next unless is_isil($isil);

    next unless -f "isil/$isil/sites.ttl";
    $parser->parse_file ( $base_uri, $file, sub {

     } );
}

# ... write down reverse direction
