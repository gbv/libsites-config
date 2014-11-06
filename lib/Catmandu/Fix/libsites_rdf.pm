package Catmandu::Fix::libsites_rdf;

use v5.14.1;
use Moo;

has isil => (is => 'rw');

our $isilbase = "http://uri.gbv.de/organization/isil/";

sub fix {
    my ($self, $r) = @_;

    my $rdf = {
        a => 'foaf_Organization',
        foaf_homepage    => $r->{url},
        foaf_phone       => $r->{phone},
        foaf_name        => $r->{name},
        dbprop_shortName => $r->{short},
        gbv_openinghours => $r->{openinghours},
        dc_description   => $r->{description},
        gbv_address      => $r->{address},
        geo_location     => $r->{geolocation},
    };

    $rdf->{foaf_mbox} = "<mailto:".$r->{email}.">" if $r->{email};

    my $uri = $isilbase . ($r->{isil} || $r->{parent});
    $uri .= '@' . $r->{code} if $r->{code};
 
    if ($r->{parent}) {
        my $parent = $isilbase . $r->{parent};
        if ($parent ne $uri) {
           $rdf->{org_siteOf} = $parent;
           return {
                $uri => $rdf, 
                $parent => { org_hasSite => "<$uri>" },
           };
        }
    } 

    return { $uri => $rdf };
}

1;
