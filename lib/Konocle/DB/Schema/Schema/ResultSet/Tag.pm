package Konocle::DB::Schema::ResultSet::Tag;
use base 'DBIx::Class::ResultSet';

sub search_title {
    my ($self, $term) = @_;

    print "TERM: ".$term."\n";
    return $self->search(
        {
            tag_name => { 'like', "$term%" }
        }
    );
}
1;
