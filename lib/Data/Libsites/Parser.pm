package Data::Libsites::Parser;

use v5.14;
use Moo;
use Carp;
no if $] >= 5.018, 'warnings', "experimental::smartmatch";

has file  => (is => 'ro', default => sub { \*STDIN });
has isil  => (is => 'ro');

has _id   => (is => 'rw');

sub next {
    my ($self) = @_;

    # first site
    unless ($self->_id) {
        $self->parse_id($self->_readline);
        return unless $self->_id;
    }

    my $site = $self->parse_site;

    if ( defined $site->{name} && $site->{name} =~ s/\s*\(=\s*([^)]+)\)\s*// ) {
        $site->{short} = $1;
    }

    foreach (keys %$site) {
        $site->{$_} =~ s/\s+$//sm;
        delete $site->{$_} if ($site->{$_} // '') eq '';
    }

    $site;
}

sub parse_id {
    my ($self, $line) = @_;

    return if !defined $line or $line eq '' or $line !~ qr{^
        ((ISIL\ )?([A-Z]{1,4}-[A-Za-z0-9/:-]+))?
        (\@([a-z0-9]*))? $}x;

    my %id;

    return unless $2 or $4;

    if ($3) {
        $id{isil} = $3;
    } elsif ($4 eq '@' and defined $self->isil) {
        $id{isil} = $self->isil;
    }
    $id{code} = $5 if length $5;

    $self->_id(\%id);
}

# read until eof or next identifier
sub parse_site {
    my ($self) = @_;

    my $site = delete $self->{_id} or return;

    my $append = sub {
        $site->{$_[0]} .= "\n" if defined $site->{$_[0]};
        $site->{$_[0]} .= $_[1]; 
    };

    my $expect_address = 1;

    while ( defined ( $_ = $self->_readline ) ) {
        $self->parse_id($_);
        return $site if $self->_id;

        if (!defined $site->{name}) {
            $site->{name} = $_;
            next;
        }

        given($_) {
            when('') {
                $expect_address = 0;
            };
            when( qr{[^@ ]+@[^@ ]+$} ) {
                $site->{email} = $_;
            };
            when( qr{^https?://.+$} ) {
                $site->{url} = $_;
            };
            when(qr{^(\+|\(\+)[0-9\(\)/ -]+$}) { 
                s/\s+/-/g; 
                $site->{phone} = $_;
            }
            if ($_ =~ /([0-9]{2}:[0-9]{2})|Uhr/ && $_ =~ /(Mo|Di|Mi|Do|Fr|Sa|So)/) {
                $append->( openinghours => $_ );
                break;
            };
            when( qr{^(\d+\.\d+)\s*[,/;]\s*(\d+\.\d+)$} ) {
                $site->{geolocation} = { geo_lat => $1, geo_long => $2 };
            };
            when ( qr{^(\+|\(\+)[0-9\(\)/ -]+$} ) {
                $site->{phone} = $_;
            }
            default {
                if ($expect_address) {
                    $append->( address => $_ );
                    next;
                } else {
                    $append->( description => $_ );
                }
            };
        };
        $expect_address = 0;

    }

    return $site;
}

sub _readline {
    my ($self) = @_;

    while ( defined ( $_ = readline $self->file ) ) {
        s/^\s+|^\xEF\xBB\xBF|^\x{feff}|\s+$|\s+#.*$//g;
        last unless /^#/;
    }

    return $_;
}

=head1 SYNOPSIS

    use Data::Libsites::Parser;

    my $parser = Data::Libsites::Parser->new( file => \*STDIN );
    
    while( my $site = $parser->next ) {
        say $site->{isil}, $site->{name};
        # ...
    }

=head1 SEE ALSO

L<Catmandu::Importer::Libsites>

=cut

1;
