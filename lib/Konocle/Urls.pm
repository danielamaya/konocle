package Konocle::Urls;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::Collection;
use Data::Dumper;

sub add {
    my $self = shift;

    my $schema = $self->schema;
    my $disciplines = $schema->resultset('Discipline')->get_column('discipline_name');
    print Dumper $disciplines;
    $self->render(disciplines => $disciplines);
}

sub add_url {
    my $self = shift;

    my $user_id = $self->session->{user_id};

    my $url = $self->param('url_address');
    my $title = $self->param('url_title');
    my $desc = $self->param('url_desc');
    my @tags = split /,/, $self->param('hidden-tags');


    my $schema = $self->schema;
    my $url_c = $schema->resultset('Url')->create(
        {
            url_address => $url,
            url_title => $title,
            url_description => $desc,
            url_submitted_by => $user_id
        }
    );
    for (@tags) {
        my $tag = $schema->resultset('Tag')->find({ tag_name => $_ });
        if ( $tag ) {
            $tag->update({ tag_count => $tag->tag_count + 1 })
        }
        else {
            $tag = $schema->resultset('Tag')->create(
                {
                    tag_name => $_,
                    tag_count => 1,
                }
            );
        }
        $schema->resultset('UrlTag')->create(
            {
                url_tags_url_id => $url_c->url_id,
                url_tags_tag_id => $tag->tag_id,
            }
        );
    }
    $self->render(text => 'fucking shit!');
}
sub comments {

}
1;
