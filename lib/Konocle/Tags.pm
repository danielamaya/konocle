package Konocle::Tags;
use Mojo::Base 'Mojolicious::Controller';
use DBIx::Class::ResultClass::HashRefInflator;
use Mojo::JSON;

# This action will render a template
sub search {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render( msg => 'Search The Database for a Tag!');
}

sub autocomplete {
    my $self = shift;
    my $term = $self->param('term');

    my $tags = $self->schema->resultset('Tag')->search_title($term);
    $tags->result_class('DBIx::Class::ResultClass::HashRefInflator');

    #my $json = Mojo::JSON->new;
    #my $results = $json->encode([ $tags->all ]);
    $self->render( json => [$tags->all] );
}

sub get_tag_name {
    my $self = shift;
    my $term = $self->param('term');

    my $tag = $self->schema->resultset('Tag')->search({ tag_name => $term });
    $tag->result_class('DBIx::Class::ResultClass::HashRefInflator');

    #my $json = Mojo::JSON->new;
    #my $results = $json->encode([ $tags->all ]);
    $self->render( json => [$tag->all] );
}
1;
