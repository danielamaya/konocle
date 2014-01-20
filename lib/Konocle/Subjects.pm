package Konocle::Subjects;
use Mojo::Base 'Mojolicious::Controller';

sub subject {
    my $self = shift;
    my $subject = $self->param('subject');

    my $schema = $self->schema;

    my $category = $schema->resultset('Category')->find(
        {category_link_name => $subject}
    );

    my $disciplines = $schema->resultset('CategoriesDiscipline')->search(
        {categories_disciplines_category_id => $category->category_id},
        {
            join => 'categories_disciplines_discipline',
            '+select' => ['categories_disciplines_discipline.discipline_name'],
            '+as' => ['discipline_name'],
        }
    );

    $self->render(
        subject => $category->category_display_name,
        disciplines => $disciplines,
        wiki => $category->category_wiki,
    );
}

sub top {
    my $self = shift;
    my $subject = $self->param('subject');

}
1;
