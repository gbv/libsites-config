package Catmandu::Fix::libsites_rdf;

use v5.14.1;
use Moo;

has isil => (is => 'rw');

our $isilbase = "http://uri.gbv.de/organization/isil/";

sub fix {
    my ($self, $r) = @_;

    my $rdf = {
        a => 'foaf:Organization',
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

    if ($r->{isil}) {
        $rdf->{'_id'} = $r->{isil};
    } else {
        $rdf->{'_id'} = $r->{parent};
    }
    $rdf->{_id} = $isilbase . $rdf->{_id}; 
                
    $rdf->{_id} .='@' . $r->{code} if $r->{code};

 
    if ($r->{parent}) {
        $rdf->{'org:siteOf'} = $isilbase . $r->{parent};
    }

    # TODO: this should not be necessary!
#    delete $rdf->{$_} for grep { !defined $rdf->{$_} } keys %$rdf;

    $rdf;
}

1;

