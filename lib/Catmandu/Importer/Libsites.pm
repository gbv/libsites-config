package Catmandu::Importer::Libsites;

use namespace::clean;
use Catmandu::Sane;
use Moo;

use Data::Libsites::Parser;

with 'Catmandu::Importer';

has isil => (is => 'ro');

sub generator {
    my ($self) = @_;
    sub {
        state $parser = Data::Libsites::Parser->new(
            file => $self->fh,
            isil => $self->isil,
        );
        my $record = $parser->next;
        if ($record and $self->isil) {
            $record->{parent} = $self->isil;
        }
        $record;
    };
}

1;
