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
        state %ids;

        my $record = $parser->next;
        if ($record) {
            my $id = join '@', map { $record->{$_} // '' } qw(isil code);
            $id =~ s/\@$//;
            if ($ids{$id}++) {
                die "duplicated department: $id\n";
            } elsif ($self->isil) {
                $record->{parent} = $self->isil;
            }
        }
        $record;
    };
}

1;
