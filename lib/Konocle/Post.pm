package Konocle::Post;
use Mojo::Base 'Mojolicious::Controller';

sub view {
    my $self = shift;

    my $post_id = $self->param('id');

    my $post = $schema->resultset('Post')->find(
        {post_id => $post_id}
    );


}

sub create {
    my $self = shift;

    # Grab everything relevant about the post
    my $title   = $self->param('title');
    my $desc    = $self->param('desc');
    my $text    = $self->param('text');
    my $tags    = $self->param('tags');
    my $subject = $self->param('id');

    my $schema = $self->schema;

    $schema->resultset('Post')->create(
        {
            post_title          => $title,
            post_description    => $desc,
            post_text           => $text,
            post_submitted_by   => $user_id,
        }
    );

}

1;
