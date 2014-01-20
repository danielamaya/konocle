use utf8;
package Konocle::DB::Schema::Result::Discipline;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Discipline

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<disciplines>

=cut

__PACKAGE__->table("disciplines");

=head1 ACCESSORS

=head2 discipline_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'disciplines_discipline_id_seq'

=head2 discipline_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 discipline_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 discipline_description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "discipline_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "disciplines_discipline_id_seq",
  },
  "discipline_name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "discipline_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "discipline_description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</discipline_id>

=back

=cut

__PACKAGE__->set_primary_key("discipline_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<Discipline Name Unique>

=over 4

=item * L</discipline_name>

=back

=cut

__PACKAGE__->add_unique_constraint("Discipline Name Unique", ["discipline_name"]);

=head1 RELATIONS

=head2 categories_disciplines

Type: has_many

Related object: L<Konocle::DB::Schema::Result::CategoriesDiscipline>

=cut

__PACKAGE__->has_many(
  "categories_disciplines",
  "Konocle::DB::Schema::Result::CategoriesDiscipline",
  {
    "foreign.categories_disciplines_discipline_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 disciplines_posts

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesPost>

=cut

__PACKAGE__->has_many(
  "disciplines_posts",
  "Konocle::DB::Schema::Result::DisciplinesPost",
  {
    "foreign.disciplines_posts_discipline_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 disciplines_requests

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesRequest>

=cut

__PACKAGE__->has_many(
  "disciplines_requests",
  "Konocle::DB::Schema::Result::DisciplinesRequest",
  {
    "foreign.disciplines_requests_discipline_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 disciplines_to_parents_disciplines_to_parents_children

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesToParent>

=cut

__PACKAGE__->has_many(
  "disciplines_to_parents_disciplines_to_parents_children",
  "Konocle::DB::Schema::Result::DisciplinesToParent",
  {
    "foreign.disciplines_to_parents_child_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 disciplines_to_parents_disciplines_to_parents_parents

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesToParent>

=cut

__PACKAGE__->has_many(
  "disciplines_to_parents_disciplines_to_parents_parents",
  "Konocle::DB::Schema::Result::DisciplinesToParent",
  {
    "foreign.disciplines_to_parents_parent_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 disciplines_urls

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesUrl>

=cut

__PACKAGE__->has_many(
  "disciplines_urls",
  "Konocle::DB::Schema::Result::DisciplinesUrl",
  {
    "foreign.disciplines_urls_discipline_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_disciplines

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsDiscipline>

=cut

__PACKAGE__->has_many(
  "tags_disciplines",
  "Konocle::DB::Schema::Result::TagsDiscipline",
  {
    "foreign.tags_disciplines_discipline_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_disciplines

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersDiscipline>

=cut

__PACKAGE__->has_many(
  "users_disciplines",
  "Konocle::DB::Schema::Result::UsersDiscipline",
  {
    "foreign.users_disciplines_discipline_id" => "self.discipline_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mjyj6SjPtbFqeolJrYQ2PA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
